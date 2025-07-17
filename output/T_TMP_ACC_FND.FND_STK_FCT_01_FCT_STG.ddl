
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_STK_FCT_01_FCT_STG = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG
    (
    business_date DATE NOT NULL FORMAT 'yyyy-mm-dd',
    location_id INTEGER NOT NULL FORMAT '99999',
    item_id BIGINT NOT NULL ,
    fct_src_map BYTEINT NOT NULL ,
    location_soh_units INTEGER  ,
    depot_soh_units INTEGER  ,
    location_pack_units INTEGER  ,
    depot_pack_units INTEGER  ,
    location_retail_amount DECIMAL(18,10)  ,
    depot_retail_amount DECIMAL(18,10)  ,
    unit_cost_amount INTEGER  ,
    unit_retail_amount INTEGER  ,
    on_order_units INTEGER  ,
    on_order_cost_amount DECIMAL(18,10)  ,
    on_order_retail_amount DECIMAL(18,10)  ,
    on_order_pack_units INTEGER  ,
    return_to_vendor_cost_amount DECIMAL(18,10)  ,
    return_to_vendor_retail_amount DECIMAL(18,10)  ,
    return_to_vendor_units INTEGER  ,
    return_to_vendor_pack_units INTEGER  ,
    transfer_expected_retail_amount DECIMAL(18,10)  ,
    transfer_expected_pack_units INTEGER  ,
    transfer_expected_cost_amount DECIMAL(18,10)  ,
    transfer_expected_units INTEGER  ,
    transfer_reserved_retail_amount DECIMAL(18,10)  ,
    transfer_reserved_pack_units INTEGER  ,
    transfer_reserved_cost_amount DECIMAL(18,10)  ,
    transfer_reserved_units INTEGER  ,
    in_transit_retail_amount DECIMAL(18,10)  ,
    in_transit_pack_units INTEGER  ,
    in_transit_units INTEGER  ,
    in_transit_cost_amount DECIMAL(18,10)  ,
    non_sellable_retail_amount DECIMAL(18,10)  ,
    non_sellable_pack_units INTEGER  ,
    non_sellable_cost_amount DECIMAL(18,10)  ,
    non_sellable_units INTEGER  ,
    psr_blocked_units INTEGER  ,
    psr_retail_amount DECIMAL(18,10)  ,
    psr_blocked_pack_units INTEGER  ,
    psr_blocked_cost_amount DECIMAL(18,10)  ,
    carryover_units INTEGER  ,
    carryover_value DECIMAL(18,10)  ,
    stock_unit_av_cost_amount INTEGER  ,
    regular_unit_retail_amt INTEGER  ,
    damaged_adjustment_units INTEGER  ,
    damaged_adjustment_amount DECIMAL(18,10)  ,
    soiled_adjustment_units INTEGER  ,
    soiled_adjustment_amount DECIMAL(18,10)  ,
    auto_adjustment_units INTEGER  ,
    auto_adjustment_amount DECIMAL(18,10)  ,
    other_adjustment_units INTEGER  ,
    other_adjustment_amount DECIMAL(18,10)  ,
    stock_cnt_adj_units INTEGER  ,
    stock_cnt_adj_retail_value DECIMAL(18,10)  ,
    listed_stock INTEGER  ,
    listing_flg CHAR(1)  ,
    nlp_stock_value DECIMAL(18,10)  ,
    nlp_stock_units INTEGER  ,
    ras_units INTEGER  ,
    ras_stock_value DECIMAL(18,10)  ,
    price_action_week INTEGER  ,
    price_status VARCHAR(20)  ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    PRIMARY INDEX ( Location_ID ,Item_Id ) PARTITION BY RANGE_N(Business_Date BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.business_date AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.location_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.fct_src_map AS 'Bit Map of source of data used in pivot table ( 01 )'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.location_soh_units AS 'This Column is used identify the Primark Location stock on hand units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.depot_soh_units AS 'This column is used to identify the Depot Stock On Hand Units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.location_pack_units AS 'This Column is used identify the Primark Location pack units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.depot_pack_units AS 'SOH_Pack_Units from the stock position table for the specific WH'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.location_retail_amount AS 'This Column is used identify the Primark Location retail amount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.depot_retail_amount AS 'SOH_Retail_Amount from the stock position table for the specific WH'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.unit_cost_amount AS 'This Column is used identify the Unit cost price of an item'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.unit_retail_amount AS 'Unit price value at retail for the specific item.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.on_order_units AS 'Unit quantity at point of ordering of items on order (commitment ordered and not yet received).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.on_order_cost_amount AS 'Value quantity of items on order (ordered and not yet received = COMMITMENT COST VALUE).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.on_order_retail_amount AS 'Retail Value of Packs on order (commitment ordered and not yet received).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.on_order_pack_units AS 'Quantity of packs ordered on the destination PO. (Packing Method - Cartons and Sets)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.return_to_vendor_cost_amount AS 'This Column is used identify the Retail value of the RTV units (RTV units * Unit retail price)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.return_to_vendor_retail_amount AS 'Cost value for the item being returned that is expected to be recovered from the supplier. RTV NON MERCH COST VALUE + RTV MERCH COST VALUE'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.return_to_vendor_units AS 'Sum of Units for the item being returned that is expected to be recovered from the supplier.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.return_to_vendor_pack_units AS 'Sum of Units for the Pack being returned that is expected to be recovered from the supplier.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.transfer_expected_retail_amount AS 'Supplier cost Value of the units transfer Supplier unit cost * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.transfer_expected_pack_units AS 'Pack units of the transfer quantity'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.transfer_expected_cost_amount AS 'Retail Value of the transfer quantity Retail price * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.transfer_expected_units AS 'This Column is used identify the Units of the transfer quantity'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.transfer_reserved_retail_amount AS 'Supplier cost amount of units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.transfer_reserved_pack_units AS 'Pack Units confirmed for Transfer But yet to transferred'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.transfer_reserved_cost_amount AS 'Retail amount of units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.transfer_reserved_units AS 'This Column is used identify the Units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.in_transit_retail_amount AS 'Supplier cost value of the items in-transit Supplier unit cost * in transit qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.in_transit_pack_units AS 'Pack units of the items in transit'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.in_transit_units AS 'Quantity of transfers in Transit between two locations.TRANSFER SHIPPED UNITS - TRANSFER RECEIVED UNITS'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.in_transit_cost_amount AS 'Quantity of transfers in Transit between two locations. TRANSFER SHIPPED VALUE - TRANSFER RECEIVED VALUE'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.non_sellable_retail_amount AS 'Supplier cost of the items which are not marked for sale supplier cost * count(items) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.non_sellable_pack_units AS 'Count of Pack units which are not marked for sale count(pack units) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.non_sellable_cost_amount AS 'Retail Value of the items which are not marked for sale Retail price * count(items) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.non_sellable_units AS 'Supplier cost Value of the units transfer Supplier unit cost * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.psr_blocked_units AS 'Count of units which are not marked for PSR BLOCKED'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.psr_retail_amount AS 'Retail Value of the items which are not marked for PSR BLOCKED'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.psr_blocked_pack_units AS 'Count of Pack units which are not marked for PSR BLOCKED count(pack units) where PSR BLOCKED ind = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.psr_blocked_cost_amount AS 'Cost amount Blocked from Primark stock replenishment system'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.carryover_units AS 'Unit quantity of stock on hand for Items being carried over from current season to the next (at pack component level - sellable items).SOH UNITS where CARRYOVER FLAG = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.carryover_value AS 'Value of stock on hand for Items being carried over from current season to the next (at pack component level - sellable items).SOH VALUE where CARRYOVER FLAG = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.stock_unit_av_cost_amount AS 'This Column is used identify the Average cost amount of stock unit'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.regular_unit_retail_amt AS 'Unit Retail amount for regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.damaged_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = DAMAGED'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.damaged_adjustment_amount AS 'This Column is used to identify the Stock Damaged Adjustment Amount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.soiled_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = SOLID'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.soiled_adjustment_amount AS 'This Column is used identify the Soiled Adjustment amount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.auto_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = AUTO ADJUSTMNET'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.auto_adjustment_amount AS 'the real amount of inventory was adjusted by. This is a store measure. Type = AUTO ADJUSTMENT'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.other_adjustment_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure. Type = OTHER ADJUSTMNET'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.other_adjustment_amount AS 'Contains the amount the inventory was adjusted by. This is a store measure. Type = OTHER ADJUSTMNET'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.stock_cnt_adj_units AS 'Contains the quantity the inventory was adjusted by. This is a store measure'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.stock_cnt_adj_retail_value AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.listed_stock AS 'The number of units of listed stock based on listing_flag and location_stock on hand'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.listing_flg AS 'Indicates if the Markdown is Listed Y/N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.nlp_stock_value AS 'NLP( next lowest price) On Hand Stock Value'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.nlp_stock_units AS 'NLP( next lowest price) On Hand Stock Units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.ras_units AS 'RAS( Clearance) On Hand Stock Value'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.ras_stock_value AS 'RAS( next lowest price) On Hand Stock Units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.price_action_week AS 'The Year Week the price was set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.price_status AS 'The price status Regular,Clearance,Promotion'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/