
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND2130_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS
    (
    business_date DATE NOT NULL FORMAT 'yyyy-mm-dd',
    location_id INTEGER NOT NULL FORMAT '99999',
    item_id BIGINT NOT NULL ,
    location_soh_units INTEGER NOT NULL ,
    depot_soh_units INTEGER NOT NULL ,
    location_pack_units INTEGER NOT NULL ,
    depot_pack_units INTEGER NOT NULL ,
    location_retail_amount DECIMAL(18,10) NOT NULL ,
    depot_retail_amount DECIMAL(18,10) NOT NULL ,
    unit_cost_amount INTEGER NOT NULL ,
    unit_retail_amount INTEGER NOT NULL ,
    on_order_units INTEGER NOT NULL ,
    on_order_cost_amount DECIMAL(18,10) NOT NULL ,
    on_order_retail_amount DECIMAL(18,10) NOT NULL ,
    on_order_pack_units INTEGER NOT NULL ,
    return_to_vendor_cost_amount DECIMAL(18,10) NOT NULL ,
    return_to_vendor_retail_amount DECIMAL(18,10) NOT NULL ,
    return_to_vendor_units INTEGER NOT NULL ,
    return_to_vendor_pack_units INTEGER NOT NULL ,
    transfer_expected_retail_amount DECIMAL(18,10) NOT NULL ,
    transfer_expected_pack_units INTEGER NOT NULL ,
    transfer_expected_cost_amount DECIMAL(18,10) NOT NULL ,
    transfer_expected_units INTEGER NOT NULL ,
    transfer_reserved_retail_amount DECIMAL(18,10) NOT NULL ,
    transfer_reserved_pack_units INTEGER NOT NULL ,
    transfer_reserved_cost_amount DECIMAL(18,10) NOT NULL ,
    transfer_reserved_units INTEGER NOT NULL ,
    in_transit_retail_amount DECIMAL(18,10) NOT NULL ,
    in_transit_pack_units INTEGER NOT NULL ,
    in_transit_units INTEGER NOT NULL ,
    in_transit_cost_amount DECIMAL(18,10) NOT NULL ,
    non_sellable_retail_amount DECIMAL(18,10) NOT NULL ,
    non_sellable_pack_units INTEGER NOT NULL ,
    non_sellable_cost_amount DECIMAL(18,10) NOT NULL ,
    non_sellable_units INTEGER NOT NULL ,
    stock_count_units INTEGER NOT NULL ,
    stock_count_snapshot_units INTEGER NOT NULL ,
    stock_count_retail_amt DECIMAL(18,10) NOT NULL ,
    stock_count_snapshot_retail_amt DECIMAL(18,10) NOT NULL ,
    total_stock_loss_units INTEGER NOT NULL ,
    total_stock_loss_value DECIMAL(18,10) NOT NULL ,
    damaged_adjustment_units INTEGER NOT NULL ,
    damaged_adjustment_amount DECIMAL(18,10) NOT NULL ,
    soiled_adjustment_units INTEGER NOT NULL ,
    soiled_adjustment_amount DECIMAL(18,10) NOT NULL ,
    auto_adjustment_units INTEGER NOT NULL ,
    auto_adjustment_amount DECIMAL(18,10) NOT NULL ,
    other_adjustment_units INTEGER NOT NULL ,
    other_adjustment_amount DECIMAL(18,10) NOT NULL ,
    psr_blocked_units INTEGER NOT NULL ,
    psr_retail_amount DECIMAL(18,10) NOT NULL ,
    psr_blocked_pack_units INTEGER NOT NULL ,
    psr_blocked_cost_amount DECIMAL(18,10) NOT NULL ,
    trasfer_ship_units INTEGER NOT NULL ,
    trasfer_ship_retail_amount DECIMAL(18,10) NOT NULL ,
    trasfer_ship_cost_amount DECIMAL(18,10) NOT NULL ,
    stock_cnt_adj_units INTEGER NOT NULL ,
    stock_cnt_adj_retail_value DECIMAL(18,10) NOT NULL ,
    soh_age_in_weeks SMALLINT NOT NULL ,
    transfer_outst_units INTEGER NOT NULL ,
    transfer_outst_retail_value DECIMAL(18,10) NOT NULL ,
    transfer_act_repo_cost_value DECIMAL(18,10) NOT NULL ,
    transfer_act_upchrg_cost_value DECIMAL(18,10) NOT NULL ,
    transfer_act_upchrg_unit_cost INTEGER NOT NULL ,
    nlp_stock_value DECIMAL(18,10) NOT NULL ,
    nlp_stock_units INTEGER NOT NULL ,
    ras_units INTEGER NOT NULL ,
    listed_stock INTEGER NOT NULL ,
    carryover_units INTEGER NOT NULL ,
    carryover_value DECIMAL(18,10) NOT NULL ,
    price_action_week DATE NOT NULL ,
    price_status CHAR(1) NOT NULL ,
    transfer_outst_cost_value DECIMAL(18,10) NOT NULL ,
    tsf_intake_qty INTEGER NOT NULL ,
    tsf_intake_retail_amount DECIMAL(18,10) NOT NULL ,
    tsf_intake_cost_amount DECIMAL(18,10) NOT NULL ,
    ras_stock_value DECIMAL(18,10) NOT NULL ,
    stock_unit_av_cost_amount INTEGER NOT NULL ,
    wkly_flg CHAR(1) NOT NULL ,
    listing_flg CHAR(1) NOT NULL      )
    PRIMARY INDEX ( Location_ID ,Item_Id ) PARTITION BY RANGE_N(Business_Date BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.business_date AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.location_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.location_soh_units AS 'This Column is used identify the Primark Location stock on hand units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.depot_soh_units AS 'This column is used to identify the Depot Stock On Hand Units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.location_pack_units AS 'This Column is used identify the Primark Location pack units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.depot_pack_units AS 'SOH_Pack_Units from the stock position table for the specific WH'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.location_retail_amount AS 'This Column is used identify the Primark Location retail amount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.depot_retail_amount AS 'SOH_Retail_Amount from the stock position table for the specific WH'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.unit_cost_amount AS 'This Column is used identify the Unit cost price of an item'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.unit_retail_amount AS 'Unit price value at retail for the specific item.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.on_order_units AS 'Unit quantity at point of ordering of items on order (commitment ordered and not yet received).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.on_order_cost_amount AS 'Value quantity of items on order (ordered and not yet received = COMMITMENT COST VALUE).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.on_order_retail_amount AS 'Retail Value of Packs on order (commitment ordered and not yet received).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.on_order_pack_units AS 'Quantity of packs ordered on the destination PO. (Packing Method - Cartons and Sets)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.return_to_vendor_cost_amount AS 'This Column is used identify the Retail value of the RTV units (RTV units * Unit retail price)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.return_to_vendor_retail_amount AS 'Cost value for the item being returned that is expected to be recovered from the supplier. RTV NON MERCH COST VALUE + RTV MERCH COST VALUE'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.return_to_vendor_units AS 'Sum of Units for the item being returned that is expected to be recovered from the supplier.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.return_to_vendor_pack_units AS 'Sum of Units for the Pack being returned that is expected to be recovered from the supplier.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_expected_retail_amount AS 'Supplier cost Value of the units transfer Supplier unit cost * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_expected_pack_units AS 'Pack units of the transfer quantity'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_expected_cost_amount AS 'Retail Value of the transfer quantity Retail price * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_expected_units AS 'This Column is used identify the Units of the transfer quantity'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_reserved_retail_amount AS 'Supplier cost amount of units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_reserved_pack_units AS 'Pack Units confirmed for Transfer But yet to transferred'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_reserved_cost_amount AS 'Retail amount of units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_reserved_units AS 'This Column is used identify the Units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.in_transit_retail_amount AS 'Supplier cost value of the items in-transit Supplier unit cost * in transit qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.in_transit_pack_units AS 'Pack units of the items in transit'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.in_transit_units AS 'Quantity of transfers in Transit between two locations.TRANSFER SHIPPED UNITS - TRANSFER RECEIVED UNITS'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.in_transit_cost_amount AS 'Quantity of transfers in Transit between two locations. TRANSFER SHIPPED VALUE - TRANSFER RECEIVED VALUE'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.non_sellable_retail_amount AS 'Supplier cost of the items which are not marked for sale supplier cost * count(items) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.non_sellable_pack_units AS 'Count of Pack units which are not marked for sale count(pack units) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.non_sellable_cost_amount AS 'Retail Value of the items which are not marked for sale Retail price * count(items) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.non_sellable_units AS 'Supplier cost Value of the units transfer Supplier unit cost * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.stock_count_units AS 'This Column is used identify the units for the stock count'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.stock_count_snapshot_units AS 'This Column is used identify the units for the stock count snapshot'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.stock_count_retail_amt AS 'This Column is used identify the retail Amount for the stock count'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.stock_count_snapshot_retail_amt AS 'SUM of Stock_Count_Snapshot_Retail_Amt'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.total_stock_loss_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.total_stock_loss_value AS 'the real amount of inventory was adjusted by. This is a store measure.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.damaged_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = DAMAGED'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.damaged_adjustment_amount AS 'This Column is used to identify the Stock Damaged Adjustment Amount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.soiled_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = SOLID'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.soiled_adjustment_amount AS 'This Column is used identify the Soiled Adjustment amount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.auto_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = AUTO ADJUSTMNET'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.auto_adjustment_amount AS 'the real amount of inventory was adjusted by. This is a store measure. Type = AUTO ADJUSTMENT'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.other_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = OTHER ADJUSTMNET'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.other_adjustment_amount AS 'Contains the amount the inventory was adjusted by. This is a store measure. Type = OTHER ADJUSTMNET'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.psr_blocked_units AS 'Count of units which are not marked for PSR BLOCKED'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.psr_retail_amount AS 'Retail Value of the items which are not marked for PSR BLOCKED'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.psr_blocked_pack_units AS 'Count of Pack units which are not marked for PSR BLOCKED count(pack units) where PSR BLOCKED ind = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.psr_blocked_cost_amount AS 'Cost amount Blocked from Primark stock replenishment system'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.trasfer_ship_units AS 'Units of the transfer shipped quantity'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.trasfer_ship_retail_amount AS 'Retail Value of the transfer shipped quantity Retail price * Transfer received qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.trasfer_ship_cost_amount AS 'This Column is used identify the Shipment cost amount for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.stock_cnt_adj_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.stock_cnt_adj_retail_value AS 'the real amount of inventory was adjusted by. This is a store measure'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.soh_age_in_weeks AS 'Stock on hand units since the first time the item was intake'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_outst_units AS 'The amount of stock not yet shipped and outstanding to be shipped (TRANSFER REQUESTED UNITS - TRANSFER SHIPPED UNITS)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_outst_retail_value AS 'The amount of stock not yet shipped and outstanding to be shipped (TRANSFER REQUESTED UNITS - TRANSFER SHIPPED UNITS) * UNIT RETAIL PRICE (at sending Location)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_act_repo_cost_value AS 'Actual Cost Value incurred in reprocessing activities. In RMS reprocessing activities are done with transfers to internal or external finishers. Costs should be obtained from transfers or from invoicing?'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_act_upchrg_cost_value AS 'Actual upcharges Cost Value incurred in transfers of goods between Primark locations.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_act_upchrg_unit_cost AS 'Actual upcharges Unit Cost Price incurred in transfers of goods between Primark locations.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.nlp_stock_value AS 'Stock on NLP at retail value to understanding impact of pricing decisions'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.nlp_stock_units AS 'Units of stock which are listed on promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.ras_units AS 'Number of units listed for mark down/clearance - based on Price Status. Name to be changed to Clearance Sales Units.Clearance SOH to be added in the data dictionary.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.listed_stock AS 'Total SOH in Retail Value in the company - stores and wh(s) = SOH value (WH) + SOH value (Store).SOH VALUE (WH) + SOH VALUE (STORE) which are part of the proposed markdown'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.carryover_units AS 'Unit quantity of stock on hand for Items being carried over from current season to the next (at pack component level - sellable items).SOH UNITS where CARRYOVER FLAG = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.carryover_value AS 'Value of stock on hand for Items being carried over from current season to the next (at pack component level - sellable items).SOH VALUE where CARRYOVER FLAG = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.price_action_week AS 'The action Week of the future retail event (Price change, promotion or clearance).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.price_status AS 'Current status of the price of the product , whether it is Regular (Full Price), Promotion or Clearance (Markdown).Timebound version of Current Status, need to record status each day'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.transfer_outst_cost_value AS 'This Column is used identify the Outstanding transfer cost value'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.tsf_intake_qty AS 'This Column is used identify the Received Quantity for a transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.tsf_intake_retail_amount AS 'This Column is used identify the Retail amount for the received units for a transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.tsf_intake_cost_amount AS 'This Column is used identify the Received cost amount for a transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.ras_stock_value AS 'Value of RAS stock to measure impact of price reduction on gross and net margins'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.stock_unit_av_cost_amount AS 'This Column is used identify the Average cost amount of stock unit'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.wkly_flg AS 'Flag to identify the Data is at weekly level or daily level (Y- Yes, N-No)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2130_TRANS.listing_flg AS 'This Column is used identify the Listed Flag for stock markdown'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/