
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_LOC_ITEM_PVT_FCT = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT
    (
    business_date DATE NOT NULL FORMAT 'YYYY-MM-DD',
    loc_id INTEGER NOT NULL FORMAT '99999',
    item_id BIGINT NOT NULL FORMAT '999999999999',
    ly_business_date DATE NOT NULL FORMAT 'yyyy-mm-dd',
    ty_sales_ind BYTEINT NOT NULL ,
    ty_stock_ind BYTEINT NOT NULL ,
    ly_sales_ind BYTEINT NOT NULL ,
    ly_stock_ind BYTEINT NOT NULL ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    PRIMARY INDEX ( Loc_ID ,Item_Id ) PARTITION BY RANGE_N(Business_Date BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.business_date AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.loc_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ly_business_date AS 'Last year business date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ty_sales_ind AS 'Indicates if the sales data was present for this row'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ty_stock_ind AS 'Indicates if the sales data was present for this year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ly_sales_ind AS 'Indicates if the sales data for last year primark calendar date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ly_stock_ind AS 'Indicates if the sales data for last year primark calendar date'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/