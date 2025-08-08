/*
  This query consolidates various stock fact measures from different staging tables.
  It uses a central pivot table (PVT) as the driver to ensure all unique item/location/date
  combinations are represented, and then joins to the individual fact staging tables (FCT1, FCT2)
  to gather the specific metrics.
*/
SELECT
    -- Core Keys from the Pivot Table
    PVT.business_date,
    PVT.location_id,
    PVT.item_id,
    -- Stock on Hand (SOH) Measures from FCT1
    COALESCE(FCT1.location_soh_units, 0) AS location_soh_units,
    COALESCE(FCT1.depot_soh_units, 0) AS depot_soh_units,
    COALESCE(FCT1.location_pack_units, 0) AS location_pack_units,
    COALESce(FCT1.depot_pack_units, 0) AS depot_pack_units,
    COALESCE(FCT1.location_retail_amount, 0) AS location_retail_amount,
    COALESCE(FCT1.depot_retail_amount, 0) AS depot_retail_amount,
    -- Unit Cost and Retail Amounts from FCT1
    COALESCE(FCT1.unit_cost_amount, 0) AS unit_cost_amount,
    COALESCE(FCT1.unit_retail_amount, 0) AS unit_retail_amount,
    -- On Order Measures from FCT1
    COALESCE(FCT1.on_order_units, 0) AS on_order_units,
    COALESCE(FCT1.on_order_cost_amount, 0) AS on_order_cost_amount,
    COALESCE(FCT1.on_order_retail_amount, 0) AS on_order_retail_amount,
    COALESCE(FCT1.on_order_pack_units, 0) AS on_order_pack_units,
    -- Return to Vendor (RTV) Measures from FCT1
    COALESCE(FCT1.return_to_vendor_cost_amount, 0) AS return_to_vendor_cost_amount,
    COALESCE(FCT1.return_to_vendor_retail_amount, 0) AS return_to_vendor_retail_amount,
    COALESCE(FCT1.return_to_vendor_units, 0) AS return_to_vendor_units,
    COALESCE(FCT1.return_to_vendor_pack_units, 0) AS return_to_vendor_pack_units,
    -- Expected Transfer Measures from FCT1
    COALESCE(FCT1.transfer_expected_retail_amount, 0) AS transfer_expected_retail_amount,
    COALESCE(FCT1.transfer_expected_pack_units, 0) AS transfer_expected_pack_units,
    COALESCE(FCT1.transfer_expected_cost_amount, 0) AS transfer_expected_cost_amount,
    COALESCE(FCT1.transfer_expected_units, 0) AS transfer_expected_units,
    -- Reserved Transfer Measures from FCT1
    COALESCE(FCT1.transfer_reserved_retail_amount, 0) AS transfer_reserved_retail_amount,
    COALESCE(FCT1.transfer_reserved_pack_units, 0) AS transfer_reserved_pack_units,
    COALESCE(FCT1.transfer_reserved_cost_amount, 0) AS transfer_reserved_cost_amount,
    COALESCE(FCT1.transfer_reserved_units, 0) AS transfer_reserved_units,
    -- In-Transit Measures from FCT1
    COALESCE(FCT1.in_transit_retail_amount, 0) AS in_transit_retail_amount,
    COALESCE(FCT1.in_transit_pack_units, 0) AS in_transit_pack_units,
    COALESCE(FCT1.in_transit_units, 0) AS in_transit_units,
    COALESCE(FCT1.in_transit_cost_amount, 0) AS in_transit_cost_amount,
    -- Non-Sellable Stock Measures from FCT1
    COALESCE(FCT1.non_sellable_retail_amount, 0) AS non_sellable_retail_amount,
    COALESCE(FCT1.non_sellable_pack_units, 0) AS non_sellable_pack_units,
    COALESCE(FCT1.non_sellable_cost_amount, 0) AS non_sellable_cost_amount,
    COALESCE(FCT1.non_sellable_units, 0) AS non_sellable_units,
    -- Pre-Stock Receipt (PSR) Blocked Stock from FCT1
    COALESCE(FCT1.psr_blocked_units, 0) AS psr_blocked_units,
    COALESCE(FCT1.psr_retail_amount, 0) AS psr_retail_amount,
    COALESCE(FCT1.psr_blocked_pack_units, 0) AS psr_blocked_pack_units,
    COALESCE(FCT1.psr_blocked_cost_amount, 0) AS psr_blocked_cost_amount,
    -- Carryover and Costing Measures from FCT1
    COALESCE(FCT1.carryover_units, 0) AS carryover_units,
    COALESCE(FCT1.carryover_value, 0) AS carryover_value,
    COALESCE(FCT1.stock_unit_av_cost_amount, 0) AS stock_unit_av_cost_amount,
    COALESCE(FCT1.regular_unit_retail_amt, 0) AS regular_unit_retail_amt,
    -- Adjustment Measures from FCT1
    COALESCE(FCT1.damaged_adjustment_units, 0) AS damaged_adjustment_units,
    COALESCE(FCT1.damaged_adjustment_amount, 0) AS damaged_adjustment_amount,
    COALESCE(FCT1.soiled_adjustment_units, 0) AS soiled_adjustment_units,
    COALESCE(FCT1.soiled_adjustment_amount, 0) AS soiled_adjustment_amount,
    COALESCE(FCT1.auto_adjustment_units, 0) AS auto_adjustment_units,
    COALESCE(FCT1.auto_adjustment_amount, 0) AS auto_adjustment_amount,
    COALESCE(FCT1.other_adjustment_units, 0) AS other_adjustment_units,
    COALESCE(FCT1.other_adjustment_amount, 0) AS other_adjustment_amount,
    COALESCE(FCT1.stock_cnt_adj_units, 0) AS stock_cnt_adj_units,
    COALESCE(FCT1.stock_cnt_adj_retail_value, 0) AS stock_cnt_adj_retail_value,
    -- Listing and Pricing Status from FCT1
    COALESCE(FCT1.listed_stock, 0) AS listed_stock,
    COALESCE(FCT1.listing_flg, 0) AS listing_flg,
    COALESCE(FCT1.nlp_stock_value, 0) AS nlp_stock_value,
    COALESCE(FCT1.nlp_stock_units, 0) AS nlp_stock_units,
    COALESCE(FCT1.ras_units, 0) AS ras_units,
    COALESCE(FCT1.ras_stock_value, 0) AS ras_stock_value,
    COALESCE(FCT1.price_action_week, 0) AS price_action_week,
    COALESCE(FCT1.price_status, 0) AS price_status,
    -- Transfer and Stock Count Measures from FCT2
    COALESCE(FCT2.transfer_outst_units, 0) AS transfer_outst_units,
    COALESCE(FCT2.transfer_outst_retail_value, 0) AS transfer_outst_retail_value,
    COALESCE(FCT2.transfer_outst_cost_value, 0) AS transfer_outst_cost_value,
    COALESCE(FCT2.transfer_act_repo_cost_value, 0) AS transfer_act_repo_cost_value,
    COALESCE(FCT2.transfer_act_upchrg_unit_cost, 0) AS transfer_act_upchrg_unit_cost,
    COALESCE(FCT2.transfer_act_upchrg_cost_value, 0) AS transfer_act_upchrg_cost_value,
    COALESCE(FCT2.stock_count_units, 0) AS stock_count_units,
    COALESCE(FCT2.stock_count_snapshot_units, 0) AS stock_count_snapshot_units,
    COALESCE(FCT2.stock_count_retail_amt, 0) AS stock_count_retail_amt,
    COALESCE(FCT2.stock_count_snapshot_retail_amt, 0) AS stock_count_snapshot_retail_amt,
    COALESCE(FCT2.total_stock_loss_units, 0) AS total_stock_loss_units,
    COALESCE(FCT2.total_stock_loss_value, 0) AS total_stock_loss_value,
    COALESCE(FCT2.tsf_intake_qty, 0) AS tsf_intake_qty,
    COALESCE(FCT2.tsf_intake_retail_amount, 0) AS tsf_intake_retail_amount,
    COALESCE(FCT2.tsf_intake_cost_amount, 0) AS tsf_intake_cost_amount,
    COALESCE(FCT2.trasfer_ship_units, 0) AS trasfer_ship_units,
    COALESCE(FCT2.trasfer_ship_retail_amount, 0) AS trasfer_ship_retail_amount,
    COALESCE(FCT2.trasfer_ship_cost_amount, 0) AS trasfer_ship_cost_amount
FROM
    -- PVT: The central pivot table containing all unique keys. This drives the query.
    DWT04T_TMP_ACC_OLR.FND_STK_FCT_PVT_STG AS PVT
FULL OUTER JOIN
    -- FCT1: The first staging fact table containing a primary set of stock measures.
    FND_STK_FCT_01_FCT_STG AS FCT1
    ON PVT.ITEM_ID = FCT1.ITEM_ID
    AND PVT.LOCATION_ID = FCT1.LOCATION_ID
    AND PVT.BUSINESS_DATE = FCT1.BUSINESS_DATE
FULL OUTER JOIN
    -- FCT2: The second staging fact table containing another set of stock measures.
    FND_STK_FCT_02_FCT_STG AS FCT2
    ON PVT.ITEM_ID = FCT2.ITEM_ID
    AND PVT.LOCATION_ID = FCT2.LOCATION_ID
    AND PVT.BUSINESS_DATE = FCT2.BUSINESS_DATE;