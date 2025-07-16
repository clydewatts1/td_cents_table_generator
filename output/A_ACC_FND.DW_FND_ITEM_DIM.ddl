
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}A_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_ITEM_DIM */
REPLACE VIEW DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM
    AS LOCKING ROW FOR ACCESS

SELECT
    item_id ,
    style_id ,
    product_id ,
    item_name ,
    item_desc ,
    item_kimball_num ,
    company_cd ,
    company_version_num ,
    division_cd ,
    division_version_num ,
    department_cd ,
    department_version_num ,
    section_cd ,
    section_version_num ,
    subsection_grp_cd ,
    subsection_grp_version_num ,
    subsection_cd ,
    subsection_version_num ,
    division_name ,
    department_name ,
    section_name ,
    subsection_grp_name ,
    subsection_name ,
    buyer_cd ,
    buyer_name ,
    super_sku_num ,
    style_desc ,
    colour_cd ,
    size_cd ,
    pack_ind ,
    sellable_item_ind ,
    inventory_item_ind ,
    item_barcode_id ,
    barcode_type ,
    barcode_desc ,
    dtr_cd ,
    licensor_cd ,
    licensor_desc ,
    property_cd ,
    property_desc ,
    character_cd ,
    character_desc ,
    item_created_dt ,
    product_type ,
    hazardous ,
    keylines ,
    story ,
    sustainability ,
    washes ,
    carryover ,
    changemadeby ,
    size_group_code ,
    size_group_description ,
    size_display_sequence ,
    season_lookup ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.DW_FND_ITEM_DIM
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM AS ''
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.item_id AS 'ITEM_ID or SKU ORIN'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.style_id AS 'Concatenation of the Name and Id of the Style ORIN . A Style defines one or many items(SKU) determined by a single design.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.product_id AS 'The product id , is style id and color ( style id * 1000 + color )'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.item_name AS 'Short text reference or label for an item'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.item_desc AS 'Narrative text describing the item or SKU Description'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.item_kimball_num AS 'Identifies the item with 7 digits Primark Number known as Kimball 7. (Equivalent to SKU Orin)'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.company_cd AS 'This is the primark company code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.company_version_num AS 'This is the current version associated with style and company code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.division_cd AS 'This is the division code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.division_version_num AS 'This is the current version associated with style and division code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.department_cd AS 'The is the department code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.department_version_num AS 'This is the current version associated with style and department code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.section_cd AS 'This is the class / section code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.section_version_num AS 'This is the current version associated with style and class / section code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.subsection_grp_cd AS 'This is the group subclass - group section'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.subsection_grp_version_num AS 'This is the current version associated with style and subclass - group'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.subsection_cd AS 'This is the sub-classa / subsection code'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.subsection_version_num AS 'This is the current version associated with style and section - group'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.division_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.department_name AS 'Name of the Primark division'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.section_name AS 'Short text reference or label for a department'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.subsection_grp_name AS 'This Column is used identify the Merch Hierarchy section name'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.subsection_name AS 'Names the subsection group within the PRODUCT HIERARCHY. It corresponds to subclass group in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.buyer_cd AS 'Names the subsection within the PRODUCT HIERARCHY. It corresponds to subclass in ORMS PRODUCT HIERARCHY. it represent a group of products with common or similar detailed elements or intended for a common or similar specific case.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.buyer_name AS 'Identification of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.super_sku_num AS 'Name of the Buyer: the person authorised to approve the PO(s) within the system. The BUYER is the person accountable for one or more CLASS of STYLEs and for the delivery of the STYLEs with the MERCHANDISER.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.style_desc AS 'Name of the Style . A Style defines one or many items(SKU) determined by a single design. This can be a short description of the style. (There can be more than 1 style with the same description)'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.colour_cd AS 'Contains the Name and Id of the colour - characteristics of an item (belongs to item differentiators) An attribute used as part of the definition of an STYLE. This is typically the colour of the Item but is not always an item colour.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.size_cd AS 'Uniquely identifies a size within a size type'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.pack_ind AS 'Identification of the pack . A pack in Primark will represent a carton or set with SKUs in it. One pack at Primark will have only SKUs of the same Style. Concatenation of Pack ORIN Number and Pack Name'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.sellable_item_ind AS 'Unit quantity of goods indicator'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.inventory_item_ind AS 'Indicates if the item is physically inventoried. Some items that are not inventoried would be electronic download items, menu items (food industry), and service items.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.item_barcode_id AS 'An identifying code often remotely scannable that is placed on an item or product. It is typically a bar or Scan code or similar graphic object that is scanned optically, but could also be an electronic transponder like RFID technology device'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.barcode_type AS 'Holds the type of barcode for which the coupon is related to. This will be used to control the type of entry into the coupon barcode field.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.barcode_desc AS 'Description for an identifying code often remotely scannable that is placed on an item or product. It is typically a bar or Scan code or similar graphic object that is scanned optically, but could electronic transponder like RFID technology device.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.dtr_cd AS 'DTR (Direct to Retail). Items in these conditions can only be produced in specific factories. These items are eligible for royalties that Primark has to pay directly to the Licensor.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.licensor_cd AS 'ID for the licence owner for the design of the copyright of a product Concatenation of Licensor code and Licensor Description'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.licensor_desc AS 'The licence owner for the design of the copyright of a product'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.property_cd AS 'Id for the Copyright of the company. Defined for DTR items.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.property_desc AS 'Description of asset held by the organization. Real property.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.character_cd AS 'The code of the character associated with the product. Defined for DTR items & all other licenced product.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.character_desc AS 'The name of the character associated with the product. Defined for DTR items & all other licenced product'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.item_created_dt AS 'This is the date in which an item classification relationship begins'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.product_type AS 'Type of product has been categorized'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.hazardous AS 'specialized equipment like Hazardous materials'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.keylines AS 'UDA Flag (User Defined Attribute)that indicates if item is a Keyline.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.story AS 'Name of the look/ story that the product is assigned to'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.sustainability AS 'Warranty of the product (ex: Sustainable Cotton, Oeko-tex).'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.washes AS 'Classifies the treatment of some FABRICs most often used with denim'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.carryover AS 'Attribute flag (UDA - USER DEFINED ATTRIBUTE) that identifies if an item should continue to sell or be ordered in the next season. Flag is defined at sku ORIN level'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.changemadeby AS 'This is a foreign key to the W_USER_D dimension indicating the user who last modified the record in the source system.'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.size_group_code AS 'unique identifier of size group'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.size_group_description AS 'contains the description of size group of the item'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.size_display_sequence AS 'This Column is used identify the Size display Sequence number'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.season_lookup AS 'This is a bitmap lookup of each of the seasons based on the SSON_WID'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_ITEM_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/