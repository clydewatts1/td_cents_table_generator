
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1042_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS
    (
    merch_hiery_wid INTEGER NOT NULL ,
    company_cd SMALLINT NOT NULL FORMAT '99',
    company_version_num SMALLINT  ,
    division_cd SMALLINT NOT NULL FORMAT '99',
    division_version_num SMALLINT  ,
    department_cd SMALLINT NOT NULL FORMAT '99',
    department_version_num SMALLINT  ,
    class_cd SMALLINT NOT NULL FORMAT '999',
    class_version_num SMALLINT  ,
    subclass_grp_cd SMALLINT NOT NULL FORMAT '999',
    subclass_grp_version_num SMALLINT  ,
    subclass_cd SMALLINT NOT NULL FORMAT '999',
    subclass_version_num SMALLINT  ,
    company_name VARCHAR(128) NOT NULL ,
    division_name VARCHAR(128) NOT NULL ,
    department_name VARCHAR(128) NOT NULL ,
    class_name VARCHAR(128) NOT NULL ,
    subclass_grp_name VARCHAR(128) NOT NULL ,
    subclass_name VARCHAR(128) NOT NULL ,
    buyer_cd VARCHAR(128) NOT NULL ,
    buyer_name VARCHAR(128) NOT NULL      )
    UNIQUE PRIMARY INDEX(MERCH_HIERY_WID )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS AS 'This is the foundation store hierarchy dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.merch_hiery_wid AS 'Identification of the Merchandiser. Concatenation of MERCHANDISER NUMBER with MERCHANDISER NAME.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.company_cd AS 'This is the primark company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.company_version_num AS 'This is the current version associated with style and company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.division_cd AS 'This is the division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.division_version_num AS 'This is the current version associated with style and division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.department_cd AS 'The is the department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.department_version_num AS 'This is the current version associated with style and department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.class_cd AS 'This is the class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.class_version_num AS 'This is the current version associated with style and class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.subclass_grp_cd AS 'This is the group subclass - group section'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.subclass_grp_version_num AS 'This is the current version associated with style and subclass - group'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.subclass_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.subclass_version_num AS 'This is the current version associated with style and section - group'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.company_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.division_name AS 'Name of the Primark division'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.department_name AS 'Short text reference or label for a department'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.class_name AS 'This Column is used identify the Merch Hierarchy section name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.subclass_grp_name AS 'Names the subsection group within the PRODUCT HIERARCHY. It corresponds to subclass group in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.subclass_name AS 'Names the subsection within the PRODUCT HIERARCHY. It corresponds to subclass in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.buyer_cd AS 'Identification of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1042_TRANS.buyer_name AS 'Name of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/