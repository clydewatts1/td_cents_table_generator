
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1043_VALID = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID
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
    buyer_name VARCHAR(128) NOT NULL ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    UNIQUE PRIMARY INDEX(MERCH_HIERY_WID )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID AS 'This is the foundation store hierarchy dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.merch_hiery_wid AS 'Identification of the Merchandiser. Concatenation of MERCHANDISER NUMBER with MERCHANDISER NAME.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.company_cd AS 'This is the primark company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.company_version_num AS 'This is the current version associated with style and company code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.division_cd AS 'This is the division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.division_version_num AS 'This is the current version associated with style and division code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.department_cd AS 'The is the department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.department_version_num AS 'This is the current version associated with style and department code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.class_cd AS 'This is the class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.class_version_num AS 'This is the current version associated with style and class / section code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_grp_cd AS 'This is the group subclass - group section'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_grp_version_num AS 'This is the current version associated with style and subclass - group'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_version_num AS 'This is the current version associated with style and section - group'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.company_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.division_name AS 'Name of the Primark division'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.department_name AS 'Short text reference or label for a department'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.class_name AS 'This Column is used identify the Merch Hierarchy section name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_grp_name AS 'Names the subsection group within the PRODUCT HIERARCHY. It corresponds to subclass group in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1043_VALID.subclass_name AS 'Names the subsection within the PRODUCT HIERARCHY. It corresponds to subclass in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
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