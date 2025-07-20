
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1020_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1020_TRANS
    (
    org_hiery_wid INTEGER NOT NULL ,
    loc_wid INTEGER NOT NULL ,
    loc_org_hier_vers_num INTEGER       )
    UNIQUE PRIMARY INDEX(ORG_HIERY_WID)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1020_TRANS AS 'Store Hierarchy Cross Reference'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1020_TRANS.org_hiery_wid AS 'Unique identifier for Organization Hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1020_TRANS.loc_wid AS 'Unique Identifier for Location ID this is either the store or the warehouse'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1020_TRANS.loc_org_hier_vers_num AS 'This is the version number of location in the organization hierarchy - if there a new location - version is last version id for lowest level of hierarchy , if changed then bumped version no for table'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/