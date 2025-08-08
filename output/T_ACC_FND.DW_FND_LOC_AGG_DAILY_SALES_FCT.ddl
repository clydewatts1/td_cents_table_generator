
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_LOC_AGG_DAILY_SALES_FCT = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT
    (
    business_dt DATE NOT NULL FORMAT 'yyyy-mm-dd',
    loc_id INTEGER NOT NULL FORMAT '99999',
    item_wid BIGINT NOT NULL ,
    sales_value DECIMAL(18,10) NOT NULL ,
    sales_units INTEGER NOT NULL ,
    sales_transaction_count INTEGER NOT NULL ,
    promotion_sales_value DECIMAL(18,10) NOT NULL ,
    promotion_sales_units INTEGER NOT NULL ,
    promotion_sales_transaction_count INTEGER NOT NULL ,
    clearance_sales_value DECIMAL(18,10) NOT NULL ,
    clearance_sales_units INTEGER NOT NULL ,
    clearance_sales_transaction_count INTEGER NOT NULL ,
    regular_sales_value DECIMAL(18,10) NOT NULL ,
    regular_sales_units INTEGER NOT NULL ,
    regular_sales_transaction_count INTEGER NOT NULL ,
    emp_discount_sales_value DECIMAL(18,10) NOT NULL ,
    emp_discount_sales_units INTEGER NOT NULL ,
    emp_discount_sales_transaction_count INTEGER NOT NULL ,
    cash_sales_value DECIMAL(18,10) NOT NULL ,
    cash_sales_units INTEGER NOT NULL ,
    cash_sales_transaction_count INTEGER NOT NULL ,
    card_sales_value DECIMAL(18,10) NOT NULL ,
    card_sales_units INTEGER NOT NULL ,
    card_sales_transaction_count INTEGER NOT NULL ,
    gift_sales_value DECIMAL(18,10) NOT NULL ,
    gift_sales_units INTEGER NOT NULL ,
    gift_sales_transaction_count INTEGER NOT NULL ,
    others_sales_value DECIMAL(18,10) NOT NULL ,
    others_sales_units INTEGER NOT NULL ,
    others_sales_transaction_count INTEGER NOT NULL ,
    return_value DECIMAL(18,10) NOT NULL ,
    return_units INTEGER NOT NULL ,
    return_transaction_count INTEGER NOT NULL ,
    promotion_return_value DECIMAL(18,10) NOT NULL ,
    promotion_return_units INTEGER NOT NULL ,
    promotion_return_transaction_count INTEGER NOT NULL ,
    clearance_return_value DECIMAL(18,10) NOT NULL ,
    clearance_return_units INTEGER NOT NULL ,
    clearance_return_transaction_count INTEGER NOT NULL ,
    regular_return_value DECIMAL(18,10) NOT NULL ,
    regular_return_units INTEGER NOT NULL ,
    regular_return_transaction_count INTEGER NOT NULL ,
    emp_discount_return_value DECIMAL(18,10) NOT NULL ,
    emp_discount_return_units INTEGER NOT NULL ,
    emp_discount_return_transaction_count INTEGER NOT NULL ,
    cash_return_value DECIMAL(18,10) NOT NULL ,
    cash_return_units INTEGER NOT NULL ,
    cash_return_transaction_count INTEGER NOT NULL ,
    card_return_value DECIMAL(18,10) NOT NULL ,
    card_return_units INTEGER NOT NULL ,
    card_return_transaction_count INTEGER NOT NULL ,
    gift_return_value DECIMAL(18,10) NOT NULL ,
    gift_return_units INTEGER NOT NULL ,
    gift_return_transaction_count INTEGER NOT NULL ,
    others_return_value DECIMAL(18,10) NOT NULL ,
    others_return_units INTEGER NOT NULL ,
    others_return_transaction_count INTEGER NOT NULL ,
    exchange_value DECIMAL(18,10) NOT NULL ,
    exchange_units INTEGER NOT NULL ,
    exchange_transaction_count INTEGER NOT NULL ,
    promotion_exchange_value DECIMAL(18,10) NOT NULL ,
    promotion_exchange_units INTEGER NOT NULL ,
    promotion_exchange_transaction_count INTEGER NOT NULL ,
    clearance_exchange_value DECIMAL(18,10) NOT NULL ,
    clearance_exchange_units INTEGER NOT NULL ,
    clearance_exchange_transaction_count INTEGER NOT NULL ,
    regular_exchange_value DECIMAL(18,10) NOT NULL ,
    regular_exchange_units INTEGER NOT NULL ,
    regular_exchange_transaction_count INTEGER NOT NULL ,
    emp_discount_exchange_value DECIMAL(18,10) NOT NULL ,
    emp_discount_exchange_units INTEGER NOT NULL ,
    emp_discount_exchange_transaction_count INTEGER NOT NULL ,
    cash_exchange_value DECIMAL(18,10) NOT NULL ,
    cash_exchange_units INTEGER NOT NULL ,
    cash_exchange_transaction_count INTEGER NOT NULL ,
    card_exchange_value DECIMAL(18,10) NOT NULL ,
    card_exchange_units INTEGER NOT NULL ,
    card_exchange_transaction_count INTEGER NOT NULL ,
    gift_exchange_value DECIMAL(18,10) NOT NULL ,
    gift_exchange_units INTEGER NOT NULL ,
    gift_exchange_transaction_count INTEGER NOT NULL ,
    others_exchange_value DECIMAL(18,10) NOT NULL ,
    others_exchange_units INTEGER NOT NULL ,
    others_exchange_transaction_count INTEGER NOT NULL ,
    sales_tax_amt DECIMAL(18,10) NOT NULL ,
    return_tax_amt DECIMAL(18,10) NOT NULL ,
    void_transaction_count INTEGER NOT NULL ,
    post_void_transaction_count INTEGER NOT NULL ,
    other_transaction_count INTEGER NOT NULL ,
    sales_manual_markup_amt DECIMAL(18,10) NOT NULL ,
    return_manual_markdown_amt DECIMAL(18,10) NOT NULL ,
    sales_manual_count INTEGER NOT NULL ,
    sales_manual_markdown_amt DECIMAL(18,10) NOT NULL ,
    exchanges_with_reciepts INTEGER NOT NULL ,
    exchanges_without_reciepts INTEGER NOT NULL ,
    returns_with_reciepts INTEGER NOT NULL ,
    returns_without_reciepts INTEGER NOT NULL ,
    sales_scan_count INTEGER NOT NULL ,
    no_sale_transaction_count INTEGER NOT NULL ,
    previous_full_week_sales DECIMAL(18,10) NOT NULL ,
    spv DECIMAL(18,10) NOT NULL ,
    sales_1st_date DATE  ,
    sales_1st_week DATE  ,
    days_at_clearance DATE  ,
    net_sales DECIMAL(18,10) NOT NULL ,
    regular_sell_price DECIMAL(18,10) NOT NULL ,
    sales_vat DECIMAL(18,10) NOT NULL ,
    weeks_in_store DECIMAL(18,10) NOT NULL ,
    item_selling_price DECIMAL(18,10)  ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    PRIMARY INDEX ( loc_ID ,item_wid ) PARTITION BY RANGE_N(Business_dt BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.business_dt AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.loc_id AS 'Location ID Surrogate KEY (PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.item_wid AS 'Item ID Surrogate Key (PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_value AS 'Sales value*10000 (4 implied decimal places.), value of units sold in this prom type.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_units AS 'Number of net units of merchandise sold for a subclass/location for the day.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_transaction_count AS 'This Column is used identify the Sales Transaction Count'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_sales_value AS 'Sales value of items on promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_sales_units AS 'This Column is used identify the Units sold in promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_sales_transaction_count AS 'count of sales Transactions where an item is in promotion price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_sales_value AS 'Sales Clearance Value including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_sales_units AS 'Sales Clearance Units including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_sales_transaction_count AS 'Sales Clearance Transaction count including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_sales_value AS 'SALES VALUE where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance. This amount is inclusive of VAT and net of returns.This shouldnot include Gift Cards'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_sales_units AS 'SALES UNITS where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_sales_transaction_count AS 'Count of sales Transactions returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_sales_value AS 'Sales value of transactions on Employee discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_sales_units AS 'Sales Units of transactions on Employee discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_sales_transaction_count AS 'Sales transaction count on Employee discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_sales_value AS 'Sales value of cash transaction'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_sales_units AS 'Sales Units of cash transactions'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_sales_transaction_count AS 'Sales transaction count where TENDOR TYPE is Cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_sales_value AS 'Sales value of card transactions'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_sales_units AS 'Sales units of card transactions'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_sales_transaction_count AS 'Sales transaction count where TENDOR TYPE is Cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_sales_value AS 'Sales value including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_sales_units AS 'Sales Units including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_sales_transaction_count AS 'Sales Transaction count including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_sales_value AS 'Sales Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_sales_units AS 'Sales Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_sales_transaction_count AS 'Sales Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.return_value AS 'Total Retail Value of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.return_units AS 'Total Retail Units of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.return_transaction_count AS 'Total Transaction count of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_return_value AS 'Sales value of items returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_return_units AS 'Units of items returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_return_transaction_count AS 'Count of sales Transactions returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_return_value AS 'Sales value of items returned which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_return_units AS 'Units of items returned which where sold in the Clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_return_transaction_count AS 'Count of sales Transactions returned which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_return_value AS 'Sales value of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_return_units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_return_transaction_count AS 'count of returned transaction which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_return_value AS 'Sales value of items returned which where sold in the Employee Discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_return_units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_return_transaction_count AS 'Count of sales Transactions returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_return_value AS 'Sales value of items returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_return_units AS 'Units of items returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_return_transaction_count AS 'Count of sales Transactions returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_return_value AS 'Sales value of items returned which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_return_units AS 'Units of items returned which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_return_transaction_count AS 'Count of sales Transactions returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_return_value AS 'Sales value of items returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_return_units AS 'Units of items returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_return_transaction_count AS 'Count of sales Transactions returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_return_value AS 'Return Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_return_units AS 'Return Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_return_transaction_count AS 'Return Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_value AS 'Total Retail Value of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_units AS 'Total Retail Units of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_transaction_count AS 'Total Transaction count of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_exchange_value AS 'Sales value of items Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_exchange_units AS 'Units of items Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.promotion_exchange_transaction_count AS 'Transactions Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_exchange_value AS 'Sales value of items Exchange which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_exchange_units AS 'Units of items Exchange which where sold in the Clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.clearance_exchange_transaction_count AS 'Count of sales Transactions Exchange which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_exchange_value AS 'Sales value of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_exchange_units AS 'Units of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_exchange_transaction_count AS 'count of exchange transactions which were sold in the regularprice'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_exchange_value AS 'Sales value of items Exchange which where sold in the Employee Discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_exchange_units AS 'Units of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.emp_discount_exchange_transaction_count AS 'Count of sales Transactions Exchange which where sold inthe Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_exchange_value AS 'Sales value of items Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_exchange_units AS 'Units of items Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.cash_exchange_transaction_count AS 'Count of sales Transactions Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_exchange_value AS 'Sales value of items Exchange which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_exchange_units AS 'Units of items Exchange which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.card_exchange_transaction_count AS 'Count of sales Transactions Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_exchange_value AS 'Sales value of items Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_exchange_units AS 'Units of items Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.gift_exchange_transaction_count AS 'Count of sales Transactions Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_exchange_value AS 'Exchange Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_exchange_units AS 'Exchange Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.others_exchange_transaction_count AS 'Exchange Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_tax_amt AS 'This Column is used identify the Tax amount for the sales Value'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.return_tax_amt AS 'Tax amount for the return Sales value'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.void_transaction_count AS 'Transaction count where Type = VOID'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.post_void_transaction_count AS 'Transaction count where Type = VOID'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.other_transaction_count AS 'Transaction count other than VOID and POST VOID'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_manual_markup_amt AS 'Manual Mark-up done at store level'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.return_manual_markdown_amt AS 'Value of returns which were sold on manual mark down at store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_manual_count AS 'Count of sales transaction where the barcode was manually entered(when the POS Scan did not work)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_manual_markdown_amt AS 'Manual Mark-down done at store level'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchanges_with_reciepts AS 'number of exchange transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchanges_without_reciepts AS 'number of exchange transactions where a receipt was not present'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.returns_with_reciepts AS 'number of return transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.returns_without_reciepts AS 'number of return transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_scan_count AS 'This Column is used identify the Count of scans in POS'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.no_sale_transaction_count AS 'Count of transactions where there is no sale'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.previous_full_week_sales AS 'This Column is used identify the last week sales'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.spv AS 'This Column is used identify the Sale Price Variance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_1st_date AS 'First day when store start selling an item.Date of SALES 1ST DATE'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_1st_week AS 'First Week when store start selling an item.WEEK of SALES 1ST WEEK (This is at SKU ORIN level)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.days_at_clearance AS 'Count of days that a store has been selling product at Clearance price DATE (Current) - CLEARANCE DATE'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.net_sales AS 'Calculates the total value of sales exclusive of VAT. This amount is net of returns and net of VAT.SALES VALUE - SALES VAT AMOUNT'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.regular_sell_price AS 'Selling Price of the item when its at its ORIGINAL Full Price (REGULAR SELL PRICE)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.sales_vat AS 'This Column is used identify the Vat amount on the sales'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.weeks_in_store AS 'Count of weeks that a product has be in and selling in a store CURRENT DATE - SALES 1ST DATE'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.item_selling_price AS 'This Column is used identify the Primark Item(Sku) Selling Price of the item.'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/