
/*----------------------------------------------------------------------
* FileName: T_TMP_ACC_FND.FND1043_VALID.ddl
* Project: Primark Reclassification Foundation
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1043_VALID = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID
    (
    merch_hiery_wid BIGINT NOT NULL   ,
    company_cd SMALLINT    ,
    pmk_co_wid BIGINT    ,
    company_name VARCHAR(15)    ,
    company_version_num SMALLINT    ,
    pmk_co_vers_reclass_evnt_ind BYTEINT    ,
    pmk_co_stl_in_count INTEGER    COMPRESS(0)  ,
    pmk_co_stl_out_count INTEGER    COMPRESS(0)  ,
    pmk_co_stl_cmn_count INTEGER    COMPRESS(0)  ,
    pmk_co_stl_del_count INTEGER    COMPRESS(0)  ,
    pmk_co_stl_new_count INTEGER    COMPRESS(0)  ,
    pmk_co_stl_not_common_cmn_count INTEGER    COMPRESS(0)  ,
    pmk_co_seq_no SMALLINT    ,
    division_cd SMALLINT    ,
    dvisn_wid BIGINT    ,
    division_name VARCHAR(15)    ,
    division_version_num SMALLINT    ,
    dvisn_vers_reclass_evnt_ind BYTEINT    ,
    dvisn_stl_in_count INTEGER    COMPRESS(0)  ,
    dvisn_stl_out_count INTEGER    COMPRESS(0)  ,
    dvisn_stl_cmn_count INTEGER    COMPRESS(0)  ,
    dvisn_stl_del_count INTEGER    COMPRESS(0)  ,
    dvisn_stl_new_count INTEGER    COMPRESS(0)  ,
    dvisn_stl_not_common_cmn_count INTEGER    COMPRESS(0)  ,
    dvisn_seq_no SMALLINT    ,
    department_cd SMALLINT    ,
    dept_wid BIGINT    ,
    department_name VARCHAR(50)    ,
    department_version_num SMALLINT    ,
    dept_reclass_evnt_ind BYTEINT    ,
    dept_stl_in_count INTEGER    COMPRESS(0)  ,
    dept_stl_out_count INTEGER    COMPRESS(0)  ,
    dept_stl_cmn_count INTEGER    COMPRESS(0)  ,
    dept_stl_del_count INTEGER    COMPRESS(0)  ,
    dept_stl_new_count INTEGER    COMPRESS(0)  ,
    dept_stl_not_common_cmn_count INTEGER    COMPRESS(0)  ,
    dept_seq_no SMALLINT    ,
    class_cd SMALLINT    ,
    item_clas_wid BIGINT    ,
    class_name VARCHAR(50)    ,
    class_version_num SMALLINT    ,
    clas_evnt_ind BYTEINT    ,
    item_clas_stl_in_count INTEGER    COMPRESS(0)  ,
    item_clas_stl_out_count INTEGER    COMPRESS(0)  ,
    item_clas_stl_cmn_count INTEGER    COMPRESS(0)  ,
    item_clas_stl_del_count INTEGER    COMPRESS(0)  ,
    item_clas_stl_new_count INTEGER    COMPRESS(0)  ,
    item_clas_stl_not_common_cmn_count INTEGER    COMPRESS(0)  ,
    item_clas_seq_no SMALLINT    ,
    subclass_group_cd SMALLINT    ,
    subclass_group_name VARCHAR(50)    ,
    subclass_group_version_num SMALLINT    ,
    pmk_item_sbclas_grp_vers_reclass_evnt_ind BYTEINT    ,
    pmk_item_sbclas_grp_stl_in_count INTEGER    COMPRESS(0)  ,
    pmk_item_sbclas_grp_stl_out_count INTEGER    COMPRESS(0)  ,
    pmk_item_sbclas_grp_stl_cmn_count INTEGER    COMPRESS(0)  ,
    pmk_item_sbclas_grp_stl_del_count INTEGER    COMPRESS(0)  ,
    pmk_item_sbclas_grp_stl_new_count INTEGER    COMPRESS(0)  ,
    pmk_item_sbclas_grp_stl_not_common_cmn_count INTEGER    COMPRESS(0)  ,
    pmk_item_sbclas_grp_seq_no SMALLINT    ,
    subclass_cd SMALLINT    ,
    subclass_name VARCHAR(50)    ,
    subclass_version_num SMALLINT    ,
    subclass_vers_reclass_evnt_ind BYTEINT    ,
    item_sbclas_stl_in_count INTEGER    COMPRESS(0)  ,
    item_sbclas_stl_out_count INTEGER    COMPRESS(0)  ,
    item_sbclas_stl_cmn_count INTEGER    COMPRESS(0)  ,
    item_sbclas_stl_del_count INTEGER    COMPRESS(0)  ,
    item_sbclas_stl_new_count INTEGER    COMPRESS(0)  ,
    item_sbclas_stl_not_common_cmn_count INTEGER    COMPRESS(0)  ,
    item_sbclas_seq_no SMALLINT    ,
    buyer_cd VARCHAR(20)    ,
    buyer_name VARCHAR(50)    ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(16) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(16) COMPRESS(NULL)
    )
    PRIMARY INDEX(MERCH_HIERY_WID )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID AS 'This is the standard merchandise hierarchy , with version and addition reclass metrics'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.merch_hiery_wid AS 'Identification of the Merchandiser. Concatenation of MERCHANDISER NUMBER with MERCHANDISER NAME.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.company_cd AS 'This is the primark company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_wid AS 'Primark Company Surrogate Key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.company_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.company_version_num AS 'This is the current version associated with style and company code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_vers_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_co_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.division_cd AS 'This is the division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_wid AS 'Division surrogate key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.division_name AS 'Name of the Primark division'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.division_version_num AS 'This is the current version associated with style and division code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_vers_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dvisn_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.department_cd AS 'The is the department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_wid AS 'department surrogate key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.department_name AS 'Short text reference or label for a department'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.department_version_num AS 'This is the current version associated with style and department code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.dept_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.class_cd AS 'This is the class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_clas_wid AS 'item class surrogate key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.class_name AS 'This Column is used identify the Merch Hierarchy section name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.class_version_num AS 'This is the current version associated with style and class / section code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.clas_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_clas_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_clas_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_clas_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_clas_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_clas_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_clas_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_clas_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;



COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_group_version_num AS 'This is the current version associated with style and subgroup code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_item_sbclas_grp_vers_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_item_sbclas_grp_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_item_sbclas_grp_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_item_sbclas_grp_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_item_sbclas_grp_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_item_sbclas_grp_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_item_sbclas_grp_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.pmk_item_sbclas_grp_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_name AS 'Names the subsection within the PRODUCT HIERARCHY. It corresponds to subclass in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_version_num AS 'This is the current version associated with style and section - group 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_vers_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_sbclas_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_sbclas_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_sbclas_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_sbclas_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_sbclas_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_sbclas_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.item_sbclas_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.buyer_cd AS 'Identification of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.buyer_name AS 'Name of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/