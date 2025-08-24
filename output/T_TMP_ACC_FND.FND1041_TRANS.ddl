
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1041_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS
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
    item_sbclas_vers_num SMALLINT NOT NULL      )
    PRIMARY INDEX(item_sbclas_wid)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS AS 'This table tracks the changes to the product / merchant hierarchy over time'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.item_sbclas_wid AS 'This contains the item subclass wid - this is the lowest grain for the merchant hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.pmk_co_cd AS 'This is the primark company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.pmk_co_vers_num AS 'This is the current version associated with style and company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.dvisn_cd AS 'This is the division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.dvisn_vers_num AS 'This is the current version associated with style and division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.dept_cd AS 'The is the department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.dept_vers_num AS 'This is the current version associated with style and department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.item_clas_cd AS 'This is the class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.item_clas_vers_num AS 'This is the current version associated with style and class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.pmk_item_sbclas_grp_cd AS 'This is the group subclass - group section'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.pmk_item_sbclas_grp_vers_num AS 'This is the current version associated with style and subclass - group'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.item_sbclas_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1041_TRANS.item_sbclas_vers_num AS 'This is the current version associated with style and section - group'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/