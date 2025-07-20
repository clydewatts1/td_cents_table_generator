
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_STK_FCT_02_FCT_STG = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG
    (
    business_date DATE NOT NULL FORMAT 'yyyy-mm-dd',
    location_id INTEGER NOT NULL FORMAT '99999',
    item_id BIGINT NOT NULL ,
    fct_src_map BYTEINT NOT NULL ,
    transfer_outst_units INTEGER  ,
    transfer_outst_retail_value DECIMAL(18,10)  ,
    transfer_outst_cost_value DECIMAL(18,10)  ,
    transfer_act_repo_cost_value DECIMAL(18,10)  ,
    transfer_act_upchrg_unit_cost DECIMAL(18,10)  ,
    transfer_act_upchrg_cost_value DECIMAL(18,10)  ,
    stock_count_units INTEGER  ,
    stock_count_snapshot_units INTEGER  ,
    stock_count_retail_amt DECIMAL(18,10)  ,
    stock_count_snapshot_retail_amt DECIMAL(18,10)  ,
    total_stock_loss_units INTEGER  ,
    total_stock_loss_value INTEGER  ,
    tsf_intake_qty INTEGER  ,
    tsf_intake_retail_amount DECIMAL(18,10)  ,
    tsf_intake_cost_amount DECIMAL(18,10)  ,
    trasfer_ship_units INTEGER  ,
    trasfer_ship_retail_amount DECIMAL(18,10)  ,
    trasfer_ship_cost_amount DECIMAL(18,10)       )
    PRIMARY INDEX ( Location_ID ,Item_Id ) PARTITION BY RANGE_N(Business_Date BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.business_date AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.location_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.fct_src_map AS 'Bit Map of source of data used in pivot table ( 02 )'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.transfer_outst_units AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.transfer_outst_retail_value AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.transfer_outst_cost_value AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.transfer_act_repo_cost_value AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.transfer_act_upchrg_unit_cost AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.transfer_act_upchrg_cost_value AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.stock_count_units AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.stock_count_snapshot_units AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.stock_count_retail_amt AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.stock_count_snapshot_retail_amt AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.total_stock_loss_units AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.total_stock_loss_value AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.tsf_intake_qty AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.tsf_intake_retail_amount AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.tsf_intake_cost_amount AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.trasfer_ship_units AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.trasfer_ship_retail_amount AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_02_FCT_STG.trasfer_ship_cost_amount AS 'TBD'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/