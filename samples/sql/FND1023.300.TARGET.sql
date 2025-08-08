BEGIN TRANSACTION
;
.IF ERRORCODE <> 0 THEN .QUIT 101
LOCKING TABLE DWT04T_ACC_OLR.DW_FND_AGG_DAILY_STOCK_FCT FOR WRITE;
;
.IF ERRORCODE <> 0 THEN .QUIT 101
/*
  Step 1: Clean up the target table by deleting records for the current business date.
  This ensures the load is idempotent for the given day.
*/
DELETE FROM
  DWT04V_ACC_OLR.DW_FND_AGG_DAILY_STOCK_FCT
WHERE
  business_date = CURRENT_DATE - 1
;
.IF ERRORCODE <> 0 THEN .QUIT 101
/*
  Step 2: Insert the newly aggregated daily stock facts from the temporary source table.
  This populates the target table with the fresh data for the current business date.
*/
INSERT INTO
  DWT04V_ACC_OLR.DW_FND_AGG_DAILY_STOCK_FCT (
    /*-- Core Keys --*/
    business_date,
    location_id,
    item_id,
    /*-- Stock on Hand (SOH) --*/
    location_soh_units,
    depot_soh_units,
    location_pack_units,
    depot_pack_units,
    location_retail_amount,
    depot_retail_amount,
    /*-- Unit Cost & Retail --*/
    unit_cost_amount,
    unit_retail_amount,
    /*-- On Order --*/
    on_order_units,
    on_order_cost_amount,
    on_order_retail_amount,
    on_order_pack_units,
    /*-- Return to Vendor --*/
    return_to_vendor_cost_amount,
    return_to_vendor_retail_amount,
    return_to_vendor_units,
    return_to_vendor_pack_units,
    /*-- Expected Transfers --*/
    transfer_expected_retail_amount,
    transfer_expected_pack_units,
    transfer_expected_cost_amount,
    transfer_expected_units,
    /*-- Reserved Transfers --*/
    transfer_reserved_retail_amount,
    transfer_reserved_pack_units,
    transfer_reserved_cost_amount,
    transfer_reserved_units,
    /*-- In-Transit Stock --*/
    in_transit_retail_amount,
    in_transit_pack_units,
    in_transit_units,
    in_transit_cost_amount,
    /*-- Non-Sellable Stock --*/
    non_sellable_retail_amount,
    non_sellable_pack_units,
    non_sellable_cost_amount,
    non_sellable_units,
    /*-- Stock Counts & Loss --*/
    stock_count_units,
    stock_count_snapshot_units,
    stock_count_retail_amt,
    stock_count_snapshot_retail_amt,
    total_stock_loss_units,
    total_stock_loss_value,
    /*-- Adjustments --*/
    damaged_adjustment_units,
    damaged_adjustment_amount,
    soiled_adjustment_units,
    soiled_adjustment_amount,
    auto_adjustment_units,
    auto_adjustment_amount,
    other_adjustment_units,
    other_adjustment_amount,
    /*-- Pre-Stock Receipt (PSR) Blocked --*/
    psr_blocked_units,
    psr_retail_amount,
    psr_blocked_pack_units,
    psr_blocked_cost_amount,
    /*-- Shipped Transfers --*/
    trasfer_ship_units,
    trasfer_ship_retail_amount,
    trasfer_ship_cost_amount,
    /*-- Stock Count Adjustments --*/
    stock_cnt_adj_units,
    stock_cnt_adj_retail_value,
    /*-- Stock Age & Outstanding Transfers --*/
    soh_age_in_weeks,
    transfer_outst_units,
    transfer_outst_retail_value,
    transfer_act_repo_cost_value,
    transfer_act_upchrg_cost_value,
    transfer_act_upchrg_unit_cost,
    /*-- NLP & RAS Stock --*/
    nlp_stock_value,
    nlp_stock_units,
    ras_units,
    /*-- Listing & Carryover --*/
    listed_stock,
    carryover_units,
    carryover_value,
    /*-- Pricing & Status --*/
    price_action_week,
    price_status,
    /*-- Other Measures --*/
    transfer_outst_cost_value,
    tsf_intake_qty,
    tsf_intake_retail_amount,
    tsf_intake_cost_amount,
    ras_stock_value,
    stock_unit_av_cost_amount,
    /*-- Flags --*/
    wkly_flg,
    listing_flg,
    /*-- Audit Columns --*/
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
  )
SELECT
  /*-- Core Keys --*/
  business_date,
  location_id,
  item_id,
  /*-- Stock on Hand (SOH) --*/
  location_soh_units,
  depot_soh_units,
  location_pack_units,
  depot_pack_units,
  location_retail_amount,
  depot_retail_amount,
  /*-- Unit Cost & Retail --*/
  unit_cost_amount,
  unit_retail_amount,
  /*-- On Order --*/
  on_order_units,
  on_order_cost_amount,
  on_order_retail_amount,
  on_order_pack_units,
  /*-- Return to Vendor --*/
  return_to_vendor_cost_amount,
  return_to_vendor_retail_amount,
  return_to_vendor_units,
  return_to_vendor_pack_units,
  /*-- Expected Transfers --*/
  transfer_expected_retail_amount,
  transfer_expected_pack_units,
  transfer_expected_cost_amount,
  transfer_expected_units,
  /*-- Reserved Transfers --*/
  transfer_reserved_retail_amount,
  transfer_reserved_pack_units,
  transfer_reserved_cost_amount,
  transfer_reserved_units,
  /*-- In-Transit Stock --*/
  in_transit_retail_amount,
  in_transit_pack_units,
  in_transit_units,
  in_transit_cost_amount,
  /*-- Non-Sellable Stock --*/
  non_sellable_retail_amount,
  non_sellable_pack_units,
  non_sellable_cost_amount,
  non_sellable_units,
  /*-- Stock Counts & Loss --*/
  stock_count_units,
  stock_count_snapshot_units,
  stock_count_retail_amt,
  stock_count_snapshot_retail_amt,
  total_stock_loss_units,
  total_stock_loss_value,
  /*-- Adjustments --*/
  damaged_adjustment_units,
  damaged_adjustment_amount,
  soiled_adjustment_units,
  soiled_adjustment_amount,
  auto_adjustment_units,
  auto_adjustment_amount,
  other_adjustment_units,
  other_adjustment_amount,
  /*-- Pre-Stock Receipt (PSR) Blocked --*/
  psr_blocked_units,
  psr_retail_amount,
  psr_blocked_pack_units,
  psr_blocked_cost_amount,
  /*-- Shipped Transfers --*/
  trasfer_ship_units,
  trasfer_ship_retail_amount,
  trasfer_ship_cost_amount,
  /*-- Stock Count Adjustments --*/
  stock_cnt_adj_units,
  stock_cnt_adj_retail_value,
  /*-- Stock Age & Outstanding Transfers --*/
  soh_age_in_weeks,
  transfer_outst_units,
  transfer_outst_retail_value,
  transfer_act_repo_cost_value,
  transfer_act_upchrg_cost_value,
  transfer_act_upchrg_unit_cost,
  /*-- NLP & RAS Stock --*/
  nlp_stock_value,
  nlp_stock_units,
  ras_units,
  /*-- Listing & Carryover --*/
  listed_stock,
  carryover_units,
  carryover_value,
  /*-- Pricing & Status --*/
  price_action_week,
  price_status,
  /*-- Other Measures --*/
  transfer_outst_cost_value,
  tsf_intake_qty,
  tsf_intake_retail_amount,
  tsf_intake_cost_amount,
  ras_stock_value,
  stock_unit_av_cost_amount,
  /*-- Flags --*/
  wkly_flg,
  listing_flg,
  /*-- Audit Columns --*/
  CURRENT_DATE - 1 AS eff_from_dt,
  DATE '3500-12-31' AS eff_to_dt,
  0 AS del_ind,
  0 AS run_id,
  NULL AS update_run_id,
  '${JOB}' AS job_id,
  NULL AS update_job_id
FROM
  DWP01T_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT AS FCT
;
.IF ERRORCODE <> 0 THEN .QUIT 101
/*
  Step 3: Update the weekly flag for the previous day's records.
  This is likely to reset a flag for records that are no longer the most current,
  but still fall within the current week.
*/
UPDATE
  DWT04V_ACC_OLR.DW_FND_AGG_DAILY_STOCK_FCT
SET
  wkly_flg = 'N'
WHERE
  -- This condition targets the data from two days ago (CURRENT_DATE - 2).
  business_date = CURRENT_DATE - 1 - 1
  AND business_date >= TD_SUNDAY(CURRENT_DATE - 1)
;
.IF ERRORCODE <> 0 THEN .QUIT 101
END TRANSACTION
;
.IF ERRORCODE <> 0 THEN .QUIT 101