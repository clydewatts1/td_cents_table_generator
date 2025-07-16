
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}A_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_LOC_ITEM_PVT_FCT */
REPLACE VIEW DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT
    AS LOCKING ROW FOR ACCESS

SELECT
    business_date ,
    loc_id ,
    item_id ,
    ly_business_date ,
    ty_sales_ind ,
    ty_stock_ind ,
    ly_sales_ind ,
    ly_stock_ind ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT AS ''
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.business_date AS 'Business Date (PK)'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.loc_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ly_business_date AS 'Last year business date'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ty_sales_ind AS 'Indicates if the sales data was present for this row'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ty_stock_ind AS 'Indicates if the sales data was present for this year'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ly_sales_ind AS 'Indicates if the sales data for last year primark calendar date'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.ly_stock_ind AS 'Indicates if the sales data for last year primark calendar date'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/