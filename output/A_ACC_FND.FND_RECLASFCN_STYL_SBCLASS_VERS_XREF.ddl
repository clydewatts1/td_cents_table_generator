
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}A_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_RECLASFCN_STYL_SBCLASS_VERS_XREF */
REPLACE VIEW DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF
    AS LOCKING ROW FOR ACCESS

SELECT
    item_sbclas_wid ,
    pmk_co_cd ,
    pmk_co_vers_num ,
    dvisn_cd ,
    dvisn_vers_num ,
    dept_cd ,
    dept_vers_num ,
    item_clas_cd ,
    item_clas_vers_num ,
    pmk_item_sbclas_grp_cd ,
    pmk_item_sbclas_grp_vers_num ,
    item_sbclas_cd ,
    item_sbclas_vers_num ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF AS ''
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.item_sbclas_wid AS 'This contains the item subclass wid - this is the lowest grain for the merchant hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.pmk_co_cd AS 'This is the primark company code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.pmk_co_vers_num AS 'This is the current version associated with style and company code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.dvisn_cd AS 'This is the division code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.dvisn_vers_num AS 'This is the current version associated with style and division code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.dept_cd AS 'The is the department code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.dept_vers_num AS 'This is the current version associated with style and department code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.item_clas_cd AS 'This is the class / section code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.item_clas_vers_num AS 'This is the current version associated with style and class / section code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.pmk_item_sbclas_grp_cd AS 'This is the group subclass - group section'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.pmk_item_sbclas_grp_vers_num AS 'This is the current version associated with style and subclass - group'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.item_sbclas_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.item_sbclas_vers_num AS 'This is the current version associated with style and section - group'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_VERS_XREF.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/