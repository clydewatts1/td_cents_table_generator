WITH
    /* Stop Sell CTE  */
    STPSEL AS (
        SELECT DISTINCT
            item_wid,
            loc_wid,
            pmk_stop_sell
        FROM DW${INSTANCE}A_IDW.PMK_LOC_ITEM AS PLI
        WHERE
            cur_flg = 'Y'
            AND pmk_stop_sell = 'Y'
            AND ssor_id = 4
            AND level_cd = 'PSR_BLK'
    ),
    /* Soiled and Damaged Adjustments */
    /* This is a running weekly total */
    INV_VOL AS (
        SELECT
            invtry_tsactn_id,
            invtry_tsactn_wid,
            loc_id,
            loc_wid,
            invtry_rsn_cd,
            pmk_tsactn_comts_txt,
            eff_from_dttm,
            eff_to_dttm,
            cur_flg,
            del_flg,
            ssor_id,
            tsactn_type_cd
        FROM DW${INSTANCE}A_IDW.INVTRY_TSACTN AS INV
        WHERE
            (
                TRUNC(INV.eff_from_dttm) BETWEEN DATE '${LDTK_DATE}' AND DATE '${LDTK_DATE}' + 1
                OR TRUNC(INV.eff_to_dttm) BETWEEN DATE '${LDTK_DATE}' AND '${LDTK_DATE}' + 1
            )
            AND INV.cur_flg = 'Y'
            AND INV.ssor_id <> 3
            AND INV.tsactn_type_cd = 'STA'
    ),
    STK_ADJS_TY AS (
        SELECT DISTINCT -- Same as group by
            I.invtry_tsactn_id AS stock_adjustment_id,
            I.loc_id AS location_id,
            I.loc_wid,
            I.invtry_rsn_cd AS stock_adjustment_reason_cd,
            I.pmk_tsactn_comts_txt AS stock_adjustment_comment,
            ITM.item_id AS item_id,
            ITM.item_wid,
            ITM.cmpltn_dttm AS stock_adjustment_date,
            ITM.item_adjst_qty AS stock_adjustment_units,
            I.eff_from_dttm AS effective_from_dt,
            I.eff_to_dttm AS effective_to_dt,
            CASE WHEN I.cur_flg || ITM.cur_flg = 'YY' THEN 'Y' ELSE 'N' END AS current_flg,
            I.del_flg AS delete_flg,
            I.ssor_id AS src_system_id
        FROM INV_VOL AS I
        INNER JOIN DW${INSTANCE}A_IDW.INVTRY_TSACTN_ITEM AS ITM
            ON I.invtry_tsactn_wid = ITM.invtry_tsactn_wid
                AND I.invtry_tsactn_id = ITM.invtry_tsactn_id
                AND I.tsactn_type_cd = 'STA'
                AND ITM.ssor_id <> 3
        WHERE
            I.ssor_id <> 3
    ),
    STK_ADJ AS (
        SELECT
            loc_wid,
            item_wid,
            /* Always use "RUNDATE" */
            DATE '${LDTK_DATE}' AS business_date,
            CASE
                WHEN stock_adjustment_reason_cd IN (110, 522, 82, 560, 81, 707)
                    THEN stock_adjustment_units
            END AS damaged_adjustment_units,
            CASE
                WHEN stock_adjustment_reason_cd IN (703, 704, 714, 724, 725)
                    THEN stock_adjustment_units
            END AS soiled_adjustment_units,
            CASE
                WHEN stock_adjustment_reason_cd IN (721, 720)
                    THEN stock_adjustment_units
            END AS auto_adjustment_units,
            CASE
                WHEN stock_adjustment_reason_cd IN (141)
                    THEN stock_adjustment_units
            END AS stock_count_adjustment_units,
            CASE
                WHEN stock_adjustment_reason_cd IS NULL
                    THEN 0.0000
                WHEN stock_adjustment_reason_cd NOT IN (110, 522, 82, 560, 81, 714, 721, 720, 707, 703, 704, 724, 725)
                    THEN stock_adjustment_units
            END AS other_adjustment_units
        FROM STK_ADJS_TY AS STK_ADJS_TY --RFC 17880/CHG0031571- CAST AS DATE APPLIED
        WHERE
            current_flg = 'Y'
            /* Get a accrued adjustment total for the week , so the date range will be from sunday - start of week
               to end of week */
            /* Use RUNDATE AS date '2025-08-07' */
            AND CAST(STK_ADJS_TY.stock_adjustment_date AS DATE) BETWEEN TD_SUNDAY(DATE '${LDTK_DATE}') AND TD_SUNDAY(DATE '${LDTK_DATE}') + 6
    ),
    STADJ AS (
        SELECT
            STK_ADJ.loc_wid,
            STK_ADJ.item_wid,
            STK_ADJ.business_date,
            CAST(SUM(STK_ADJ.damaged_adjustment_units) AS INTEGER) AS damaged_adjustment_units,
            CAST(SUM(STK_ADJ.soiled_adjustment_units) AS INTEGER) AS soiled_adjustment_units,
            CAST(SUM(STK_ADJ.auto_adjustment_units) AS INTEGER) AS auto_adjustment_units,
            CAST(SUM(STK_ADJ.stock_count_adjustment_units) AS INTEGER) AS stock_count_adjustment_units,
            CAST(SUM(STK_ADJ.other_adjustment_units) AS INTEGER) AS other_adjustment_units
        FROM STK_ADJ
        GROUP BY 1, 2, 3
    ),
    -- Markdowns
    MKD AS (
        SELECT
            item_wid,
            loc_wid AS loc_wid, -- in this case location id defined as bigint
            DATE '${LDTK_DATE}' AS business_date,
            listed_flag AS listing_flg
        FROM DW${INSTANCE}A_ACC_ORR.DW_STOCK_MARKDOWN_DAILY_FV AS MKD1
        WHERE
            MKD1.current_flag = 'Y'
            AND MKD1.status = 'L'
            /* Get markdown at point in time */
            AND DATE '${LDTK_DATE}' BETWEEN MKD1.item_price_from_date AND MKD1.item_price_to_date
            /* Only interested in markdowns */
            AND MKD1.price_change_flag = 'MARKDOWN'
        QUALIFY ROW_NUMBER() OVER (PARTITION BY item_wid, loc_wid ORDER BY item_price_from_date DESC, item_price_to_date DESC, effective_from_dt DESC, effective_to_dt DESC) = 1
    ),
    -- Price Type
    PRCT AS (
        SELECT
            IPD.item_wid,
            IPD.loc_wid,
            DATE '${LDTK_DATE}' AS business_date,
            price_change_type_code,
            CAST(CAL.calendar_week_id AS INTEGER) AS price_action_week,
            unit_retail_price AS unit_retail_amount,
            IPD.item_price_from_date
        FROM DW${INSTANCE}A_ACC_ORR.DW_ITEM_PRICE_DETAIL_FV AS IPD
        LEFT OUTER JOIN DW${INSTANCE}A_ACC_ORR.DW_PMK_ACCNTG_CAL_DV AS CAL
            ON CAST(item_price_from_date AS DATE) = CAL.calendar_day_id
            AND CAL.level_cd = 'DY'
            AND CAL.current_flg = 'Y'
        WHERE
            IPD.current_flag = 'Y'
            AND IPD.status LIKE '%executed%'
            AND DATE '${LDTK_DATE}' BETWEEN IPD.item_price_from_date AND IPD.item_price_to_date
        /* Ellimnate Duplicates this is in original code */
        QUALIFY ROW_NUMBER() OVER (PARTITION BY item_wid, loc_wid ORDER BY IPD.item_price_from_date, IPD.item_price_to_date DESC) = 1
    )
 -- main select To extract stock facts and calculated fields
SELECT
    STK.stock_inventory_date AS business_date,
    STK.location_wid AS loc_wid,
    STK.item_wid AS item_wid,
    setbit((0 (INTEGER)), 0, 1) AS fct_src_map,
    STK.soh_units AS location_soh_units,
    -- Only show depot SOH units for warehouse locations
    CASE
        WHEN LC.loc_sbtype_cd = 'W' THEN STK.soh_units
    END AS depot_soh_units,
    STK.soh_pack_units AS location_pack_units,
    -- Only show depot pack units for warehouse locations
    CASE
        WHEN LC.loc_sbtype_cd = 'W' THEN STK.soh_pack_units
    END AS depot_pack_units,
    STK.soh_retail_amount AS location_retail_amount,
    -- Only show depot retail amount for warehouse locations
    CASE
        WHEN LC.loc_sbtype_cd = 'W' THEN STK.soh_retail_amount
    END AS depot_retail_amount,
    STK.soh_cost_amount AS unit_cost_amount,
    STK.stock_unit_retail_amount AS unit_retail_amount, /* Also SSBI1068 */
    STK.on_order_units AS on_order_units,
    STK.on_order_cost_amount AS on_order_cost_amount,
    STK.on_order_retail_amount AS on_order_retail_amount,
    STK.on_order_pack_units AS on_order_pack_units,
    STK.return_to_vendor_cost_amount AS return_to_vendor_cost_amount,
    STK.return_to_vendor_retail_amount AS return_to_vendor_retail_amount,
    STK.return_to_vendor_units AS return_to_vendor_units,
    STK.return_to_vendor_pack_units AS return_to_vendor_pack_units,
    STK.transfer_expected_retail_amount AS transfer_expected_retail_amount,
    STK.transfer_expected_pack_units AS transfer_expected_pack_units,
    STK.transfer_reserved_cost_amount AS transfer_reserved_cost_amount,
    STK.transfer_expected_units AS transfer_expected_units,
    STK.transfer_reserved_retail_amount AS transfer_reserved_retail_amount,
    STK.transfer_reserved_pack_units AS transfer_reserved_pack_units,
    STK.transfer_expected_cost_amount AS transfer_expected_cost_amount,
    STK.transfer_reserved_units AS transfer_reserved_units,
    STK.in_transit_retail_amount AS in_transit_retail_amount,
    STK.in_transit_pack_units AS in_transit_pack_units,
    STK.in_transit_units AS in_transit_units,
    STK.in_transit_cost_amount AS in_transit_cost_amount,
    STK.non_sellable_retail_amount AS non_sellable_retail_amount,
    STK.non_sellable_pack_units AS non_sellable_pack_units,
    STK.non_sellable_cost_amount AS non_sellable_cost_amount,
    STK.non_sellable_units AS non_sellable_units,
    -- PSR blocked fields: only set if item/location is in stpsel (stop sell)
    CASE
        WHEN STPSEL.pmk_stop_sell IS NULL
            OR STPSEL.pmk_stop_sell = 'N'
            THEN 0
        ELSE STK.soh_units
    END AS psr_blocked_units,
    CASE
        WHEN STPSEL.pmk_stop_sell IS NULL
            OR STPSEL.pmk_stop_sell = 'N'
            THEN 0
        ELSE STK.soh_retail_amount
    END AS psr_retail_amount,
    CASE
        WHEN STPSEL.pmk_stop_sell IS NULL
            OR STPSEL.pmk_stop_sell = 'N'
            THEN 0
        ELSE STK.soh_pack_units
    END AS psr_blocked_pack_units,
    CASE
        WHEN STPSEL.pmk_stop_sell IS NULL
            OR STPSEL.pmk_stop_sell = 'N'
            THEN 0
        ELSE STK.soh_cost_amount
    END AS psr_blocked_cost_amount,
    -- Carryover fields: only set if item is flagged as carryover
    CASE
        WHEN ITM.pmk_caryovr = 'Y'
            THEN STK.soh_units
        ELSE 0
    END AS carryover_units,
    CASE
        WHEN ITM.pmk_caryovr = 'Y'
            THEN STK.soh_retail_amount
        ELSE 0
    END AS carryover_value,
    STK.stock_unit_av_cost_amount AS stock_unit_av_cost_amount,
    STK.regular_unit_retail_amt AS regular_unit_retail_amt,
    /* Adjustements SSBI1061 */
    STADJ.damaged_adjustment_units AS damaged_adjustment_units,
    (STADJ.damaged_adjustment_units * STK.stock_unit_retail_amount) AS damaged_adjustment_amount,
    STADJ.soiled_adjustment_units AS soiled_adjustment_units,
    (STADJ.soiled_adjustment_units * STK.stock_unit_retail_amount) AS soiled_adjustment_amount,
    STADJ.auto_adjustment_units AS auto_adjustment_units,
    (STADJ.auto_adjustment_units * STK.stock_unit_retail_amount) AS auto_adjustment_amount,
    STADJ.other_adjustment_units AS other_adjustment_units,
    (STADJ.other_adjustment_units * STK.stock_unit_retail_amount) AS other_adjustment_amount,
    STADJ.stock_count_adjustment_units AS stock_cnt_adj_units,
    STADJ.stock_count_adjustment_units * STK.stock_unit_retail_amount AS stock_cnt_adj_retail_value,
    /* Markdown Listed SSBI1069 */
    CASE
        WHEN MKD.listing_flg = 'Y'
            THEN STK.soh_units
        ELSE 0
    END AS listed_stock,
    MKD.listing_flg AS listing_flg,
    /* Price Statys SSBI1068 */
    CASE
        WHEN PRCT.price_change_type_code = 'P'
            THEN (STK.soh_units * COALESCE(PRCT.unit_retail_amount, STK.stock_unit_retail_amount))
        ELSE 0
    END AS nlp_stock_value,
    CASE
        WHEN PRCT.price_change_type_code = 'P'
            THEN STK.soh_units
        ELSE 0
    END AS nlp_stock_units,
    CASE
        WHEN PRCT.price_change_type_code = 'C'
            THEN STK.soh_units
        ELSE 0
    END AS ras_units,
    CASE
        WHEN PRCT.price_change_type_code = 'C'
            THEN (STK.soh_units * COALESCE(PRCT.unit_retail_amount, STK.stock_unit_retail_amount))
        ELSE 0
    END AS ras_stock_value,
    PRCT.price_action_week AS price_action_week,
    DECODE(PRCT.price_change_type_code, 'R', 'Regular', 'C', 'Clearance', 'P', 'Promotion', 'Regular') AS price_status
FROM DW${INSTANCE}A_ACC_ORR.DW_STOCK_POSITION_DY_FV AS STK
/* Join to LOC to get location type W and S */
INNER JOIN DW${INSTANCE}A_IDW.LOC AS LC
    ON LC.loc_wid = STK.location_wid
    AND LC.cur_flg = 'Y'
    /* Only stores and depot */
    AND LC.loc_sbtype_cd IN ('W', 'S')
/* Join to Item  to get carry over indicator */
INNER JOIN DW${INSTANCE}A_IDW.ITEM AS ITM
    ON ITM.item_wid = STK.item_wid
    AND ITM.cur_flg = 'Y'
/* Join to stop sell to determine which items/sku */
LEFT OUTER JOIN STPSEL
    ON STK.item_wid = STPSEL.item_wid
    AND STK.location_wid = STPSEL.loc_wid
/* Join to Soiled and Damaged adjustments */
LEFT OUTER JOIN STADJ
    ON STK.item_wid = STADJ.item_wid
    AND STK.location_wid = STADJ.loc_wid
    AND STK.stock_inventory_date = STADJ.business_date
/* Mark down listed flag */
LEFT OUTER JOIN MKD
    ON STK.item_wid = MKD.item_wid
    AND STK.location_wid = MKD.loc_wid
    AND STK.stock_inventory_date = MKD.business_date
LEFT OUTER JOIN PRCT
    ON STK.item_wid = PRCT.item_wid
    AND STK.location_wid = PRCT.loc_wid
    AND STK.stock_inventory_date = PRCT.business_date
WHERE
    STK.stock_inventory_date = DATE '${LDTK_DATE}'  /* Use RUNDATE */
    -- Only include rows where at least one stock or transfer metric is non-zero
    AND (
        /* Determine if a row has some non-zero */
        COALESCE(soh_units, 0) <> 0
        OR COALESCE(soh_pack_units, 0) <> 0
        OR COALESCE(on_order_units, 0) <> 0
        OR COALESCE(on_order_pack_units, 0) <> 0
        OR COALESCE(in_transit_units, 0) <> 0
        OR COALESCE(in_transit_pack_units, 0) <> 0
        OR COALESCE(transfer_reserved_units, 0) <> 0
        OR COALESCE(transfer_reserved_pack_units, 0) <> 0
        OR COALESCE(transfer_expected_units, 0) <> 0
        OR COALESCE(transfer_expected_pack_units, 0) <> 0
        OR COALESCE(non_sellable_units, 0) <> 0
        OR COALESCE(non_sellable_pack_units, 0) <> 0
        OR COALESCE(return_to_vendor_units, 0) <> 0
        OR COALESCE(return_to_vendor_pack_units, 0) <> 0
        OR COALESCE(soh_cost_amount, 0) <> 0
        OR COALESCE(soh_retail_amount, 0) <> 0
        OR COALESCE(on_order_cost_amount, 0) <> 0
        OR COALESCE(on_order_retail_amount, 0) <> 0
        OR COALESCE(in_transit_cost_amount, 0) <> 0
        OR COALESCE(in_transit_retail_amount, 0) <> 0
        OR COALESCE(transfer_reserved_cost_amount, 0) <> 0
        OR COALESCE(transfer_reserved_retail_amount, 0) <> 0
        OR COALESCE(transfer_expected_cost_amount, 0) <> 0
        OR COALESCE(transfer_expected_retail_amount, 0) <> 0
        OR COALESCE(non_sellable_cost_amount, 0) <> 0
        OR COALESCE(non_sellable_retail_amount, 0) <> 0
        OR COALESCE(return_to_vendor_cost_amount, 0) <> 0
        OR COALESCE(return_to_vendor_retail_amount, 0) <> 0
        OR COALESCE(damaged_adjustment_units, 0) <> 0
        OR COALESCE(soiled_adjustment_units, 0) <> 0
        OR COALESCE(auto_adjustment_units, 0) <> 0
        OR COALESCE(other_adjustment_units, 0) <> 0
        OR COALESCE(stock_cnt_adj_units, 0) <> 0
    )
/* TODO: Remove before volume testing */
SAMPLE 1000000
;