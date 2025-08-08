-- =================================================================================================
-- Populates the daily aggregated stock fact table by joining the pivoted staging table
-- with the two source fact staging tables.
--
-- Business Logic:
-- 1. Uses FND_STK_FCT_PVT_STG as the driver to ensure all combinations of
--    business_date, location_id, and item_id are included.
-- 2. LEFT JOINs to FND_STK_FCT_01_FCT_STG and FND_STK_FCT_02_FCT_STG to retrieve
--    the actual stock measures.
-- 3. COALESCE is used on all measure columns to convert NULLs to 0, which can occur
--    if a record does not exist in one of the source tables.
-- 4. Default values are provided for target columns that do not have a direct source.
-- 5. The script is designed to be re-runnable by deleting the data for the target
--    business date before insertion.
-- =================================================================================================
-- Start a new transaction. This ensures that all subsequent operations are treated as a single
-- atomic unit of work. If any step fails, the entire transaction can be rolled back.
BEGIN TRANSACTION;
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Lock the target table in WRITE mode to prevent other processes from modifying it during the load.
-- This ensures data consistency.
LOCKING TABLE DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT FOR WRITE;
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Before inserting new data, delete any existing records for the target business date.
-- This makes the script re-runnable without creating duplicate data.
-- Note: It deletes data for the previous day, assuming this script runs for the current day's data.
DELETE FROM DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT
WHERE
    business_date = CURRENT_DATE - 1;
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Insert the aggregated data into the final fact table.
INSERT INTO DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT (
    business_date,
    location_id,
    item_id,
    location_soh_units,
    depot_soh_units,
    location_pack_units,
    depot_pack_units,
    location_retail_amount,
    depot_retail_amount,
    unit_cost_amount,
    unit_retail_amount,
    on_order_units,
    on_order_cost_amount,
    on_order_retail_amount,
    on_order_pack_units,
    return_to_vendor_cost_amount,
    return_to_vendor_retail_amount,
    return_to_vendor_units,
    return_to_vendor_pack_units,
    transfer_expected_retail_amount,
    transfer_expected_pack_units,
    transfer_expected_cost_amount,
    transfer_expected_units,
    transfer_reserved_retail_amount,
    transfer_reserved_pack_units,
    transfer_reserved_cost_amount,
    transfer_reserved_units,
    in_transit_retail_amount,
    in_transit_pack_units,
    in_transit_units,
    in_transit_cost_amount,
    non_sellable_retail_amount,
    non_sellable_pack_units,
    non_sellable_cost_amount,
    non_sellable_units,
    stock_count_units,
    stock_count_snapshot_units,
    stock_count_retail_amt,
    stock_count_snapshot_retail_amt,
    total_stock_loss_units,
    total_stock_loss_value,
    damaged_adjustment_units,
    damaged_adjustment_amount,
    soiled_adjustment_units,
    soiled_adjustment_amount,
    auto_adjustment_units,
    auto_adjustment_amount,
    other_adjustment_units,
    other_adjustment_amount,
    psr_blocked_units,
    psr_retail_amount,
    psr_blocked_pack_units,
    psr_blocked_cost_amount,
    trasfer_ship_units,
    trasfer_ship_retail_amount,
    trasfer_ship_cost_amount,
    stock_cnt_adj_units,
    stock_cnt_adj_retail_value,
    soh_age_in_weeks,
    transfer_outst_units,
    transfer_outst_retail_value,
    transfer_act_repo_cost_value,
    transfer_act_upchrg_cost_value,
    transfer_act_upchrg_unit_cost,
    nlp_stock_value,
    nlp_stock_units,
    ras_units,
    listed_stock,
    carryover_units,
    carryover_value,
    price_action_week,
    price_status,
    transfer_outst_cost_value,
    tsf_intake_qty,
    tsf_intake_retail_amount,
    tsf_intake_cost_amount,
    ras_stock_value,
    stock_unit_av_cost_amount,
    wkly_flg,
    listing_flg,
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
)
SELECT
    -- Key columns from the pivot table, which acts as the driver for the join.
    pvt.business_date AS business_date,
    pvt.location_id AS location_id,
    pvt.item_id AS item_id,
    -- Measures from the first source table (FCT1). COALESCE ensures no nulls are inserted.
    COALESCE(fct1.location_soh_units, 0) AS location_soh_units,
    COALESCE(fct1.depot_soh_units, 0) AS depot_soh_units,
    COALESCE(fct1.location_pack_units, 0) AS location_pack_units,
    COALESCE(fct1.depot_pack_units, 0) AS depot_pack_units,
    COALESCE(fct1.location_retail_amount, 0) AS location_retail_amount,
    COALESCE(fct1.depot_retail_amount, 0) AS depot_retail_amount,
    COALESCE(fct1.unit_cost_amount, 0) AS unit_cost_amount,
    COALESCE(fct1.unit_retail_amount, 0) AS unit_retail_amount,
    COALESCE(fct1.on_order_units, 0) AS on_order_units,
    COALESCE(fct1.on_order_cost_amount, 0) AS on_order_cost_amount,
    COALESCE(fct1.on_order_retail_amount, 0) AS on_order_retail_amount,
    COALESCE(fct1.on_order_pack_units, 0) AS on_order_pack_units,
    COALESCE(fct1.return_to_vendor_cost_amount, 0) AS return_to_vendor_cost_amount,
    COALESCE(fct1.return_to_vendor_retail_amount, 0) AS return_to_vendor_retail_amount,
    COALESCE(fct1.return_to_vendor_units, 0) AS return_to_vendor_units,
    COALESCE(fct1.return_to_vendor_pack_units, 0) AS return_to_vendor_pack_units,
    COALESCE(fct1.transfer_expected_retail_amount, 0) AS transfer_expected_retail_amount,
    COALESCE(fct1.transfer_expected_pack_units, 0) AS transfer_expected_pack_units,
    COALESCE(fct1.transfer_expected_cost_amount, 0) AS transfer_expected_cost_amount,
    COALESCE(fct1.transfer_expected_units, 0) AS transfer_expected_units,
    COALESCE(fct1.transfer_reserved_retail_amount, 0) AS transfer_reserved_retail_amount,
    COALESCE(fct1.transfer_reserved_pack_units, 0) AS transfer_reserved_pack_units,
    COALESCE(fct1.transfer_reserved_cost_amount, 0) AS transfer_reserved_cost_amount,
    COALESCE(fct1.transfer_reserved_units, 0) AS transfer_reserved_units,
    COALESCE(fct1.in_transit_retail_amount, 0) AS in_transit_retail_amount,
    COALESCE(fct1.in_transit_pack_units, 0) AS in_transit_pack_units,
    COALESCE(fct1.in_transit_units, 0) AS in_transit_units,
    COALESCE(fct1.in_transit_cost_amount, 0) AS in_transit_cost_amount,
    COALESCE(fct1.non_sellable_retail_amount, 0) AS non_sellable_retail_amount,
    COALESCE(fct1.non_sellable_pack_units, 0) AS non_sellable_pack_units,
    COALESCE(fct1.non_sellable_cost_amount, 0) AS non_sellable_cost_amount,
    COALESCE(fct1.non_sellable_units, 0) AS non_sellable_units,
    -- Measures from the second source table (FCT2).
    COALESCE(fct2.stock_count_units, 0) AS stock_count_units,
    COALESCE(fct2.stock_count_snapshot_units, 0) AS stock_count_snapshot_units,
    COALESCE(fct2.stock_count_retail_amt, 0) AS stock_count_retail_amt,
    COALESCE(fct2.stock_count_snapshot_retail_amt, 0) AS stock_count_snapshot_retail_amt,
    COALESCE(fct2.total_stock_loss_units, 0) AS total_stock_loss_units,
    COALESCE(fct2.total_stock_loss_value, 0) AS total_stock_loss_value,
    -- Adjustment measures from FCT1.
    COALESCE(fct1.damaged_adjustment_units, 0) AS damaged_adjustment_units,
    COALESCE(fct1.damaged_adjustment_amount, 0) AS damaged_adjustment_amount,
    COALESCE(fct1.soiled_adjustment_units, 0) AS soiled_adjustment_units,
    COALESCE(fct1.soiled_adjustment_amount, 0) AS soiled_adjustment_amount,
    COALESCE(fct1.auto_adjustment_units, 0) AS auto_adjustment_units,
    COALESCE(fct1.auto_adjustment_amount, 0) AS auto_adjustment_amount,
    COALESCE(fct1.other_adjustment_units, 0) AS other_adjustment_units,
    COALESCE(fct1.other_adjustment_amount, 0) AS other_adjustment_amount,
    -- PSR (Potentially Slow-moving/Redundant) measures from FCT1.
    COALESCE(fct1.psr_blocked_units, 0) AS psr_blocked_units,
    COALESCE(fct1.psr_retail_amount, 0) AS psr_retail_amount,
    COALESCE(fct1.psr_blocked_pack_units, 0) AS psr_blocked_pack_units,
    COALESCE(fct1.psr_blocked_cost_amount, 0) AS psr_blocked_cost_amount,
    -- Transfer ship measures from FCT2.
    COALESCE(fct2.trasfer_ship_units, 0) AS trasfer_ship_units,
    COALESCE(fct2.trasfer_ship_retail_amount, 0) AS trasfer_ship_retail_amount,
    COALESCE(fct2.trasfer_ship_cost_amount, 0) AS trasfer_ship_cost_amount,
    -- Stock count adjustment measures from FCT1.
    COALESCE(fct1.stock_cnt_adj_units, 0) AS stock_cnt_adj_units,
    COALESCE(fct1.stock_cnt_adj_retail_value, 0) AS stock_cnt_adj_retail_value,
    -- Defaulted and other measures where a direct source is not available or logic is applied.
    0 AS soh_age_in_weeks, -- No source column, defaulting to 0.
    COALESCE(fct2.transfer_outst_units, 0) AS transfer_outst_units,
    COALESCE(fct2.transfer_outst_retail_value, 0) AS transfer_outst_retail_value,
    COALESCE(fct2.transfer_act_repo_cost_value, 0) AS transfer_act_repo_cost_value,
    COALESCE(fct2.transfer_act_upchrg_cost_value, 0) AS transfer_act_upchrg_cost_value,
    COALESCE(fct2.transfer_act_upchrg_unit_cost, 0) AS transfer_act_upchrg_unit_cost,
    COALESCE(fct1.nlp_stock_value, 0) AS nlp_stock_value,
    COALESCE(fct1.nlp_stock_units, 0) AS nlp_stock_units,
    COALESCE(fct1.ras_units, 0) AS ras_units,
    COALESCE(fct1.listed_stock, 0) AS listed_stock,
    COALESCE(fct1.carryover_units, 0) AS carryover_units,
    COALESCE(fct1.carryover_value, 0) AS carryover_value,
    COALESCE(fct1.price_action_week, 0) AS price_action_week,
    COALESCE(fct1.price_status, 'N') AS price_status,
    COALESCE(fct2.transfer_outst_cost_value, 0) AS transfer_outst_cost_value,
    COALESCE(fct2.tsf_intake_qty, 0) AS tsf_intake_qty,
    COALESCE(fct2.tsf_intake_retail_amount, 0) AS tsf_intake_retail_amount,
    COALESCE(fct2.tsf_intake_cost_amount, 0) AS tsf_intake_cost_amount,
    COALESCE(fct1.ras_stock_value, 0) AS ras_stock_value,
    COALESCE(fct1.stock_unit_av_cost_amount, 0) AS stock_unit_av_cost_amount,
    'Y' AS wkly_flg, -- Defaulting to 'Y', assuming the daily load is the weekly snapshot.
    COALESCE(fct1.listing_flg, 'N') AS listing_flg,
    -- Audit and metadata columns for tracking and versioning.
    CURRENT_DATE AS eff_from_dt, -- Effective from the date of the run.
    DATE '3500-12-31' AS eff_to_dt, -- A high date represents the current version.
    0 AS del_ind, -- Deletion indicator, 0 means the record is active.
    ${RUNID} AS run_id, -- Populated from a script variable.
    NULL AS update_run_id, -- NULL for new records.
    '${JOB}' AS job_id, -- Populated from a script variable.
    NULL AS update_job_id -- NULL for new records.
FROM
    DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_PVT_STG AS pvt
LEFT OUTER JOIN
    DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG AS fct1
        ON pvt.business_date = fct1.business_date
        AND pvt.location_id = fct1.location_id
        AND pvt.item_id = fct1.item_id
LEFT OUTER JOIN
    DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG AS fct2
        ON pvt.business_date = fct2.business_date
        AND pvt.location_id = fct2.location_id
        AND pvt.item_id = fct2.item_id;
-- Check for errors after the INSERT statement. If an error occurred, quit the script.
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- If no rows were inserted, quit the script. This can be a useful check to ensure the source tables were not empty.
.IF ACTIVITYCOUNT = 0 THEN .QUIT 101;
-- This logic ensures that only the last day of the week is flagged as the weekly snapshot.
-- It first sets the flag to 'Y' for the current run, then flips the flag to 'N' for any
-- previous days in the same week that might have been flagged.
UPDATE DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT
SET
    wkly_flg = 'N'
WHERE
    business_date BETWEEN date '${WEEK_START_DT}' AND date '${WEEK_END_DT}'
    AND business_date <> date '${LDTK_DATE}' -- Exclude the current run date from the update
    AND wkly_flg = 'Y';
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- End the transaction, committing all the changes made.
END TRANSACTION;
.IF ERRORCODE <> 0 THEN .QUIT 101;
;