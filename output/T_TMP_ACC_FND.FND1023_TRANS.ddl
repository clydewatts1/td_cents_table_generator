
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1023_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS
    (
    org_hiery_wid INTEGER NOT NULL ,
    org_hier_country_cd SMALLINT NOT NULL ,
    org_hier_country_name VARCHAR(128) NOT NULL ,
    org_hiery_vers_num SMALLINT NOT NULL ,
    company_cd SMALLINT NOT NULL ,
    company_name VARCHAR(128) NOT NULL ,
    company_vers_num SMALLINT NOT NULL ,
    zone_cd SMALLINT NOT NULL ,
    zone_name VARCHAR(128) NOT NULL ,
    zone_vers_num SMALLINT NOT NULL ,
    region_cd SMALLINT NOT NULL ,
    region_name VARCHAR(128) NOT NULL ,
    region_old VARCHAR(128) NOT NULL ,
    region_vers_num SMALLINT NOT NULL ,
    area_cd SMALLINT NOT NULL ,
    area_name VARCHAR(128) NOT NULL ,
    area_vers_num SMALLINT NOT NULL ,
    zone_manager_name VARCHAR(128) NOT NULL ,
    region_manager_name VARCHAR(128) NOT NULL ,
    area_manager_name VARCHAR(128) NOT NULL ,
    org_hier_country_mgr_name VARCHAR(128) NOT NULL      )
    UNIQUE PRIMARY INDEX(ORG_HIERY_WID)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS AS 'Store Hierarchy dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.org_hier_country_cd AS 'Contains the number of the country.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.org_hier_country_name AS 'Name of the Country of locations in the organizational hierarchy. It corresponded to District in Oracle Retail Organizational hierarchy. A Country consists of one or more locations.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.org_hiery_vers_num AS 'This is the version of the locs within hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.company_cd AS 'This Column is used to identify the Primark Company Code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.company_name AS 'This Column is used to identify the Primark Company Name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.company_vers_num AS 'The is the version of locs within company'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.zone_cd AS 'Uniquely identifies a time zone.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.zone_name AS 'Name of Primark Zones in the organization hierarchy. It corresponds to Chain in ORMS hierarchy. A Zone consists of one or more Primark regions. A Zone consists of one or more Primark regions grouped for financial planning purposes.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.zone_vers_num AS 'The is the version of locs within zone'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.region_cd AS 'This Column is used identify the Uniquely identifies a region.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.region_name AS 'Short text reference or label for the region.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.region_old AS 'An intermediate organization grouping level within the geographic hierarchy, which groups LOCATIONs. A specific regional geographic area of the country or county.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.region_vers_num AS 'The is the version of locs within region'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.area_cd AS 'Code for Primark Area(Location)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.area_name AS 'Identification of Primark Area in the Organisation hierarchy. It corresponds to REGION in Oracle Retail Organizational Hierarchy. A Primark area represents a group of countries. Concatenation of Area Number with Area Name'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.area_vers_num AS 'The is the version of locs within area'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.zone_manager_name AS 'This Column is used identify the Manager name for Primark Zone'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.region_manager_name AS 'An individual who is employed by the enterprise. The manager of the region.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.area_manager_name AS 'Person who manages the specific area in the region.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1023_TRANS.org_hier_country_mgr_name AS 'Person who manages the specific area in the region.'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/