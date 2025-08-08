
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_RECLASFCN_STYL_SBCLASS_XREF = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF
    (
    styl_wid BIGINT NOT NULL ,
    item_sbclas_wid INTEGER NOT NULL ,
    styl_sbclass_vers_num INTEGER NOT NULL ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    PRIMARY INDEX(styl_wid)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF AS 'This table tracks the changes to the product / merchant hierarchy over time'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.styl_wid AS 'This is the style surrogate key'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.item_sbclas_wid AS 'This contains the item subclass wid - this is the lowest grain for the merchant hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.styl_sbclass_vers_num AS 'This is the version number of subclass - if there a new style - version is last version id for sbclass , if changed then bumped version no for table'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/