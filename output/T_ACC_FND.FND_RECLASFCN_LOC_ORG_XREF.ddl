
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_RECLASFCN_LOC_ORG_XREF = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF
    (
    org_hiery_wid INTEGER NOT NULL ,
    loc_wid INTEGER NOT NULL ,
    loc_org_hier_vers_num INTEGER  ,
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
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF AS 'Store Hierarchy Cross Reference'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.loc_wid AS 'Unique Identifier for Location ID this is either the store or the warehouse'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.loc_org_hier_vers_num AS 'This is the version number of location in the organization hierarchy - if there a new location - version is last version id for lowest level of hierarchy , if changed then bumped version no for table'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_LOC_ORG_XREF.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/