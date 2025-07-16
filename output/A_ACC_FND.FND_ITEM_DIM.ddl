
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}A_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_RECLASFCN_ORG_VERS_HIER tracks changes to the hierarchy versioning as stores move within the hierarchy */
REPLACE VIEW DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM
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
FROM  DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_ORG_VERS_HIER tracks changes to the hierarchy versioning as stores move within the hierarchy
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM AS ''
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.org_hiery_vers_num AS 'This is the version of the locs within hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.org_hier_country_cd AS 'Contains the number of the country.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.company_cd AS 'This Column is used to identify the Primark Company Code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.company_vers_num AS 'The is the version of locs within company'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.zone_cd AS 'Uniquely identifies a time zone.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.zone_vers_num AS 'The is the version of locs within zone'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.region_cd AS 'This Column is used identify the Uniquely identifies a region.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.region_vers_num AS 'The is the version of locs within region'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.area_cd AS 'Code for Primark Area(Location)'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.area_vers_num AS ''
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.FND_ITEM_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/