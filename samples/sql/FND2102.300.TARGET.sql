WITH 
/* Stop Sell CTE  */
 stpsel AS (
    SELECT DISTINCT
        item_id,
        loc_id,
        pmk_stop_sell
    FROM dwp01a_idw.pmk_loc_item AS pli
    WHERE cur_flg = 'Y'
        AND pmk_stop_sell = 'Y'
        AND ssor_id = 4
        AND level_cd = 'PSR_BLK'
),
/* Soiled and Damaged Adjustments */
/* This is a running weekly total */
 STADJ AS
  (
  SELECT STK_ADJ.Location_Id,
    STK_ADJ.item_id,
    STK_ADJ.business_date,
    CAST(SUM(STK_ADJ.Damaged_Adjustment_Units) AS INTEGER)     AS Damaged_Adjustment_Units,
    CAST(SUM(STK_ADJ.Soiled_Adjustment_Units) AS INTEGER)      AS Soiled_Adjustment_Units,
    CAST(SUM(STK_ADJ.Auto_Adjustment_Units) AS INTEGER)        AS Auto_Adjustment_Units,
    CAST(SUM(STK_ADJ.Stock_Count_Adjustment_Units) AS INTEGER)   AS Stock_Count_Adjustment_Units,
    CAST(SUM(STK_ADJ.other_Adjustment_Units) AS INTEGER)        AS other_Adjustment_Units
  FROM
    (
     SELECT Location_Id,
      Item_Id,
      /* Always use "RUNDATE" */
      date '${LDTK_DATE}' as business_date,
      CASE
        WHEN Stock_Adjustment_Reason_Cd IN (110,522,82,560,81,707)
        THEN Stock_Adjustment_Units
      END AS Damaged_Adjustment_Units,
      CASE
        WHEN Stock_Adjustment_Reason_Cd IN (703,704,714,724,725)
        THEN Stock_Adjustment_Units
      END AS Soiled_Adjustment_Units,
      CASE
        WHEN Stock_Adjustment_Reason_Cd IN (721,720)
        THEN Stock_Adjustment_Units
      END AS Auto_Adjustment_Units,
      CASE
        WHEN Stock_Adjustment_Reason_Cd IN (141)
        THEN Stock_Adjustment_Units
      END AS Stock_Count_Adjustment_Units,
       CASE WHEN Stock_Adjustment_Reason_Cd IS NULL THEN 0.0000
        WHEN Stock_Adjustment_Reason_Cd NOT IN (110,522,82,560,81,714,721,720,707,703,704,724,725)
        THEN Stock_Adjustment_Units
      END AS other_Adjustment_Units
    FROM DWP01A_ACC_ORR.DW_STOCK_ADJST_LN_FV STK_ADJS_TY
/*RFC 17880/CHG0031571- CAST AS DATE APPLIED*/  
   -- cross join VOL_DY_TY AS  ty
    WHERE Current_Flg = 'Y'  
    /* Get a accrued adjustment total for the week , so the date range will be from sunday - start of week
       to end of week */
    /* Use RUNDATE AS date '${LDTK_DATE}' */
    AND  CAST(STK_ADJS_TY.Stock_Adjustment_Date AS DATE)  BETWEEN TD_SUNDAY(date '${LDTK_DATE}') AND TD_SUNDAY(date '${LDTK_DATE}')+6
    ) STK_ADJ
  GROUP BY 1,2,3
    ) ,
-- Markdowns
MKD AS (
SELECT item_id,
    TRIM(location_id) AS location_id, -- in this case location id defined as bigint 
    date '${LDTK_DATE}' AS Business_Date,
    LISTED_FLAG AS listing_flg
  FROM DWP01A_ACC_ORR.DW_STOCK_MARKDOWN_DAILY_FV  AS MKD1 
  WHERE MKD1.Current_Flag = 'Y' 
    AND MKD1.Status ='L'
    /* Get markdown at point in time */
    AND date '${LDTK_DATE}' between MKD1.Item_Price_From_Date and MKD1.Item_Price_To_Date  
    /* Only interested in markdowns */
    AND MKD1.Price_Change_Flag = 'MARKDOWN'  
qualify row_number() over (partition by ITEM_ID,LOCATION_ID
 /* Remove duplicates - there are */
 order by Item_Price_From_Date DESC,Item_Price_To_Date DESC,Effective_From_Dt DESC,Effective_To_Dt DESC) = 1
 
),
-- Price Type
PRCT AS (
SELECT 
    IPD.Item_id,
    IPD.Location_id,
    date '${LDTK_DATE}' AS business_date,
    Price_Change_Type_Code,
    CAST(cal.Calendar_Week_Id AS INTEGER) as Price_Action_Week ,
    Unit_Retail_Price AS UNIT_RETAIL_AMOUNT,
    IPD.Item_Price_From_Date
  FROM DWP01A_ACC_ORR.DW_ITEM_PRICE_DETAIL_FV as IPD
  left outer join DWP01A_ACC_ORR.DW_PMK_ACCNTG_CAL_DV AS cal
  on CAST(Item_Price_From_Date AS DATE) = cal.Calendar_Day_Id
  and cal.level_cd = 'DY'
  and cal.current_flg = 'Y'
 WHERE IPD.Current_Flag = 'Y' 
  AND IPD.Status like '%executed%'
  AND date '${LDTK_DATE}' between IPD.Item_Price_From_Date and IPD.Item_Price_To_Date
 /* Ellimnate Duplicates this is in original code */
 QUALIFY ROW_NUMBER() OVER (PARTITION BY Item_id,Location_id 
   ORDER BY IPD.Item_Price_From_Date ,IPD.Item_Price_To_Date DESC)=1
)
-- Main SELECT to extract stock facts and calculated fields
SELECT
    stk.stock_inventory_date AS business_date,
    stk.location_id AS location_id,
    stk.item_id AS item_id,
    setbit((0(INTEGER)),0,1) as fct_src_map,
    stk.soh_units AS location_soh_units,
    -- Only show depot SOH units for warehouse locations
    CASE
        WHEN lc.loc_sbtype_cd = 'W' THEN stk.soh_units
    END AS depot_soh_units,
    stk.soh_pack_units AS location_pack_units,
    -- Only show depot pack units for warehouse locations
    CASE
        WHEN lc.loc_sbtype_cd = 'W' THEN stk.soh_pack_units
    END AS depot_pack_units,
    stk.soh_retail_amount AS location_retail_amount,
    -- Only show depot retail amount for warehouse locations
    CASE
        WHEN lc.loc_sbtype_cd = 'W' THEN stk.soh_retail_amount
    END AS depot_retail_amount,
    stk.soh_cost_amount AS unit_cost_amount,
    stk.stock_unit_retail_amount AS unit_retail_amount, /* Also SSBI1068 */
    stk.on_order_units AS on_order_units,
    stk.on_order_cost_amount AS on_order_cost_amount,
    stk.on_order_retail_amount AS on_order_retail_amount,
    stk.on_order_pack_units AS on_order_pack_units,
    stk.return_to_vendor_cost_amount AS return_to_vendor_cost_amount,
    stk.return_to_vendor_retail_amount AS return_to_vendor_retail_amount,
    stk.return_to_vendor_units AS return_to_vendor_units,
    stk.return_to_vendor_pack_units AS return_to_vendor_pack_units,
    stk.transfer_expected_retail_amount AS transfer_expected_retail_amount,
    stk.transfer_expected_pack_units AS transfer_expected_pack_units,
    stk.transfer_reserved_cost_amount AS transfer_reserved_cost_amount,
    stk.transfer_expected_units AS transfer_expected_units,
    stk.transfer_reserved_retail_amount AS transfer_reserved_retail_amount,
    stk.transfer_reserved_pack_units AS transfer_reserved_pack_units,
    stk.transfer_expected_cost_amount AS transfer_expected_cost_amount,
    stk.transfer_reserved_units AS transfer_reserved_units,
    stk.in_transit_retail_amount AS in_transit_retail_amount,
    stk.in_transit_pack_units AS in_transit_pack_units,
    stk.in_transit_units AS in_transit_units,
    stk.in_transit_cost_amount AS in_transit_cost_amount,
    stk.non_sellable_retail_amount AS non_sellable_retail_amount,
    stk.non_sellable_pack_units AS non_sellable_pack_units,
    stk.non_sellable_cost_amount AS non_sellable_cost_amount,
    stk.non_sellable_units AS non_sellable_units,
    -- PSR blocked fields: only set if item/location is in stpsel (stop sell)
    CASE
        WHEN stpsel.pmk_stop_sell IS NULL
            OR stpsel.pmk_stop_sell = 'N'
        THEN 0
        ELSE stk.soh_units
    END AS psr_blocked_units,
    CASE
        WHEN stpsel.pmk_stop_sell IS NULL
            OR stpsel.pmk_stop_sell = 'N'
        THEN 0
        ELSE stk.soh_retail_amount
    END AS psr_retail_amount,
    CASE
        WHEN stpsel.pmk_stop_sell IS NULL
            OR stpsel.pmk_stop_sell = 'N'
        THEN 0
        ELSE stk.soh_pack_units
    END AS psr_blocked_pack_units,
    CASE
        WHEN stpsel.pmk_stop_sell IS NULL
            OR stpsel.pmk_stop_sell = 'N'
        THEN 0
        ELSE stk.soh_cost_amount
    END AS psr_blocked_cost_amount,
    -- Carryover fields: only set if item is flagged as carryover
    CASE
      WHEN itm.PMK_CARYOVR = 'Y'
      THEN stk.SOH_Units
      ELSE 0
    END AS carryover_units,
    CASE
      WHEN itm.PMK_CARYOVR = 'Y'
      THEN stk.SOH_Retail_Amount
      ELSE 0
    END AS carryover_value,
    stk.stock_unit_av_cost_amount AS stock_unit_av_cost_amount,
    stk.regular_unit_retail_amt AS regular_unit_retail_amt,
    /* Adjustements SSBI1061 */
    STADJ.Damaged_Adjustment_Units AS Damaged_Adjustment_Units ,
    (STADJ.Damaged_Adjustment_Units * STK.stock_unit_retail_amount) AS Damaged_Adjustment_amount ,
    STADJ.Soiled_Adjustment_Units AS Soiled_Adjustment_Units ,
    (STADJ.Soiled_Adjustment_Units * STK.stock_unit_retail_amount)  AS Soiled_Adjustment_amount ,
    STADJ.Auto_Adjustment_Units AS Auto_Adjustment_Units ,
    (STADJ.Auto_Adjustment_Units * STK.stock_unit_retail_amount)    AS Auto_Adjustment_amount ,
    STADJ.other_Adjustment_Units  AS other_Adjustment_Units ,
    (STADJ.other_Adjustment_Units * STK.stock_unit_retail_amount)   AS other_Adjustment_amount ,
    STADJ.Stock_Count_Adjustment_Units   AS stock_cnt_adj_Units, 
    STADJ.Stock_Count_Adjustment_Units * STK.stock_unit_retail_amount AS stock_cnt_adj_Retail_Value,
    /* Markdown Listed SSBI1069 */
   CASE 
      WHEN MKD.listing_flg = 'Y'
      THEN STK.soh_units
      ELSE 0
    END AS listed_stock,
    MKD.listing_flg AS listing_flg,
    /* Price Statys SSBI1068 */
   CASE
      WHEN PRCT.Price_Change_Type_Code = 'P'
      THEN (STK.SOH_Units * coalesce(PRCT.UNIT_RETAIL_AMOUNT,STK.stock_unit_retail_amount))
      ELSE 0
    END AS NLP_stock_value ,
    CASE
      WHEN PRCT.Price_Change_Type_Code = 'P'
      THEN STK.SOH_Units
      ELSE 0
    END AS NLP_stock_Units ,
    CASE
      WHEN PRCT.Price_Change_Type_Code = 'C'
      THEN STK.SOH_Units
      ELSE 0
    END AS RAS_UNITS ,
    CASE
      WHEN PRCT.Price_Change_Type_Code = 'C'
      THEN (STK.SOH_Units * coalesce(PRCT.UNIT_RETAIL_AMOUNT,STK.stock_unit_retail_amount))
      ELSE 0
    END  AS RAS_Stock_value,
     PRCT.Price_Action_Week AS Price_Action_Week ,
   DECODE(PRCT.Price_Change_Type_Code,'R','Regular','C','Clearance','P','Promotion','Regular') AS Price_Status
FROM dwp01a_acc_orr.dw_stock_position_dy_fv AS stk
/* Join to LOC to get location type W and S */
INNER JOIN dwp01a_idw.loc AS lc
    ON lc.loc_id = stk.location_id
    AND lc.cur_flg = 'Y'
    /* Only stores and depot */
    AND lc.loc_sbtype_cd IN ('W', 'S')
/* Join to Item  to get carry over indicator */
INNER JOIN dwp01a_idw.item AS itm
    ON itm.item_id = stk.item_id
    AND itm.cur_flg = 'Y'   
/* Join to stop sell to determine which items/sku */
LEFT OUTER JOIN stpsel
    ON stk.item_id = stpsel.item_id
    AND stk.location_id = stpsel.loc_id
/* Join to Soiled and Damaged adjustments */    
LEFT OUTER JOIN STADJ
      ON STK.Item_Id               = STADJ.Item_Id
      AND STK.Location_Id          = STADJ.Location_Id
      AND STK.stock_inventory_date = STADJ.business_date    
/* Mark down listed flag */
LEFT OUTER JOIN MKD
      ON STK.Item_Id               = MKD.Item_Id
      AND STK.Location_Id          = MKD.Location_Id
      AND STK.stock_inventory_date = MKD.business_date    
LEFT OUTER JOIN PRCT
      ON STK.Item_Id               = PRCT.Item_Id
      AND STK.Location_Id          = PRCT.Location_Id
      AND STK.stock_inventory_date = PRCT.business_date    
WHERE STK.stock_inventory_date = date '${LDTK_DATE}' /* Use RUNDATE */
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
        OR  COALESCE(Damaged_Adjustment_Units,0) <> 0
        OR  COALESCE(Soiled_Adjustment_Units,0) <> 0    
        OR  COALESCE(Auto_Adjustment_Units,0) <> 0      
        OR  COALESCE(other_Adjustment_Units,0) <> 0     
        OR  COALESCE(stock_cnt_adj_Units,0) <> 0                
        --OR COALESCE(stock_unit_cost_amount,0) <> 0
        --OR COALESCE(stock_unit_retail_amount,0) <> 0
        --OR last_transfer_creation_date IS NOT NULL
        --OR last_purchase_order_intake_date IS NOT NULL
        --OR COALESCE(regular_unit_retail_amt,0) <> 0
        --OR COALESCE(stock_unit_av_cost_amount,0) <> 0
        )
/* TODO: Remove before volume testing */
SAMPLE 1000000