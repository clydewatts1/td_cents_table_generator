
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_LOC_DIM = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM
    (
    location_id INTEGER NOT NULL ,
    location_name VARCHAR(128) NOT NULL ,
    location_type VARCHAR(3) NOT NULL ,
    currency_cd CHAR(3)  ,
    address_line1 VARCHAR(255)  ,
    address_line2 VARCHAR(255)  ,
    address_line3 VARCHAR(255)  ,
    city_cd VARCHAR(170)  ,
    postal_code_cd VARCHAR(20)  ,
    state_province_cd VARCHAR(30)  ,
    country_cd CHAR(2)  ,
    phone_number VARCHAR(20)  ,
    location_mgr_name VARCHAR(128)  ,
    stock_holding_ind VARCHAR(10)  ,
    default_warehouse_cd INTEGER  ,
    time_zone VARCHAR(30)  ,
    vat_region_id SMALLINT  ,
    vat_include_ind CHAR(1) NOT NULL ,
    store_open_dt DATE  FORMAT 'YYYY-MM-DD',
    store_close_dt DATE  FORMAT 'YYYY-MM-DD',
    start_order_days SMALLINT  ,
    selfridge_ind CHAR(1)  ,
    finisher_ind VARCHAR(10)  ,
    transfer_entity VARCHAR(50)  ,
    physical_warehouse_cd INTEGER  FORMAT '999',
    default_virtual_warehouse_cd INTEGER  ,
    retail_store_hierarchy_wid VARCHAR(30)  ,
    channel_id SMALLINT  FORMAT '9999',
    channel_name VARCHAR(30)  ,
    company_cd INTEGER  ,
    company_cd_vers_num SMALLINT  ,
    zone_cd INTEGER  ,
    zone_cd_vers_num SMALLINT  ,
    region_cd INTEGER  ,
    region_cd_vers_num SMALLINT  ,
    area_cd INTEGER  ,
    area_cd_vers_num SMALLINT  ,
    company_name VARCHAR(100)  ,
    zone_name VARCHAR(100)  ,
    region_name VARCHAR(100)  ,
    region_old VARCHAR(100)  ,
    org_area_name VARCHAR(100)  ,
    org_hier_country_name VARCHAR(100)  ,
    zone_manager_name VARCHAR(100)  ,
    region_manager_name VARCHAR(100)  ,
    org_area_manager_name VARCHAR(100)  ,
    org_hier_country_mgr_name VARCHAR(100)  ,
    latest_refit_date DATE  ,
    "profile" VARCHAR(250)  ,
    basement INTEGER  ,
    ground_floor INTEGER  ,
    first_floor INTEGER  ,
    second_floor INTEGER  ,
    third_floor INTEGER  ,
    fourth_floor INTEGER  ,
    fifth_floor INTEGER  ,
    total INTEGER  ,
    male DECIMAL(9,4)  ,
    female DECIMAL(9,4)  ,
    age_year_0_to_17 DECIMAL(9,4)  ,
    age_year_15_to_64 DECIMAL(9,4)  ,
    age_year_65_plus DECIMAL(9,4)  ,
    indigenous DECIMAL(9,4)  ,
    eu_western DECIMAL(9,4)  ,
    non_western DECIMAL(9,4)  ,
    university CHAR(1)  ,
    tourism CHAR(1)  ,
    area_name VARCHAR(100)  ,
    area_manager_name VARCHAR(100)  ,
    org_area_cd VARCHAR(100)  ,
    area_group_name VARCHAR(100)  ,
    area_group_manager_name VARCHAR(100)  ,
    area_group_cd INTEGER  ,
    org_hier_wid INTEGER  ,
    org_hier_country_cd VARCHAR(30)  ,
    linear_footage INTEGER  ,
    Store_Hierarchy_Mgr_Name VARCHAR(255)  ,
    store_format_cd VARCHAR(30)  ,
    store_format_description VARCHAR(128)  ,
    store_area_footage SMALLINT  ,
    operating_unit VARCHAR(255)  ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    UNIQUE PRIMARY INDEX(location_id)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM AS 'This is the foundation Location Table'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.location_id AS 'Id no for a specific Location e.g. Store or Depot'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.location_name AS 'Name of the STORE. It(s) the lowest level of the Organisational Hierarchy. It(s) the location where customers can view and purchase goods and services.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.location_type AS 'The location type is what kind of location is this S - Store , W - Warehouse , FA - Factory , AG - ??? , E - ???'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.currency_cd AS 'This is the 3 character currency code ( USD , EUR , GBR)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.address_line1 AS 'The first line of text containing all or part of a physical site address excluding city name, state, and postal (zip) code or country.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.address_line2 AS 'The second line of text containing all or part of a physical site address excluding city name, state, and postal (zip) code or country.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.address_line3 AS 'The third line of text containing all or part of a physical site address excluding city name, state, and postal (zip) code or country.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.city_cd AS 'Uniquely identifies a city.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.postal_code_cd AS 'Series of letters and/or digits that are part of a sorting system separating geographical regions around the world and are used to facilitate the delivery of mail. Frequently used in marketing analysis and planning.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.state_province_cd AS 'This Column is used identify the A code for state providences'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.country_cd AS 'Uniquely identifies a county.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.phone_number AS 'Uniquely identifies a telephone number.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.location_mgr_name AS 'Person who manages the specific Store.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.stock_holding_ind AS 'This column indicates whether the store can hold stock. In a non-multichannel environment this will always be Y.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.default_warehouse_cd AS 'A Depot is the place of storage of products used in the supply chain process for distribution to and from STORES and SUPPLIERS. Concatenation of Depot Number and Depot Name.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.time_zone AS 'Time for the current geographical location'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.vat_region_id AS 'VAT region (vat regions are determined by the VAT authority).'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.vat_include_ind AS 'This Column is used identify the Indicator to identify the VAT value included or not'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.store_open_dt AS 'First day when store have sales. (This includes friends & family pre opening sales which are saved and added to opening day sales) min(SALES DATE) by store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.store_close_dt AS 'This Column is used identify the last day of the store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.start_order_days AS 'Contains the number of days before the store_open_date that the store will begin accepting orders.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.selfridge_ind AS 'This Column is used identify the Selfridge indicator'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.finisher_ind AS 'Identifier of a DEPOT or STORE in the company to which a transfer goes(destination). It could also identify an external PARTNER for reprocessing purposes.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.transfer_entity AS 'Transfer entities can be defined by brand, geography, country or other grouping defined by your company.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.physical_warehouse_cd AS 'Code representing the Physical warehouse for the Store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.default_virtual_warehouse_cd AS 'This Column is used to identify the Default Depot code for the Location(Store)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.retail_store_hierarchy_wid AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.channel_id AS 'Channel Associated with Store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.channel_name AS 'Channel Name Associated with Store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.company_cd AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.company_cd_vers_num AS 'version number associated with hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.zone_cd AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.zone_cd_vers_num AS 'version number associated with hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.region_cd AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.region_cd_vers_num AS 'version number associated with hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.area_cd AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.area_cd_vers_num AS 'version number associated with hierarchy'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.company_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.zone_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.region_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.region_old AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.org_area_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.org_hier_country_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.zone_manager_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.region_manager_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.org_area_manager_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.org_hier_country_mgr_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.latest_refit_date AS 'Date when a store was given a refit'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM."profile" AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.basement AS 'Size of the basement'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.ground_floor AS 'Size of the ground floor'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.first_floor AS 'Size of the floor'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.second_floor AS 'Size of the floor'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.third_floor AS 'Size of the floor'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.fourth_floor AS 'Size of the floor'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.fifth_floor AS 'Size of the floor'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.total AS 'Total Floor Size'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.male AS 'Male Decographic ratio [0,1]'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.female AS 'Female Decographic ratio [0,1]'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.age_year_0_to_17 AS 'Demographic ratio [0,1]'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.age_year_15_to_64 AS 'Demographic ratio [0,1]'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.age_year_65_plus AS 'Demographic ratio [0,1]'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.indigenous AS 'Demographic ratio [0,1]'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.eu_western AS 'Demographic ratio [0,1]'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.non_western AS 'Demographic ratio [0,1]'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.university AS 'University Town Y/N'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.tourism AS 'Tourist Town Y/N'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.area_name AS 'The Area Name'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.area_manager_name AS 'The managers name associated with the area'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.org_area_cd AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.area_group_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.area_group_manager_name AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.area_group_cd AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.org_hier_wid AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.org_hier_country_cd AS 'TBD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.linear_footage AS 'This Column is used identify the Primark linear footage space planning'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.Store_Hierarchy_Mgr_Name AS 'This Column is used identify the Manager name for the store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.store_format_cd AS 'This Column is used identify the store format code'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.store_format_description AS 'This Column is used identify the Description of store format'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.store_area_footage AS 'This Column is used identify the Area Footage of the store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.operating_unit AS 'Operating Unit Code - Primark Identification for Organization Unit (Id in EBS)'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/