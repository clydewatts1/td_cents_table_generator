
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1047_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS
    (
    org_hiery_wid INTEGER NOT NULL ,
    org_hiery_vers_num SMALLINT NOT NULL ,
    org_hier_country_cd SMALLINT NOT NULL ,
    company_cd SMALLINT NOT NULL ,
    company_vers_num SMALLINT NOT NULL ,
    zone_cd SMALLINT NOT NULL ,
    zone_vers_num SMALLINT NOT NULL ,
    region_cd SMALLINT NOT NULL ,
    region_vers_num SMALLINT NOT NULL ,
    area_cd SMALLINT NOT NULL ,
    area_vers_num SMALLINT NOT NULL      )
    UNIQUE PRIMARY INDEX(ORG_HIERY_WID)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS AS 'Store Hierarchy Versioning'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.org_hiery_vers_num AS 'This is the version of the locs within hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.org_hier_country_cd AS 'Contains the number of the country.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.company_cd AS 'This Column is used to identify the Primark Company Code'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.company_vers_num AS 'The is the version of locs within company'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.zone_cd AS 'Uniquely identifies a time zone.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.zone_vers_num AS 'The is the version of locs within zone'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.region_cd AS 'This Column is used identify the Uniquely identifies a region.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.region_vers_num AS 'The is the version of locs within region'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1047_TRANS.area_cd AS 'Code for Primark Area(Location)'
;




/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/