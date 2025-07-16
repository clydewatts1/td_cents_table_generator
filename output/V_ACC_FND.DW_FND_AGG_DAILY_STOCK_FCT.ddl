
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}V_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_AGG_DAILY_STOCK_FCT */
REPLACE VIEW DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT
    AS
SELECT
    business_date ,
    location_id ,
    item_id ,
    location_soh_units ,
    depot_soh_units ,
    location_pack_units ,
    depot_pack_units ,
    location_retail_amount ,
    depot_retail_amount ,
    unit_cost_amount ,
    unit_retail_amount ,
    on_order_units ,
    on_order_cost_amount ,
    on_order_retail_amount ,
    on_order_pack_units ,
    return_to_vendor_cost_amount ,
    return_to_vendor_retail_amount ,
    return_to_vendor_units ,
    return_to_vendor_pack_units ,
    transfer_expected_retail_amount ,
    transfer_expected_pack_units ,
    transfer_expected_cost_amount ,
    transfer_expected_units ,
    transfer_reserved_retail_amount ,
    transfer_reserved_pack_units ,
    transfer_reserved_cost_amount ,
    transfer_reserved_units ,
    in_transit_retail_amount ,
    in_transit_pack_units ,
    in_transit_units ,
    in_transit_cost_amount ,
    non_sellable_retail_amount ,
    non_sellable_pack_units ,
    non_sellable_cost_amount ,
    non_sellable_units ,
    stock_count_units ,
    stock_count_snapshot_units ,
    stock_count_retail_amt ,
    stock_count_snapshot_retail_amt ,
    total_stock_loss_units ,
    total_stock_loss_value ,
    damaged_adjustment_units ,
    damaged_adjustment_amount ,
    soiled_adjustment_units ,
    soiled_adjustment_amount ,
    auto_adjustment_units ,
    auto_adjustment_amount ,
    other_adjustment_units ,
    other_adjustment_amount ,
    psr_blocked_units ,
    psr_retail_amount ,
    psr_blocked_pack_units ,
    psr_blocked_cost_amount ,
    trasfer_ship_units ,
    trasfer_ship_retail_amount ,
    trasfer_ship_cost_amount ,
    ord_intake_units ,
    ord_intake_retail_amount ,
    ord_intake_cost_amount ,
    stock_cnt_adj_units ,
    stock_cnt_adj_retail_value ,
    soh_age_in_weeks ,
    transfer_outst_units ,
    transfer_outst_retail_value ,
    transfer_act_repo_cost_value ,
    transfer_act_upchrg_cost_value ,
    transfer_act_upchrg_unit_cost ,
    nlp_stock_value ,
    nlp_stock_units ,
    ras_units ,
    listed_stock ,
    carryover_units ,
    carryover_value ,
    price_action_week ,
    price_status ,
    transfer_outst_cost_value ,
    tsf_intake_qty ,
    tsf_intake_retail_amount ,
    tsf_intake_cost_amount ,
    sales_value ,
    sales_units ,
    return_value ,
    return_units ,
    exchange_value ,
    exchange_units ,
    promotion_sales_value ,
    promotion_sales_units ,
    clearance_sales_value ,
    clearance_sales_units ,
    regular_sales_value ,
    regular_sales_units ,
    lcp_intake ,
    lcp_gross ,
    ras_stock_value ,
    stock_unit_av_cost_amount ,
    regular_unit_retail_amt ,
    promotion_return_value ,
    promotion_return_units ,
    clearance_return_value ,
    clearance_return_units ,
    regular_return_value ,
    regular_return_units ,
    wkly_flg ,
    listing_flg ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT AS ''
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.business_date AS 'Business Date (PK)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.location_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.location_soh_units AS 'This Column is used identify the Primark Location stock on hand units'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.depot_soh_units AS 'This column is used to identify the Depot Stock On Hand Units'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.location_pack_units AS 'This Column is used identify the Primark Location pack units'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.depot_pack_units AS 'SOH_Pack_Units from the stock position table for the specific WH'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.location_retail_amount AS 'This Column is used identify the Primark Location retail amount'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.depot_retail_amount AS 'SOH_Retail_Amount from the stock position table for the specific WH'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.unit_cost_amount AS 'This Column is used identify the Unit cost price of an item'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.unit_retail_amount AS 'Unit price value at retail for the specific item.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.on_order_units AS 'Unit quantity at point of ordering of items on order (commitment ordered and not yet received).'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.on_order_cost_amount AS 'Value quantity of items on order (ordered and not yet received = COMMITMENT COST VALUE).'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.on_order_retail_amount AS 'Retail Value of Packs on order (commitment ordered and not yet received).'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.on_order_pack_units AS 'Quantity of packs ordered on the destination PO. (Packing Method - Cartons and Sets)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.return_to_vendor_cost_amount AS 'This Column is used identify the Retail value of the RTV units (RTV units * Unit retail price)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.return_to_vendor_retail_amount AS 'Cost value for the item being returned that is expected to be recovered from the supplier. RTV NON MERCH COST VALUE + RTV MERCH COST VALUE'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.return_to_vendor_units AS 'Sum of Units for the item being returned that is expected to be recovered from the supplier.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.return_to_vendor_pack_units AS 'Sum of Units for the Pack being returned that is expected to be recovered from the supplier.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_expected_retail_amount AS 'Supplier cost Value of the units transfer Supplier unit cost * Transfer qty'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_expected_pack_units AS 'Pack units of the transfer quantity'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_expected_cost_amount AS 'Retail Value of the transfer quantity Retail price * Transfer qty'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_expected_units AS 'This Column is used identify the Units of the transfer quantity'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_reserved_retail_amount AS 'Supplier cost amount of units confirmed for Transfer'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_reserved_pack_units AS 'Pack Units confirmed for Transfer But yet to transferred'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_reserved_cost_amount AS 'Retail amount of units confirmed for Transfer'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_reserved_units AS 'This Column is used identify the Units confirmed for Transfer'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.in_transit_retail_amount AS 'Supplier cost value of the items in-transit Supplier unit cost * in transit qty'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.in_transit_pack_units AS 'Pack units of the items in transit'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.in_transit_units AS 'Quantity of transfers in Transit between two locations.TRANSFER SHIPPED UNITS - TRANSFER RECEIVED UNITS'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.in_transit_cost_amount AS 'Quantity of transfers in Transit between two locations. TRANSFER SHIPPED VALUE - TRANSFER RECEIVED VALUE'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.non_sellable_retail_amount AS 'Supplier cost of the items which are not marked for sale supplier cost * count(items) where sellable ind = N'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.non_sellable_pack_units AS 'Count of Pack units which are not marked for sale count(pack units) where sellable ind = N'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.non_sellable_cost_amount AS 'Retail Value of the items which are not marked for sale Retail price * count(items) where sellable ind = N'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.non_sellable_units AS 'Supplier cost Value of the units transfer Supplier unit cost * Transfer qty'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.stock_count_units AS 'This Column is used identify the units for the stock count'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.stock_count_snapshot_units AS 'This Column is used identify the units for the stock count snapshot'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.stock_count_retail_amt AS 'This Column is used identify the retail Amount for the stock count'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.stock_count_snapshot_retail_amt AS 'SUM of Stock_Count_Snapshot_Retail_Amt'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.total_stock_loss_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.total_stock_loss_value AS 'the real amount of inventory was adjusted by. This is a store measure.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.damaged_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = DAMAGED'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.damaged_adjustment_amount AS 'This Column is used to identify the Stock Damaged Adjustment Amount'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.soiled_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = SOLID'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.soiled_adjustment_amount AS 'This Column is used identify the Soiled Adjustment amount'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.auto_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = AUTO ADJUSTMNET'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.auto_adjustment_amount AS 'the real amount of inventory was adjusted by. This is a store measure. Type = AUTO ADJUSTMENT'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.other_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = OTHER ADJUSTMNET'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.other_adjustment_amount AS 'Contains the amount the inventory was adjusted by. This is a store measure. Type = OTHER ADJUSTMNET'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.psr_blocked_units AS 'Count of units which are not marked for PSR BLOCKED'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.psr_retail_amount AS 'Retail Value of the items which are not marked for PSR BLOCKED'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.psr_blocked_pack_units AS 'Count of Pack units which are not marked for PSR BLOCKED count(pack units) where PSR BLOCKED ind = Y'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.psr_blocked_cost_amount AS 'Cost amount Blocked from Primark stock replenishment system'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.trasfer_ship_units AS 'Units of the transfer shipped quantity'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.trasfer_ship_retail_amount AS 'Retail Value of the transfer shipped quantity Retail price * Transfer received qty'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.trasfer_ship_cost_amount AS 'This Column is used identify the Shipment cost amount for Transfer'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.ord_intake_units AS 'Quantity of sellable units (pack components) received in the location for ordered item'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.ord_intake_retail_amount AS 'intake supplier retail order from order'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.ord_intake_cost_amount AS 'intake supplier cost order from order'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.stock_cnt_adj_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.stock_cnt_adj_retail_value AS 'the real amount of inventory was adjusted by. This is a store measure'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.soh_age_in_weeks AS 'Stock on hand units since the first time the item was intake'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_outst_units AS 'The amount of stock not yet shipped and outstanding to be shipped (TRANSFER REQUESTED UNITS - TRANSFER SHIPPED UNITS)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_outst_retail_value AS 'The amount of stock not yet shipped and outstanding to be shipped (TRANSFER REQUESTED UNITS - TRANSFER SHIPPED UNITS) * UNIT RETAIL PRICE (at sending Location)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_act_repo_cost_value AS 'Actual Cost Value incurred in reprocessing activities. In RMS reprocessing activities are done with transfers to internal or external finishers. Costs should be obtained from transfers or from invoicing?'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_act_upchrg_cost_value AS 'Actual upcharges Cost Value incurred in transfers of goods between Primark locations.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_act_upchrg_unit_cost AS 'Actual upcharges Unit Cost Price incurred in transfers of goods between Primark locations.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.nlp_stock_value AS 'Stock on NLP at retail value to understanding impact of pricing decisions'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.nlp_stock_units AS 'Units of stock which are listed on promotion'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.ras_units AS 'Number of units listed for mark down/clearance - based on Price Status. Name to be changed to Clearance Sales Units.Clearance SOH to be added in the data dictionary.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.listed_stock AS 'Total SOH in Retail Value in the company - stores and wh(s) = SOH value (WH) + SOH value (Store).SOH VALUE (WH) + SOH VALUE (STORE) which are part of the proposed markdown'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.carryover_units AS 'Unit quantity of stock on hand for Items being carried over from current season to the next (at pack component level - sellable items).SOH UNITS where CARRYOVER FLAG = Y'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.carryover_value AS 'Value of stock on hand for Items being carried over from current season to the next (at pack component level - sellable items).SOH VALUE where CARRYOVER FLAG = Y'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.price_action_week AS 'The action Week of the future retail event (Price change, promotion or clearance).'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.price_status AS 'Current status of the price of the product , whether it is Regular (Full Price), Promotion or Clearance (Markdown).Timebound version of Current Status, need to record status each day'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.transfer_outst_cost_value AS 'This Column is used identify the Outstanding transfer cost value'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.tsf_intake_qty AS 'This Column is used identify the Received Quantity for a transfer'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.tsf_intake_retail_amount AS 'This Column is used identify the Retail amount for the received units for a transfer'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.tsf_intake_cost_amount AS 'This Column is used identify the Received cost amount for a transfer'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.sales_value AS 'Sales value*10000 (4 implied decimal places.), value of units sold in this prom type.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.sales_units AS 'Number of net units of merchandise sold for a subclass/location for the day.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.return_value AS 'Total Retail Value of the Items Returned'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.return_units AS 'Total Retail Units of the Items Returned'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.exchange_value AS 'Total Retail Value of the Items Exchange'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.exchange_units AS 'Total Retail Units of the Items Exchange'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.promotion_sales_value AS 'Sales value of items on promotion'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.promotion_sales_units AS 'This Column is used identify the Units sold in promotion'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.clearance_sales_value AS 'Sales Clearance Value including only like for like stores.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.clearance_sales_units AS 'Sales Clearance Units including only like for like stores.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.regular_sales_value AS 'SALES VALUE where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance. This amount is inclusive of VAT and net of returns.This shouldnot include Gift Cards'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.regular_sales_units AS 'SALES UNITS where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.lcp_intake AS 'This Column is used identify the LCP intake Value'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.lcp_gross AS 'This Column is used identify the LCP Gross Value'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.ras_stock_value AS 'Value of RAS stock to measure impact of price reduction on gross and net margins'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.stock_unit_av_cost_amount AS 'This Column is used identify the Average cost amount of stock unit'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.regular_unit_retail_amt AS 'Unit Retail amount for regular price'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.promotion_return_value AS 'Sales value of items returned which where sold in the promotion'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.promotion_return_units AS 'Units of items returned which where sold in the promotion'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.clearance_return_value AS 'Sales value of items returned which where sold in the clearance'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.clearance_return_units AS 'Units of items returned which where sold in the Clearance'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.regular_return_value AS 'Sales value of items returned which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.regular_return_units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.wkly_flg AS 'Flag to identify the Data is at weekly level or daily level (Y- Yes, N-No)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.listing_flg AS 'This Column is used identify the Listed Flag for stock markdown'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/