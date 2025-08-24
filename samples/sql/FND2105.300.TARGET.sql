WITH TSF AS ( /* SSBI1067 */
/* Stock transfer summary */
    SELECT
        item_wid,
        business_date,
        location_wid,
        transfer_outst_units,
        (transfer_outst_units * to_loc_unit_sell_val) AS transfer_outst_retail_value,
        (transfer_outst_units * to_loc_unit_cost_val) AS transfer_outst_cost_value
    FROM
        (
            SELECT
                TSP.to_location_wid AS location_wid,
                TSP.item_wid,
                date '${LDTK_DATE}' AS business_date,
                (SUM(TSP.transfer_qty) - SUM(TSP.shipped_qty)) AS transfer_outst_units,
                MAX(TSP.to_loc_unit_sell_val) AS to_loc_unit_sell_val,
                MAX(TSP.to_loc_unit_cost_val) AS to_loc_unit_cost_val
            FROM
                DWP01A_ACC_ORR.dw_stock_transfer_ln_fv AS TSP
            WHERE
                /* Accumated sum of the week */
                CAST(TSP.transfer_dt AS DATE) BETWEEN date '${WEEK_START_DT}'AND date '${WEEK_START_DT}'+ 6
                AND current_flg = 'Y'
            GROUP BY
                1,
                2,
3
            HAVING
                transfer_outst_units IS NOT NULL
        ) AS TSF_1
),
TCV AS ( /* SSBI1066 */
    SELECT
        INV.loc_wid AS location_wid,
        ITM.item_wid,
        date '${LDTK_DATE}' AS business_date,
        SUM(INTI.item_adjst_qty * ITM.pmk_unit_cost_amt) AS transfer_act_repo_cost_value
    FROM
        DWP01A_IDW.pmk_trsfr_wo_item AS ITM
    INNER JOIN
        DWP01A_IDW.invtry_tsactn AS INV
        ON ITM.invtry_tsactn_wid = INV.invtry_tsactn_wid AND INV.cur_flg = 'Y'
    INNER JOIN
        DWP01A_IDW.invtry_tsactn_item AS INTI
        ON ITM.invtry_tsactn_wid = INTI.invtry_tsactn_wid
        AND ITM.item_wid = INTI.item_wid
        AND INTI.cur_flg = 'Y'
    INNER JOIN
        DWP01A_IDW.pmk_trsfr_wo AS WO
        ON INV.invtry_tsactn_wid = WO.invtry_tsactn_wid AND WO.cur_flg = 'Y'
    WHERE
        WO.pmk_wo_dttm IS NOT NULL
        AND ITM.cur_flg = 'Y'
        /* Accumated sum of the week */
        AND WO.pmk_wo_dttm BETWEEN date '${WEEK_START_DT}'AND date '${LDTK_DATE}'
    GROUP BY
        1,
        2,
3
),
/* Stock counts */
STC AS ( /* SSBI1064 */
    SELECT
        item_wid,
        loc_wid AS location_wid,
        date '${LDTK_DATE}' AS business_date,
        /* Note : This is incorrect this is based on origal calculation
                  It assumes a manual count is at most once a week */
        SUM(stock_count_units) AS stock_count_units,
        SUM(stock_count_snapshot_units) AS stock_count_snapshot_units,
        SUM(stock_count_retail_amt) AS stock_count_retail_amt,
        SUM(stock_count_snapshot_retail_amt) AS stock_count_snapshot_retail_amt,
        SUM(stock_count_snapshot_units) - SUM(stock_count_units) AS total_stock_loss_units,
        SUM(stock_count_snapshot_retail_amt) - SUM(stock_count_retail_amt) AS total_stock_loss_value
    FROM
        DWP01A_ACC_ORR.dw_stock_count_line_fv AS STK_CNT_TY
    WHERE
        /* Accumated sum of the week */
        STK_CNT_TY.stock_count_dt BETWEEN date '${WEEK_START_DT}' AND date '${LDTK_DATE}'
        AND current_flg = 'Y'
    GROUP BY
        1,
        2,
3
),
TSFC AS ( /* SSBI1065 */
    /* transfer costs */
    SELECT
        STC1.item_wid,
        STC1.to_location_wid AS location_wid,
        date '${LDTK_DATE}' AS business_date,
        SUM(STC1.cost_val) AS transfer_act_upchrg_unit_cost,
        SUM(STC1.cost_val * DSOH.soh_retail_amount) AS transfer_act_upchrg_cost_value
    FROM
        DWP01A_ACC_ORR.dw_stock_transfer_ln_cost_fv AS STC1
    INNER JOIN
        DSOH
        ON DSOH.item_wid = STC1.item_wid
        AND DSOH.location_wid = STC1.to_location_wid
    WHERE
        /* Accumated sum of the week */
        STC1.transfer_dt BETWEEN date '${WEEK_START_DT}' AND date '${LDTK_DATE}'
        AND current_flg = 'Y'
    GROUP BY
        1,
        2,
3
    HAVING
        transfer_act_upchrg_unit_cost IS NOT NULL
),
TSFI AS ( /* SSBI1064 */
/* received stock */
    SELECT
        item_wid,
        location_wid,
        date '${LDTK_DATE}' AS business_date,
        SUM(TSFRL.received_qty) AS tsf_intake_qty,
        SUM(TSFRL.received_qty * TSFRL.unit_sell_price_amt) AS tsf_intake_retail_amount,
        SUM(TSFRL.received_qty * TSFRL.unit_cost_amt) AS tsf_intake_cost_amount
    FROM
        DWP01A_ACC_ORR.dw_tsf_receipt_ln_fv AS TSFRL
    WHERE
        /* Accumated sum of the week */
        CAST(TSFRL.receipt_dt AS DATE) BETWEEN date '${WEEK_START_DT}'AND date '${LDTK_DATE}'
    GROUP BY
        1,
        2,
3
),
TSFSHP AS ( /* SSBI1063 - Get the shipping quantity for a transfer */
    /* shipping */
    SELECT
        TSF_TY.from_location_wid AS location_wid,
        TSF_TY.item_wid,
        date '${LDTK_DATE}' AS business_date,
        SUM(SP_TY.shipped_qty) AS trasfer_ship_units, /* Primark Week accumulated total */
        SUM(SP_TY.shipped_qty * SP_TY.selling_value_per_unit) AS trasfer_ship_retail_amount,
        SUM(SP_TY.shipped_qty * SP_TY.cost_value_per_unit) AS trasfer_ship_cost_amount
    FROM
        DWP01A_ACC_ORR.dw_stock_transfer_ln_fv AS TSF_TY /* Stock transfers at transaction/item */
    INNER JOIN
        DWP01A_ACC_ORR.dw_shipment_ln_fv AS SP_TY /* shipping at transaction/item */
        ON TSF_TY.invtry_tsactn_wid = SP_TY.transfer_wid /* join on transaction , item for current rows only */
        AND TSF_TY.item_wid = SP_TY.item_wid
        AND SP_TY.current_flg = 'Y'
    WHERE
        TSF_TY.current_flg = 'Y'
        AND SP_TY.shipment_dt BETWEEN date '${WEEK_START_DT}'AND date '${LDTK_DATE}' /* For This primark Week */
    GROUP BY
        1,
        2,
3
),
STKA AS (
    SELECT
        item_wid,
        loc_wid AS location_wid,
        date '${LDTK_DATE}' AS business_date,
        CEILING((date '${LDTK_DATE}') - CAST(first_stock_inventory_dt AS DATE)) / 7 AS soh_age_in_weeks
    FROM
        DWP01A_ACC_ORR.dw_aged_stock_dtls_fv
    WHERE
        current_flg = 'Y'
),
LC AS (
  /* map wid to id */
    SELECT
        loc_id AS location_id,
        loc_wid AS location_wid
    FROM
        DWP01A_IDW.loc
    WHERE
        loc_sbtype_cd IN ('W', 'S')
        AND cur_flg = 'Y'
),
ITM AS (
  /* map wid to id */
    SELECT
        item_id,
        item_wid
    FROM
        DWP01A_IDW.item
    WHERE
        cur_flg = 'Y'
),
DSOH AS (
  /* get retail amount from stock pos */
    SELECT
        item_wid,
        location_wid,
        soh_retail_amount
    FROM
        dwp01a_acc_orr.dw_stock_position_dy_fv
    WHERE
        stock_inventory_date = date '${LDTK_DATE}'
),
FCT AS (
    /* all stock measures
          do full outer joins to get all combinations
          TODO: Make this more efficient
    */
    SELECT
        COALESCE(TSF.business_date, TCV.business_date, STC.business_date,TSFC.business_date,TSFI.business_date,TSFSHP.business_date,STKA.business_date) AS business_date,
        COALESCE(TSF.location_wid, TCV.location_wid, STC.location_wid,TSFC.location_wid,TSFI.location_wid,TSFSHP.location_wid,STKA.location_wid) AS loc_wid,
        COALESCE(TSF.item_wid, TCV.item_wid, STC.item_wid,TSFC.item_wid,TSFI.item_wid,TSFSHP.item_wid,STKA.item_wid) AS item_wid,
        SUM(TSF.transfer_outst_units) AS transfer_outst_units,
        SUM(TSF.transfer_outst_retail_value) AS transfer_outst_retail_value,
        SUM(TSF.transfer_outst_cost_value) AS transfer_outst_cost_value,
        SUM(TCV.transfer_act_repo_cost_value) AS transfer_act_repo_cost_value,
        SUM(TSFC.transfer_act_upchrg_unit_cost) AS transfer_act_upchrg_unit_cost,
        SUM(TSFC.transfer_act_upchrg_cost_value) AS transfer_act_upchrg_cost_value,
        SUM(STC.stock_count_units) AS stock_count_units,
        SUM(STC.stock_count_snapshot_units) AS stock_count_snapshot_units,
        SUM(STC.stock_count_retail_amt) AS stock_count_retail_amt,
        SUM(STC.stock_count_snapshot_retail_amt) AS stock_count_snapshot_retail_amt,
        SUM(STC.total_stock_loss_units) AS total_stock_loss_units,
        SUM(STC.total_stock_loss_value) AS total_stock_loss_value,
        SUM(TSFI.tsf_intake_qty) AS tsf_intake_qty,
        SUM(TSFI.tsf_intake_retail_amount) AS tsf_intake_retail_amount,
        SUM(TSFI.tsf_intake_cost_amount) AS tsf_intake_cost_amount,
        SUM(TSFSHP.trasfer_ship_units) AS trasfer_ship_units,
        SUM(TSFSHP.trasfer_ship_retail_amount) AS trasfer_ship_retail_amount,
        SUM(TSFSHP.trasfer_ship_cost_amount) AS trasfer_ship_cost_amount,
        SUM(STKA.soh_age_in_weeks) AS soh_age_in_weeks
    FROM TSF
    FULL OUTER JOIN TCV
        ON TSF.location_wid = TCV.location_wid
        AND TSF.item_wid = TCV.item_wid
        AND TSF.business_date = TCV.business_date
    FULL OUTER JOIN STC
        ON STC.location_wid = TSF.location_wid
        AND STC.item_wid = TSF.item_wid
        AND STC.business_date = TSF.business_date
    FULL OUTER JOIN TSFC
        ON TSF.location_wid = TSFC.location_wid
        AND TSF.item_wid = TSFC.item_wid
        AND TSF.business_date = TSFC.business_date
    FULL OUTER JOIN TSFI
        ON TSF.location_wid = TSFI.location_wid
        AND TSF.item_wid = TSFI.item_wid
        AND TSF.business_date = TSFI.business_date
    FULL OUTER JOIN TSFSHP
        ON TSF.location_wid = TSFSHP.location_wid
        AND TSF.item_wid = TSFSHP.item_wid
        AND TSF.business_date = TSFSHP.business_date
    FULL OUTER JOIN STKA
        ON TSF.location_wid = STKA.location_wid
        AND TSF.item_wid = STKA.item_wid
        AND TSF.business_date = STKA.business_date
  GROUP BY 1,2,3
)
SELECT
    FCT.business_date,
    FCT.loc_wid,
    FCT.item_wid,
    setbit((0(INTEGER)),1,1) as fct_src_map,
    FCT.transfer_outst_units,
    FCT.transfer_outst_retail_value,
    FCT.transfer_outst_cost_value,
    FCT.transfer_act_repo_cost_value,
    FCT.transfer_act_upchrg_unit_cost,
    FCT.transfer_act_upchrg_cost_value,
    FCT.stock_count_units,
    FCT.stock_count_snapshot_units,
    FCT.stock_count_retail_amt,
    FCT.stock_count_snapshot_retail_amt,
    FCT.total_stock_loss_units,
    FCT.total_stock_loss_value,
    FCT.tsf_intake_qty,
    FCT.tsf_intake_retail_amount,
    FCT.tsf_intake_cost_amount,
    FCT.trasfer_ship_units,
    FCT.trasfer_ship_retail_amount,
    FCT.trasfer_ship_cost_amount
FROM FCT
WHERE
   /* Check for all zero rows */
    COALESCE(FCT.transfer_outst_units, 0) <> 0
    OR COALESCE(FCT.transfer_outst_units, 0) <> 0
    OR COALESCE(FCT.transfer_outst_retail_value, 0) <> 0
    OR COALESCE(FCT.transfer_outst_cost_value, 0) <> 0
    OR COALESCE(FCT.transfer_act_repo_cost_value, 0) <> 0
    OR COALESCE(FCT.stock_count_units, 0) <> 0
    OR COALESCE(FCT.stock_count_snapshot_units, 0) <> 0
    OR COALESCE(FCT.stock_count_retail_amt, 0) <> 0
    OR COALESCE(FCT.stock_count_snapshot_retail_amt, 0) <> 0
    OR COALESCE(FCT.transfer_act_upchrg_cost_value, 0) <> 0
    OR COALESCE(FCT.stock_count_units, 0) <> 0
    OR COALESCE(FCT.stock_count_snapshot_units, 0) <> 0
    OR COALESCE(FCT.stock_count_retail_amt, 0) <> 0
    OR COALESCE(FCT.stock_count_snapshot_retail_amt, 0) <> 0
    OR COALESCE(FCT.tsf_intake_qty, 0) <> 0
    OR COALESCE(FCT.tsf_intake_retail_amount, 0) <> 0
    OR COALESCE(FCT.tsf_intake_cost_amount, 0) <> 0
    OR COALESCE(FCT.trasfer_ship_units, 0) <> 0
    OR COALESCE(FCT.trasfer_ship_retail_amount, 0) <> 0
    OR COALESCE(FCT.trasfer_ship_cost_amount, 0) <> 0;