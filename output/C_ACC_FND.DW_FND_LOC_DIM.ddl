
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}C_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create view for DW_FND_LOC_DIM */
REPLACE VIEW DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM
    AS LOCKING ROW FOR ACCESS

SELECT
    location_id ,
    location_name ,
    location_type ,
    currency_cd ,
    address_line1 ,
    address_line2 ,
    address_line3 ,
    city_cd ,
    postal_code_cd ,
    state_province_cd ,
    country_cd ,
    phone_number ,
    location_mgr_name ,
    stock_holding_ind ,
    default_warehouse_cd ,
    time_zone ,
    vat_region_id ,
    vat_include_ind ,
    store_open_dt ,
    store_close_dt ,
    start_order_days ,
    selfridge_ind ,
    finisher_ind ,
    transfer_entity ,
    physical_warehouse_cd ,
    default_virtual_warehouse_cd ,
    retail_store_hierarchy_wid ,
    channel_id ,
    channel_name ,
    company_cd ,
    company_cd_vers_num ,
    zone_cd ,
    zone_cd_vers_num ,
    region_cd ,
    region_cd_vers_num ,
    area_cd ,
    area_cd_vers_num ,
    company_name ,
    zone_name ,
    region_name ,
    region_old ,
    org_area_name ,
    org_hier_country_name ,
    zone_manager_name ,
    region_manager_name ,
    org_area_manager_name ,
    org_hier_country_mgr_name ,
    latest_refit_date ,
    "profile" ,
    basement ,
    ground_floor ,
    first_floor ,
    second_floor ,
    third_floor ,
    fourth_floor ,
    fifth_floor ,
    total ,
    male ,
    female ,
    age_year_0_to_17 ,
    age_year_15_to_64 ,
    age_year_65_plus ,
    indigenous ,
    eu_western ,
    non_western ,
    university ,
    tourism ,
    area_name ,
    area_manager_name ,
    org_area_cd ,
    area_group_name ,
    area_group_manager_name ,
    area_group_cd ,
    org_hier_wid ,
    org_hier_country_cd ,
    linear_footage ,
    Store_Hierarchy_Mgr_Name ,
    store_format_cd ,
    store_format_description ,
    store_area_footage ,
    operating_unit ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.DW_FND_LOC_DIM
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM AS ''
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.location_id AS 'Id no for a specific Location e.g. Store or Depot'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.location_name AS 'Name of the STORE. It(s) the lowest level of the Organisational Hierarchy. It(s) the location where customers can view and purchase goods and services.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.location_type AS 'The location type is what kind of location is this S - Store , W - Warehouse , FA - Factory , AG - ??? , E - ???'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.currency_cd AS 'This is the 3 character currency code ( USD , EUR , GBR)'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.address_line1 AS 'The first line of text containing all or part of a physical site address excluding city name, state, and postal (zip) code or country.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.address_line2 AS 'The second line of text containing all or part of a physical site address excluding city name, state, and postal (zip) code or country.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.address_line3 AS 'The third line of text containing all or part of a physical site address excluding city name, state, and postal (zip) code or country.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.city_cd AS 'Uniquely identifies a city.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.postal_code_cd AS 'Series of letters and/or digits that are part of a sorting system separating geographical regions around the world and are used to facilitate the delivery of mail. Frequently used in marketing analysis and planning.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.state_province_cd AS 'This Column is used identify the A code for state providences'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.country_cd AS 'Uniquely identifies a county.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.phone_number AS 'Uniquely identifies a telephone number.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.location_mgr_name AS 'Person who manages the specific Store.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.stock_holding_ind AS 'This column indicates whether the store can hold stock. In a non-multichannel environment this will always be Y.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.default_warehouse_cd AS 'A Depot is the place of storage of products used in the supply chain process for distribution to and from STORES and SUPPLIERS. Concatenation of Depot Number and Depot Name.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.time_zone AS 'Time for the current geographical location'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.vat_region_id AS 'VAT region (vat regions are determined by the VAT authority).'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.vat_include_ind AS 'This Column is used identify the Indicator to identify the VAT value included or not'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.store_open_dt AS 'First day when store have sales. (This includes friends & family pre opening sales which are saved and added to opening day sales) min(SALES DATE) by store'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.store_close_dt AS 'This Column is used identify the last day of the store'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.start_order_days AS 'Contains the number of days before the store_open_date that the store will begin accepting orders.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.selfridge_ind AS 'This Column is used identify the Selfridge indicator'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.finisher_ind AS 'Identifier of a DEPOT or STORE in the company to which a transfer goes(destination). It could also identify an external PARTNER for reprocessing purposes.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.transfer_entity AS 'Transfer entities can be defined by brand, geography, country or other grouping defined by your company.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.physical_warehouse_cd AS 'Code representing the Physical warehouse for the Store'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.default_virtual_warehouse_cd AS 'This Column is used to identify the Default Depot code for the Location(Store)'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.retail_store_hierarchy_wid AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.channel_id AS 'Channel Associated with Store'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.channel_name AS 'Channel Name Associated with Store'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.company_cd AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.company_cd_vers_num AS 'version number associated with hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.zone_cd AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.zone_cd_vers_num AS 'version number associated with hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.region_cd AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.region_cd_vers_num AS 'version number associated with hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.area_cd AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.area_cd_vers_num AS 'version number associated with hierarchy'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.company_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.zone_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.region_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.region_old AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.org_area_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.org_hier_country_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.zone_manager_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.region_manager_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.org_area_manager_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.org_hier_country_mgr_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.latest_refit_date AS 'Date when a store was given a refit'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM."profile" AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.basement AS 'Size of the basement'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.ground_floor AS 'Size of the ground floor'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.first_floor AS 'Size of the floor'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.second_floor AS 'Size of the floor'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.third_floor AS 'Size of the floor'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.fourth_floor AS 'Size of the floor'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.fifth_floor AS 'Size of the floor'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.total AS 'Total Floor Size'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.male AS 'Male Decographic ratio [0,1]'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.female AS 'Female Decographic ratio [0,1]'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.age_year_0_to_17 AS 'Demographic ratio [0,1]'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.age_year_15_to_64 AS 'Demographic ratio [0,1]'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.age_year_65_plus AS 'Demographic ratio [0,1]'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.indigenous AS 'Demographic ratio [0,1]'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.eu_western AS 'Demographic ratio [0,1]'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.non_western AS 'Demographic ratio [0,1]'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.university AS 'University Town Y/N'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.tourism AS 'Tourist Town Y/N'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.area_name AS 'The Area Name'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.area_manager_name AS 'The managers name associated with the area'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.org_area_cd AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.area_group_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.area_group_manager_name AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.area_group_cd AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.org_hier_wid AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.org_hier_country_cd AS 'TBD'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.linear_footage AS 'This Column is used identify the Primark linear footage space planning'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.Store_Hierarchy_Mgr_Name AS 'This Column is used identify the Manager name for the store'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.store_format_cd AS 'This Column is used identify the store format code'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.store_format_description AS 'This Column is used identify the Description of store format'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.store_area_footage AS 'This Column is used identify the Area Footage of the store'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.operating_unit AS 'Operating Unit Code - Primark Identification for Organization Unit (Id in EBS)'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/