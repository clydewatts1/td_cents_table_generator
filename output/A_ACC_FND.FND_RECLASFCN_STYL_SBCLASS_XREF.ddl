
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}A_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_RECLASFCN_STYL_SBCLASS_XREF */
REPLACE VIEW DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF
    AS LOCKING ROW FOR ACCESS

SELECT
    styl_wid ,
    item_sbclass_wid ,
    styl_sbclass_vers_num ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF AS ''
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.styl_wid AS 'This is the style surrogate key'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.item_sbclass_wid AS 'This contains the item subclass wid - this is the lowest grain for the merchant hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.styl_sbclass_vers_num AS 'This is the version number of subclass - if there a new style - version is last version id for sbclass , if changed then bumped version no for table'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/