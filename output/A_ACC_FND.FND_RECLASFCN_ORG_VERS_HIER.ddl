
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}A_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_RECLASFCN_ORG_VERS_HIER */
REPLACE VIEW DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER
    AS LOCKING ROW FOR ACCESS

SELECT
    org_hiery_wid ,
    org_hiery_vers_num ,
    org_hier_country_cd ,
    company_cd ,
    company_vers_num ,
    zone_cd ,
    zone_vers_num ,
    region_cd ,
    region_vers_num ,
    area_cd ,
    area_vers_num ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER AS ''
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.org_hiery_vers_num AS 'This is the version of the locs within hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.org_hier_country_cd AS 'Contains the number of the country.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.company_cd AS 'This Column is used to identify the Primark Company Code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.company_vers_num AS 'The is the version of locs within company'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.zone_cd AS 'Uniquely identifies a time zone.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.zone_vers_num AS 'The is the version of locs within zone'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.region_cd AS 'This Column is used identify the Uniquely identifies a region.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.region_vers_num AS 'The is the version of locs within region'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.area_cd AS 'Code for Primark Area(Location)'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.area_vers_num AS ''
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/