
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_ITEM_HIST_DIM = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM
    (
    item_id BIGINT NOT NULL ,
    style_id BIGINT NOT NULL ,
    product_id BIGINT NOT NULL ,
    item_name VARCHAR(128) NOT NULL ,
    item_desc VARCHAR(128) NOT NULL ,
    item_kimball_num INTEGER NOT NULL FORMAT '9999999',
    company_cd SMALLINT NOT NULL FORMAT '99',
    company_version_num SMALLINT NOT NULL ,
    division_cd SMALLINT NOT NULL FORMAT '99',
    division_version_num SMALLINT NOT NULL ,
    department_cd SMALLINT NOT NULL FORMAT '99',
    department_version_num SMALLINT NOT NULL ,
    section_cd SMALLINT NOT NULL FORMAT '999',
    section_version_num SMALLINT NOT NULL ,
    subsection_grp_cd SMALLINT NOT NULL FORMAT '999',
    subsection_grp_version_num SMALLINT  ,
    subsection_cd SMALLINT NOT NULL FORMAT '999',
    subsection_version_num VARCHAR(255) NOT NULL ,
    division_name VARCHAR(255) NOT NULL ,
    department_name VARCHAR(255) NOT NULL ,
    section_name VARCHAR(255) NOT NULL ,
    subsection_grp_name VARCHAR(255) NOT NULL ,
    subsection_name VARCHAR(255) NOT NULL ,
    buyer_cd VARCHAR(30)  ,
    buyer_name VARCHAR(255)  ,
    super_sku_num BIGINT  ,
    style_desc VARCHAR(128)  ,
    colour_cd SMALLINT NOT NULL ,
    size_cd SMALLINT NOT NULL ,
    pack_ind CHAR(1) NOT NULL ,
    sellable_item_ind CHAR(1)  ,
    inventory_item_ind CHAR(1)  ,
    item_barcode_id CHAR(1)  ,
    barcode_type VARCHAR(10)  ,
    barcode_desc VARCHAR(30)  ,
    dtr_cd VARCHAR(10)  ,
    licensor_cd VARCHAR(30)  ,
    licensor_desc VARCHAR(64)  ,
    property_cd VARCHAR(10)  ,
    property_desc VARCHAR(64)  ,
    character_cd VARCHAR(10)  ,
    character_desc VARCHAR(64)  ,
    item_created_dt DATE  ,
    product_type VARCHAR(64)  ,
    hazardous VARCHAR(3)  ,
    keylines VARCHAR(3)  ,
    story VARCHAR(4)  ,
    sustainability VARCHAR(64)  ,
    washes VARCHAR(32)  ,
    carryover CHAR(1)  ,
    changemadeby VARCHAR(30)  ,
    size_group_code VARCHAR(10)  ,
    size_group_description VARCHAR(64)  ,
    size_display_sequence SMALLINT  ,
    season_lookup BYTE(14)  ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    UNIQUE PRIMARY INDEX(ITEM_ID)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM AS 'This is the item dimension , contains all styles , sku and merchant hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.item_id AS 'ITEM_ID or SKU ORIN'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.style_id AS 'Concatenation of the Name and Id of the Style ORIN . A Style defines one or many items(SKU) determined by a single design.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.product_id AS 'The product id , is style id and color ( style id * 1000 + color )'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.item_name AS 'Short text reference or label for an item'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.item_desc AS 'Narrative text describing the item or SKU Description'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.item_kimball_num AS 'Identifies the item with 7 digits Primark Number known as Kimball 7. (Equivalent to SKU Orin)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.company_cd AS 'This is the primark company code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.company_version_num AS 'This is the current version associated with style and company code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.division_cd AS 'This is the division code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.division_version_num AS 'This is the current version associated with style and division code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.department_cd AS 'The is the department code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.department_version_num AS 'This is the current version associated with style and department code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.section_cd AS 'This is the class / section code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.section_version_num AS 'This is the current version associated with style and class / section code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.subsection_grp_cd AS 'This is the group subclass - group section'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.subsection_grp_version_num AS 'This is the current version associated with style and subclass - group'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.subsection_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.subsection_version_num AS 'This is the current version associated with style and section - group'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.division_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.department_name AS 'Name of the Primark division'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.section_name AS 'Short text reference or label for a department'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.subsection_grp_name AS 'This Column is used identify the Merch Hierarchy section name'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.subsection_name AS 'Names the subsection group within the PRODUCT HIERARCHY. It corresponds to subclass group in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.buyer_cd AS 'Names the subsection within the PRODUCT HIERARCHY. It corresponds to subclass in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.buyer_name AS 'Identification of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.super_sku_num AS 'Name of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.style_desc AS 'Name of the Style . A Style defines one or many items(SKU) determined by a single design. This can be a short description of the style. (There can be more than 1 style with the same description)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.colour_cd AS 'Contains the Name and Id of the colour - characteristics of an item (belongs to item differentiators) An attribute used as part of the definition of an STYLE. This is typically the colour of the Item but is not always an item colour.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.size_cd AS 'Uniquely identifies a size within a size type'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.pack_ind AS 'Identification of the pack . A pack in Primark will represent a carton or set with SKUs in it. One pack at Primark will have only SKUs of the same Style. Concatenation of Pack ORIN Number and Pack Name'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.sellable_item_ind AS 'Unit quantity of goods indicator'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.inventory_item_ind AS 'Indicates if the item is physically inventoried. Some items that are not inventoried would be electronic download items, menu items (food industry), and service items.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.item_barcode_id AS 'An identifying code often remotely scannable that is placed on an item or product. It is typically a bar or Scan code or similar graphic object that is scanned optically, but could also be an electronic transponder like RFID technology device'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.barcode_type AS 'Holds the type of barcode for which the coupon is related to. This will be used to control the type of entry into the coupon barcode field.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.barcode_desc AS 'Description for an identifying code often remotely scannable that is placed on an item or product. It is typically a bar or Scan code or similar graphic object that is scanned optically, but could electronic transponder like RFID technology device.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.dtr_cd AS 'DTR (Direct to Retail). Items in these conditions can only be produced in specific factories. These items are eligible for royalties that Primark has to pay directly to the Licensor.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.licensor_cd AS 'ID for the licence owner for the design of the copyright of a product Concatenation of Licensor code and Licensor Description'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.licensor_desc AS 'The licence owner for the design of the copyright of a product'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.property_cd AS 'Id for the Copyright of the company. Defined for DTR items.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.property_desc AS 'Description of asset held by the organization. Real property.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.character_cd AS 'The code of the character associated with the product. Defined for DTR items & all other licenced product.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.character_desc AS 'The name of the character associated with the product. Defined for DTR items & all other licenced product'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.item_created_dt AS 'This is the date in which an item classification relationship begins'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.product_type AS 'Type of product has been categorized'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.hazardous AS 'specialized equipment like Hazardous materials'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.keylines AS 'UDA Flag (User Defined Attribute)that indicates if item is a Keyline.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.story AS 'Name of the look/ story that the product is assigned to'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.sustainability AS 'Warranty of the product (ex: Sustainable Cotton, Oeko-tex).'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.washes AS 'Classifies the treatment of some FABRICs most often used with denim'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.carryover AS 'Attribute flag (UDA - USER DEFINED ATTRIBUTE) that identifies if an item should continue to sell or be ordered in the next season. Flag is defined at sku ORIN level'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.changemadeby AS 'This is a foreign key to the W_USER_D dimension indicating the user who last modified the record in the source system.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.size_group_code AS 'unique identifier of size group'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.size_group_description AS 'contains the description of size group of the item'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.size_display_sequence AS 'This Column is used identify the Size display Sequence number'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.season_lookup AS 'This is a bitmap lookup of each of the seasons based on the SSON_WID'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_HIST_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/