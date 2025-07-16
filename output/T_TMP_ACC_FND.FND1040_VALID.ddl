
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1040_VALID = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID
    (
    styl_wid BIGINT NOT NULL ,
    item_sbclass_wid INTEGER NOT NULL ,
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
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID AS 'This table tracks the changes to the product / merchant hierarchy over time'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.styl_wid AS 'This is the style surrogate key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.item_sbclass_wid AS 'This contains the item subclass wid - this is the lowest grain for the merchant hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.styl_sbclass_vers_num AS 'This is the version number of subclass - if there a new style - version is last version id for sbclass , if changed then bumped version no for table'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/