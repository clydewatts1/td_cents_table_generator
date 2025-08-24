
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1041_VALID = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID
    (
    item_sbclas_wid INTEGER NOT NULL ,
    pmk_co_cd SMALLINT NOT NULL ,
    pmk_co_vers_num SMALLINT NOT NULL ,
    dvisn_cd SMALLINT NOT NULL ,
    dvisn_vers_num SMALLINT NOT NULL ,
    dept_cd SMALLINT NOT NULL ,
    dept_vers_num SMALLINT NOT NULL ,
    item_clas_cd SMALLINT NOT NULL ,
    item_clas_vers_num SMALLINT NOT NULL ,
    pmk_item_sbclas_grp_cd SMALLINT NOT NULL ,
    pmk_item_sbclas_grp_vers_num SMALLINT NOT NULL ,
    item_sbclas_cd SMALLINT NOT NULL ,
    item_sbclas_vers_num SMALLINT NOT NULL ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    PRIMARY INDEX(item_sbclas_wid)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID AS 'This table tracks the changes to the product / merchant hierarchy over time'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.item_sbclas_wid AS 'This contains the item subclass wid - this is the lowest grain for the merchant hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.pmk_co_cd AS 'This is the primark company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.pmk_co_vers_num AS 'This is the current version associated with style and company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.dvisn_cd AS 'This is the division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.dvisn_vers_num AS 'This is the current version associated with style and division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.dept_cd AS 'The is the department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.dept_vers_num AS 'This is the current version associated with style and department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.item_clas_cd AS 'This is the class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.item_clas_vers_num AS 'This is the current version associated with style and class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.pmk_item_sbclas_grp_cd AS 'This is the group subclass - group section'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.pmk_item_sbclas_grp_vers_num AS 'This is the current version associated with style and subclass - group'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.item_sbclas_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.item_sbclas_vers_num AS 'This is the current version associated with style and section - group'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_VALID.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/