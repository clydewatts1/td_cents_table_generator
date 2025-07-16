
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_ITEM_DIM = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM
    (
    org_hiery_wid INTEGER NOT NULL ,
    org_hiery_vers_num SMALLINT NOT NULL ,
    org_hier_country_cd SMALLINT NOT NULL ,
    company_cd SMALLINT NOT NULL ,
    company_vers_num SMALLINT NOT NULL ,
    zone_cd SMALLINT NOT NULL ,
    zone_vers_num SMALLINT NOT NULL ,
    region_cd SMALLINT NOT NULL ,
    region_vers_num SMALLINT NOT NULL ,
    area_cd SMALLINT NOT NULL ,
    area_vers_num SMALLINT NOT NULL ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    UNIQUE PRIMARY INDEX(ORG_HIERY_WID)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM AS 'Store Hierarchy Versioning'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.org_hiery_vers_num AS 'This is the version of the locs within hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.org_hier_country_cd AS 'Contains the number of the country.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.company_cd AS 'This Column is used to identify the Primark Company Code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.company_vers_num AS 'The is the version of locs within company'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.zone_cd AS 'Uniquely identifies a time zone.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.zone_vers_num AS 'The is the version of locs within zone'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.region_cd AS 'This Column is used identify the Uniquely identifies a region.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.region_vers_num AS 'The is the version of locs within region'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.area_cd AS 'Code for Primark Area(Location)'
;




    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_ITEM_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/