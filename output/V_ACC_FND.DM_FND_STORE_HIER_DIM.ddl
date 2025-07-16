
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}V_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DM_FND_STORE_HIER_DIM */
REPLACE VIEW DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM
    AS
SELECT
    org_hiery_wid ,
    org_hier_country_cd ,
    org_hier_country_name ,
    org_hiery_vers_num ,
    company_cd ,
    company_name ,
    company_vers_num ,
    zone_cd ,
    zone_name ,
    zone_vers_num ,
    region_cd ,
    region_name ,
    region_old ,
    region_vers_num ,
    area_cd ,
    area_name ,
    area_vers_num ,
    zone_manager_name ,
    region_manager_name ,
    area_manager_name ,
    org_hier_country_mgr_name ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.DM_FND_STORE_HIER_DIM
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM AS ''
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.org_hier_country_cd AS 'Contains the number of the country.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.org_hier_country_name AS 'Name of the Country of locations in the organizational hierarchy. It corresponded to District in Oracle Retail Organizational hierarchy. A Country consists of one or more locations.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.org_hiery_vers_num AS 'This is the version of the locs within hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.company_cd AS 'This Column is used to identify the Primark Company Code'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.company_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.company_vers_num AS 'The is the version of locs within company'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.zone_cd AS 'Uniquely identifies a time zone.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.zone_name AS 'Name of Primark Zones in the organization hierarchy. It corresponds to Chain in ORMS hierarchy. A Zone consists of one or more Primark regions. A Zone consists of one or more Primark regions grouped for financial planning purposes.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.zone_vers_num AS 'The is the version of locs within zone'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.region_cd AS 'This Column is used identify the Uniquely identifies a region.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.region_name AS 'Short text reference or label for the region.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.region_old AS 'An intermediate organization grouping level within the geographic hierarchy, which groups LOCATIONs. A specific regional geographic area of the country or county.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.region_vers_num AS 'The is the version of locs within region'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.area_cd AS 'Code for Primark Area(Location)'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.area_name AS 'Identification of Primark Area in the Organisation hierarchy. It corresponds to REGION in Oracle Retail Organizational Hierarchy. A Primark area represents a group of countries. Concatenation of Area Number with Area Name'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.area_vers_num AS 'The is the version of locs within area'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.zone_manager_name AS 'This Column is used identify the Manager name for Primark Zone'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.region_manager_name AS 'An individual who is employed by the enterprise. The manager of the region.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.area_manager_name AS 'Person who manages the specific area in the region.'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.org_hier_country_mgr_name AS 'Person who manages the specific area in the region.'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}V_ACC_FND.DM_FND_STORE_HIER_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/