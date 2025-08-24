
/*----------------------------------------------------------------------
* FileName: T_TMP_ACC_FND.FND1043_TRANS.ddl
* Project: Primark Reclassification Foundation
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1043_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS
    (
    merch_hiery_wid BIGINT NOT NULL  ,
    company_cd SMALLINT  FORMAT '99' ,
    pmk_co_wid BIGINT   ,
    company_name VARCHAR(15)   ,
    company_version_num SMALLINT   ,
    pmk_co_vers_reclass_evnt_ind BYTEINT  FORMAT '99' ,
    pmk_co_stl_in_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_co_stl_out_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_co_stl_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_co_stl_del_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_co_stl_new_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_co_stl_not_common_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_co_seq_no SMALLINT   ,
    division_cd SMALLINT   ,
    dvisn_wid BIGINT   ,
    division_name VARCHAR(15)   ,
    division_version_num SMALLINT   ,
    dvisn_vers_reclass_evnt_ind BYTEINT   ,
    dvisn_stl_in_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dvisn_stl_out_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dvisn_stl_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dvisn_stl_del_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dvisn_stl_new_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dvisn_stl_not_common_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dvisn_seq_no SMALLINT   ,
    department_cd SMALLINT   ,
    dept_wid BIGINT   ,
    department_name VARCHAR(50)   ,
    department_version_num SMALLINT   ,
    dept_reclass_evnt_ind BYTEINT   ,
    dept_stl_in_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dept_stl_out_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dept_stl_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dept_stl_del_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dept_stl_new_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dept_stl_not_common_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    dept_seq_no SMALLINT   ,
    class_cd SMALLINT   ,
    item_clas_wid BIGINT   ,
    class_name VARCHAR(50)   ,
    class_version_num SMALLINT   ,
    clas_evnt_ind BYTEINT   ,
    item_clas_stl_in_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_clas_stl_out_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_clas_stl_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_clas_stl_del_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_clas_stl_new_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_clas_stl_not_common_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_clas_seq_no SMALLINT   ,
    subclass_group_cd SMALLINT   ,
    subclass_group_name VARCHAR(50)   ,
    subclass_group_version_num SMALLINT   ,
    pmk_item_sbclas_grp_vers_reclass_evnt_ind BYTEINT   ,
    pmk_item_sbclas_grp_stl_in_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_item_sbclas_grp_stl_out_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_item_sbclas_grp_stl_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_item_sbclas_grp_stl_del_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_item_sbclas_grp_stl_new_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_item_sbclas_grp_stl_not_common_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    pmk_item_sbclas_grp_seq_no SMALLINT   ,
    subclass_cd SMALLINT   ,
    subclass_name VARCHAR(50)   ,
    subclass_version_num SMALLINT   ,
    subclass_vers_reclass_evnt_ind BYTEINT   ,
    item_sbclas_stl_in_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_sbclas_stl_out_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_sbclas_stl_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_sbclas_stl_del_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_sbclas_stl_new_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_sbclas_stl_not_common_cmn_count INTEGER  FORMAT '99999'  COMPRESS(0) ,
    item_sbclas_seq_no SMALLINT   ,
    buyer_cd VARCHAR(20)   ,
    buyer_name VARCHAR(50)    
    )
    PRIMARY INDEX(MERCH_HIERY_WID )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS AS 'This is the standard merchandise hierarchy , with version and addition reclass metrics'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.merch_hiery_wid AS 'Identification of the Merchandiser. Concatenation of MERCHANDISER NUMBER with MERCHANDISER NAME.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.company_cd AS 'This is the primark company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_wid AS 'Primark Company Surrogate Key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.company_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.company_version_num AS 'This is the current version associated with style and company code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_vers_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_co_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.division_cd AS 'This is the division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_wid AS 'Division surrogate key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.division_name AS 'Name of the Primark division'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.division_version_num AS 'This is the current version associated with style and division code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_vers_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dvisn_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.department_cd AS 'The is the department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_wid AS 'department surrogate key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.department_name AS 'Short text reference or label for a department'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.department_version_num AS 'This is the current version associated with style and department code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.dept_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.class_cd AS 'This is the class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_clas_wid AS 'item class surrogate key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.class_name AS 'This Column is used identify the Merch Hierarchy section name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.class_version_num AS 'This is the current version associated with style and class / section code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.clas_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_clas_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_clas_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_clas_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_clas_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_clas_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_clas_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_clas_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;



COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.subclass_group_version_num AS 'This is the current version associated with style and subgroup code 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_item_sbclas_grp_vers_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_item_sbclas_grp_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_item_sbclas_grp_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_item_sbclas_grp_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_item_sbclas_grp_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_item_sbclas_grp_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_item_sbclas_grp_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.pmk_item_sbclas_grp_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.subclass_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.subclass_name AS 'Names the subsection within the PRODUCT HIERARCHY. It corresponds to subclass in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.subclass_version_num AS 'This is the current version associated with style and section - group 0-N , 0 - means empty set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.subclass_vers_reclass_evnt_ind AS 'Version Reclassification event indicator 0: No reclass event , 1 : Reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_sbclas_stl_in_count AS 'Number styles that moved into the set/group - reclass movement'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_sbclas_stl_out_count AS 'Count of the number of items which moved out of a group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_sbclas_stl_cmn_count AS 'Count of the number of styles which have not changed group or set'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_sbclas_stl_del_count AS 'Number of styles deleted from group or set - should not happen because styles are never deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_sbclas_stl_new_count AS 'Number of new styles add to the group does not impact reclass event'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_sbclas_stl_not_common_cmn_count AS 'This is the count of common not common count in reclass - should be 0'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.item_sbclas_seq_no AS 'Sequence Number within group ordered by subclass wid , helper to get unique group , that is = 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.buyer_cd AS 'Identification of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_TRANS.buyer_name AS 'Name of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/