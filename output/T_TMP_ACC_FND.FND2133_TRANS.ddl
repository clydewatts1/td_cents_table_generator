
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND2133_TRANS = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS
    (
    business_date DATE NOT NULL FORMAT 'YYYY-MM-DD',
    loc_id INTEGER NOT NULL FORMAT '99999',
    item_id BIGINT NOT NULL FORMAT '999999999999',
    ly_business_date DATE NOT NULL FORMAT 'yyyy-mm-dd',
    ty_sales_ind BYTEINT NOT NULL ,
    ty_stock_ind BYTEINT NOT NULL ,
    ly_sales_ind BYTEINT NOT NULL ,
    ly_stock_ind BYTEINT NOT NULL      )
    PRIMARY INDEX ( Loc_ID ,Item_Id ) PARTITION BY RANGE_N(Business_Date BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS.business_date AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS.loc_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS.ly_business_date AS 'Last year business date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS.ty_sales_ind AS 'Indicates if the sales data was present for this row'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS.ty_stock_ind AS 'Indicates if the sales data was present for this year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS.ly_sales_ind AS 'Indicates if the sales data for last year primark calendar date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND2133_TRANS.ly_stock_ind AS 'Indicates if the sales data for last year primark calendar date'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/