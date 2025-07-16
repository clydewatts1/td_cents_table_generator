
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}C_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create view for FND_RECLASFCN_LOC_ORG_XREF */
REPLACE VIEW DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF
    AS LOCKING ROW FOR ACCESS

SELECT
    org_hiery_wid ,
    loc_wid ,
    loc_org_hier_vers_num ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF AS ''
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.loc_wid AS 'Unique Identifier for Location ID this is either the store or the warehouse'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.loc_org_hier_vers_num AS 'This is the version number of location in the organization hierarchy - if there a new location - version is last version id for lowest level of hierarchy , if changed then bumped version no for table'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}C_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/