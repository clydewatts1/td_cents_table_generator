
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_STK_FCT_03_FCT_STG = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG
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
    psr_blocked_units INTEGER NOT NULL ,
    psr_retail_amount DECIMAL(18,10) NOT NULL ,
    psr_blocked_pack_units INTEGER NOT NULL ,
    psr_blocked_cost_amount DECIMAL(18,10) NOT NULL ,
    carryover_units INTEGER NOT NULL ,
    carryover_value DECIMAL(18,10) NOT NULL ,
    stock_unit_av_cost_amount INTEGER NOT NULL ,
    regular_unit_retail_amt INTEGER NOT NULL      )
    PRIMARY INDEX ( Location_ID ,Item_Id ) PARTITION BY RANGE_N(Business_Date BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.business_date AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.location_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.location_soh_units AS 'This Column is used identify the Primark Location stock on hand units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.depot_soh_units AS 'This column is used to identify the Depot Stock On Hand Units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.location_pack_units AS 'This Column is used identify the Primark Location pack units'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.depot_pack_units AS 'SOH_Pack_Units from the stock position table for the specific WH'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.location_retail_amount AS 'This Column is used identify the Primark Location retail amount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.depot_retail_amount AS 'SOH_Retail_Amount from the stock position table for the specific WH'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.unit_cost_amount AS 'This Column is used identify the Unit cost price of an item'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.unit_retail_amount AS 'Unit price value at retail for the specific item.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.on_order_units AS 'Unit quantity at point of ordering of items on order (commitment ordered and not yet received).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.on_order_cost_amount AS 'Value quantity of items on order (ordered and not yet received = COMMITMENT COST VALUE).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.on_order_retail_amount AS 'Retail Value of Packs on order (commitment ordered and not yet received).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.on_order_pack_units AS 'Quantity of packs ordered on the destination PO. (Packing Method - Cartons and Sets)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.return_to_vendor_cost_amount AS 'This Column is used identify the Retail value of the RTV units (RTV units * Unit retail price)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.return_to_vendor_retail_amount AS 'Cost value for the item being returned that is expected to be recovered from the supplier. RTV NON MERCH COST VALUE + RTV MERCH COST VALUE'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.return_to_vendor_units AS 'Sum of Units for the item being returned that is expected to be recovered from the supplier.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.return_to_vendor_pack_units AS 'Sum of Units for the Pack being returned that is expected to be recovered from the supplier.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.transfer_expected_retail_amount AS 'Supplier cost Value of the units transfer Supplier unit cost * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.transfer_expected_pack_units AS 'Pack units of the transfer quantity'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.transfer_expected_cost_amount AS 'Retail Value of the transfer quantity Retail price * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.transfer_expected_units AS 'This Column is used identify the Units of the transfer quantity'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.transfer_reserved_retail_amount AS 'Supplier cost amount of units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.transfer_reserved_pack_units AS 'Pack Units confirmed for Transfer But yet to transferred'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.transfer_reserved_cost_amount AS 'Retail amount of units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.transfer_reserved_units AS 'This Column is used identify the Units confirmed for Transfer'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.in_transit_retail_amount AS 'Supplier cost value of the items in-transit Supplier unit cost * in transit qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.in_transit_pack_units AS 'Pack units of the items in transit'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.in_transit_units AS 'Quantity of transfers in Transit between two locations.TRANSFER SHIPPED UNITS - TRANSFER RECEIVED UNITS'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.in_transit_cost_amount AS 'Quantity of transfers in Transit between two locations. TRANSFER SHIPPED VALUE - TRANSFER RECEIVED VALUE'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.non_sellable_retail_amount AS 'Supplier cost of the items which are not marked for sale supplier cost * count(items) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.non_sellable_pack_units AS 'Count of Pack units which are not marked for sale count(pack units) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.non_sellable_cost_amount AS 'Retail Value of the items which are not marked for sale Retail price * count(items) where sellable ind = N'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.non_sellable_units AS 'Supplier cost Value of the units transfer Supplier unit cost * Transfer qty'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.psr_blocked_units AS 'Count of units which are not marked for PSR BLOCKED'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.psr_retail_amount AS 'Retail Value of the items which are not marked for PSR BLOCKED'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.psr_blocked_pack_units AS 'Count of Pack units which are not marked for PSR BLOCKED count(pack units) where PSR BLOCKED ind = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.psr_blocked_cost_amount AS 'Cost amount Blocked from Primark stock replenishment system'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.carryover_units AS 'Unit quantity of stock on hand for Items being carried over from current season to the next (at pack component level - sellable items).SOH UNITS where CARRYOVER FLAG = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.carryover_value AS 'Value of stock on hand for Items being carried over from current season to the next (at pack component level - sellable items).SOH VALUE where CARRYOVER FLAG = Y'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.stock_unit_av_cost_amount AS 'This Column is used identify the Average cost amount of stock unit'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_03_FCT_STG.regular_unit_retail_amt AS 'Unit Retail amount for regular price'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/