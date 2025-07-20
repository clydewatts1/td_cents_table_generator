
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1040_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1040_TRANS
    (
    styl_wid BIGINT NOT NULL ,
    item_sbclass_wid INTEGER NOT NULL ,
    styl_sbclass_vers_num INTEGER NOT NULL      )
    PRIMARY INDEX(styl_wid)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_TRANS AS 'This table tracks the changes to the product / merchant hierarchy over time'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_TRANS.styl_wid AS 'This is the style surrogate key'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_TRANS.item_sbclass_wid AS 'This contains the item subclass wid - this is the lowest grain for the merchant hierarchy'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1040_TRANS.styl_sbclass_vers_num AS 'This is the version number of subclass - if there a new style - version is last version id for sbclass , if changed then bumped version no for table'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/