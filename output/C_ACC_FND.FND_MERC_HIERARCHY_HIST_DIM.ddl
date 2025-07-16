
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}C_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create view for FND_MERC_HIERARCHY_HIST_DIM */
REPLACE VIEW DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM
    AS LOCKING ROW FOR ACCESS

SELECT
    merch_hiery_wid ,
    company_cd ,
    company_version_num ,
    division_cd ,
    division_version_num ,
    department_cd ,
    department_version_num ,
    class_cd ,
    class_version_num ,
    subclass_grp_cd ,
    subclass_grp_version_num ,
    subclass_cd ,
    subclass_version_num ,
    company_name ,
    division_name ,
    department_name ,
    class_name ,
    subclass_grp_name ,
    subclass_name ,
    buyer_cd ,
    buyer_name ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.FND_MERC_HIERARCHY_DIM
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM AS ''
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.merch_hiery_wid AS 'Identification of the Merchandiser. Concatenation of MERCHANDISER NUMBER with MERCHANDISER NAME.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.company_cd AS 'This is the primark company code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.company_version_num AS 'This is the current version associated with style and company code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.division_cd AS 'This is the division code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.division_version_num AS 'This is the current version associated with style and division code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.department_cd AS 'The is the department code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.department_version_num AS 'This is the current version associated with style and department code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.class_cd AS 'This is the class / section code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.class_version_num AS 'This is the current version associated with style and class / section code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.subclass_grp_cd AS 'This is the group subclass - group section'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.subclass_grp_version_num AS 'This is the current version associated with style and subclass - group'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.subclass_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.subclass_version_num AS 'This is the current version associated with style and section - group'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.company_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.division_name AS 'Name of the Primark division'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.department_name AS 'Short text reference or label for a department'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.class_name AS 'This Column is used identify the Merch Hierarchy section name'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.subclass_grp_name AS 'Names the subsection group within the PRODUCT HIERARCHY. It corresponds to subclass group in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.subclass_name AS 'Names the subsection within the PRODUCT HIERARCHY. It corresponds to subclass in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.buyer_cd AS 'Identification of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.buyer_name AS 'Name of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}C_ACC_FND.FND_MERC_HIERARCHY_HIST_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/