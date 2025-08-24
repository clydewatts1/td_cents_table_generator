
/*----------------------------------------------------------------------
* FileName: T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG.ddl
* Project: Primark Reclassification Foundation
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_SLS_FCT_PVT_STG = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG
    (
    business_date DATE NOT NULL FORMAT 'yyyy-mm-dd' ,
    loc_wid BIGINT NOT NULL FORMAT '99999' ,
    item_wid BIGINT NOT NULL FORMAT '999999999999' ,
    fct_src_map BYTEINT NOT NULL   
    )
    PRIMARY INDEX ( loc_wid ,item_wid ) PARTITION BY RANGE_N(Business_Date BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG.business_date AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG.loc_wid AS 'Location ID Surrogate KEY (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG.item_wid AS 'Item ID Surrogate Key (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG.fct_src_map AS 'Mapping of source of each row in Pivot - used in debuging'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/