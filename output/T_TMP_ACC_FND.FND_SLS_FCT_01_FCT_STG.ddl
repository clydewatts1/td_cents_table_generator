
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND_SLS_FCT_01_FCT_STG = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG
    (
    business_date DATE NOT NULL FORMAT 'yyyy-mm-dd',
    loc_wid INTEGER NOT NULL FORMAT '99999',
    item_wid BIGINT NOT NULL ,
    fct_src_map BYTEINT NOT NULL ,
    sales_1st_date DATE  ,
    clearance_1st_date DATE  ,
    sales_value DECIMAL(18,10)  ,
    sales_units INTEGER  ,
    sales_transaction_count INTEGER  ,
    return_value DECIMAL(18,10)  ,
    return_units INTEGER  ,
    return_transaction_count INTEGER  ,
    exchange_value DECIMAL(18,10)  ,
    exchange_units INTEGER  ,
    exchange_transaction_count INTEGER  ,
    emp_discount_exchange_value DECIMAL(18,10)  ,
    emp_discount_exchange_units INTEGER  ,
    emp_discount_exchange_transaction_count INTEGER  ,
    emp_discount_sales_value DECIMAL(18,10)  ,
    emp_discount_sales_units INTEGER  ,
    emp_discount_sales_transaction_count INTEGER  ,
    emp_discount_return_value DECIMAL(18,10)  ,
    emp_discount_return_units INTEGER  ,
    emp_discount_return_transaction_count INTEGER  ,
    sales_tax_amt DECIMAL(18,10)  ,
    return_tax_amt DECIMAL(18,10)  ,
    void_transaction_count INTEGER  ,
    post_void_transaction_count INTEGER  ,
    other_transaction_count INTEGER  ,
    sales_manual_markup_amt DECIMAL(18,10)  ,
    sales_manual_markdown_amt DECIMAL(18,10)  ,
    return_manual_markdown_amt DECIMAL(18,10)  ,
    sales_manual_count INTEGER  ,
    sales_scan_count INTEGER  ,
    exchanges_with_reciepts DECIMAL(18,10)  ,
    exchanges_without_reciepts DECIMAL(18,10)  ,
    returns_with_reciepts DECIMAL(18,10)  ,
    returns_without_reciepts DECIMAL(18,10)  ,
    no_sale_transaction_count INTEGER  ,
    markdown_sales DECIMAL(18,10)  ,
    cash_sales_value DECIMAL(18,10)  ,
    cash_sales_units INTEGER  ,
    cash_sales_transaction_count INTEGER  ,
    card_sales_value DECIMAL(18,10)  ,
    card_sales_units INTEGER  ,
    card_sales_transaction_count INTEGER  ,
    gift_sales_value DECIMAL(18,10)  ,
    gift_sales_units INTEGER  ,
    gift_sales_transaction_count INTEGER  ,
    others_sales_value DECIMAL(18,10)  ,
    others_sales_units INTEGER  ,
    others_sales_transaction_count INTEGER  ,
    cash_return_value DECIMAL(18,10)  ,
    cash_return_units INTEGER  ,
    cash_return_transaction_count INTEGER  ,
    card_return_value DECIMAL(18,10)  ,
    card_return_units INTEGER  ,
    card_return_transaction_count INTEGER  ,
    gift_return_value DECIMAL(18,10)  ,
    gift_return_units INTEGER  ,
    gift_return_transaction_count INTEGER  ,
    others_return_value DECIMAL(18,10)  ,
    others_return_units INTEGER  ,
    others_return_transaction_count INTEGER  ,
    cash_exchange_value DECIMAL(18,10)  ,
    cash_exchange_units INTEGER  ,
    cash_exchange_transaction_count INTEGER  ,
    card_exchange_value DECIMAL(18,10)  ,
    card_exchange_units INTEGER  ,
    card_exchange_transaction_count INTEGER  ,
    gift_exchange_value DECIMAL(18,10)  ,
    gift_exchange_units INTEGER  ,
    gift_exchange_transaction_count INTEGER  ,
    others_exchange_value DECIMAL(18,10)  ,
    others_exchange_units INTEGER  ,
    others_exchange_transaction_count INTEGER  ,
    promotion_sales_value DECIMAL(18,10)  ,
    promotion_sales_units INTEGER  ,
    promotion_sales_transaction_count INTEGER  ,
    clearance_sales_value DECIMAL(18,10)  ,
    clearance_sales_units INTEGER  ,
    clearance_sales_transaction_count INTEGER  ,
    regular_sales_value DECIMAL(18,10)  ,
    regular_sales_units INTEGER  ,
    regular_sales_transaction_count INTEGER  ,
    promotion_return_value DECIMAL(18,10)  ,
    promotion_return_units INTEGER  ,
    promotion_return_transaction_count INTEGER  ,
    clearance_return_value DECIMAL(18,10)  ,
    clearance_return_units INTEGER  ,
    clearance_return_transaction_count INTEGER  ,
    regular_return_value DECIMAL(18,10)  ,
    regular_return_units INTEGER  ,
    regular_return_transaction_count INTEGER  ,
    promotion_exchange_value DECIMAL(18,10)  ,
    promotion_exchange_units INTEGER  ,
    promotion_exchange_transaction_count INTEGER  ,
    clearance_exchange_value DECIMAL(18,10)  ,
    clearance_exchange_units INTEGER  ,
    clearance_exchange_transaction_count INTEGER  ,
    regular_exchange_value DECIMAL(18,10)  ,
    regular_exchange_units INTEGER  ,
    regular_exchange_transaction_count INTEGER       )
    PRIMARY INDEX ( loc_wid ,item_wid ) PARTITION BY RANGE_N(Business_Date BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.business_date AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.loc_wid AS 'Location ID Surrogate KEY (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.item_wid AS 'Item ID Surrogate Key (PK)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.fct_src_map AS 'Bit map of Sub fact source'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_1st_date AS 'First day when store start selling an item.Date of SALES 1ST DATE'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_1st_date AS 'First day when store went on clearance'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_value AS 'Sales value*10000 (4 implied decimal places.), value of units sold in this prom type.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_units AS 'Number of net units of merchandise sold for a subclass/location for the day.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_transaction_count AS 'This Column is used identify the Sales Transaction Count'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.return_value AS 'Total Retail Value of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.return_units AS 'Total Retail Units of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.return_transaction_count AS 'Total Transaction count of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.exchange_value AS 'Total Retail Value of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.exchange_units AS 'Total Retail Units of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.exchange_transaction_count AS 'Total Transaction count of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_exchange_value AS 'Sales value of items Exchange which where sold in the Employee Discount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_exchange_units AS 'Units of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_exchange_transaction_count AS 'Count of sales Transactions Exchange which where sold inthe Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_sales_value AS 'Sales value of transactions on Employee discount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_sales_units AS 'Sales Units of transactions on Employee discount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_sales_transaction_count AS 'Sales transaction count on Employee discount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_return_value AS 'Sales value of items returned which where sold in the Employee Discount'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_return_units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.emp_discount_return_transaction_count AS 'Count of sales Transactions returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_tax_amt AS 'This Column is used identify the Tax amount for the sales Value'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.return_tax_amt AS 'Tax amount for the return Sales value'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.void_transaction_count AS 'Transaction count where Type = VOID'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.post_void_transaction_count AS 'Transaction count where Type = VOID'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.other_transaction_count AS 'Transaction count other than VOID and POST VOID'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_manual_markup_amt AS 'Manual Mark-up done at store level'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_manual_markdown_amt AS 'Manual Mark-down done at store level'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.return_manual_markdown_amt AS 'Value of returns which were sold on manual mark down at store'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_manual_count AS 'Count of sales transaction where the barcode was manually entered(when the POS Scan did not work)'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.sales_scan_count AS 'This Column is used identify the Count of scans in POS'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.exchanges_with_reciepts AS 'number of exchange transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.exchanges_without_reciepts AS 'number of exchange transactions where a receipt was not present'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.returns_with_reciepts AS 'number of return transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.returns_without_reciepts AS 'number of return transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.no_sale_transaction_count AS 'Count of transactions where there is no sale'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.markdown_sales AS 'Value of sales against stock that has been marked down used to track changes to selling price that will impact gross to net margin performance and used to inform next season buy plan'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_sales_value AS 'Sales value of cash transaction'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_sales_units AS 'Sales Units of cash transactions'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_sales_transaction_count AS 'Sales transaction count where TENDOR TYPE is Cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_sales_value AS 'Sales value of card transactions'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_sales_units AS 'Sales units of card transactions'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_sales_transaction_count AS 'Sales transaction count where TENDOR TYPE is Cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_sales_value AS 'Sales value including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_sales_units AS 'Sales Units including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_sales_transaction_count AS 'Sales Transaction count including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_sales_value AS 'Sales Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_sales_units AS 'Sales Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_sales_transaction_count AS 'Sales Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_return_value AS 'Sales value of items returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_return_units AS 'Units of items returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_return_transaction_count AS 'Count of sales Transactions returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_return_value AS 'Sales value of items returned which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_return_units AS 'Units of items returned which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_return_transaction_count AS 'Count of sales Transactions returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_return_value AS 'Sales value of items returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_return_units AS 'Units of items returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_return_transaction_count AS 'Count of sales Transactions returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_return_value AS 'Return Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_return_units AS 'Return Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_return_transaction_count AS 'Return Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_exchange_value AS 'Sales value of items Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_exchange_units AS 'Units of items Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.cash_exchange_transaction_count AS 'Count of sales Transactions Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_exchange_value AS 'Sales value of items Exchange which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_exchange_units AS 'Units of items Exchange which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.card_exchange_transaction_count AS 'Count of sales Transactions Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_exchange_value AS 'Sales value of items Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_exchange_units AS 'Units of items Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.gift_exchange_transaction_count AS 'Count of sales Transactions Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_exchange_value AS 'Exchange Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_exchange_units AS 'Exchange Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.others_exchange_transaction_count AS 'Exchange Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_sales_value AS 'Sales value of items on promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_sales_units AS 'This Column is used identify the Units sold in promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_sales_transaction_count AS 'count of sales Transactions where an item is in promotion price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_sales_value AS 'Sales Clearance Value including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_sales_units AS 'Sales Clearance Units including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_sales_transaction_count AS 'Sales Clearance Transaction count including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_sales_value AS 'SALES VALUE where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance. This amount is inclusive of VAT and net of returns.This shouldnot include Gift Cards'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_sales_units AS 'SALES UNITS where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance.'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_sales_transaction_count AS 'Count of sales Transactions returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_return_value AS 'Sales value of items returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_return_units AS 'Units of items returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_return_transaction_count AS 'Count of sales Transactions returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_return_value AS 'Sales value of items returned which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_return_units AS 'Units of items returned which where sold in the Clearance'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_return_transaction_count AS 'Count of sales Transactions returned which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_return_value AS 'Sales value of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_return_units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_return_transaction_count AS 'count of returned transaction which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_exchange_value AS 'Sales value of items Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_exchange_units AS 'Units of items Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.promotion_exchange_transaction_count AS 'Transactions Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_exchange_value AS 'Sales value of items Exchange which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_exchange_units AS 'Units of items Exchange which where sold in the Clearance'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.clearance_exchange_transaction_count AS 'Count of sales Transactions Exchange which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_exchange_value AS 'Sales value of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_exchange_units AS 'Units of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG.regular_exchange_transaction_count AS 'count of exchange transactions which were sold in the regularprice'
;



/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/