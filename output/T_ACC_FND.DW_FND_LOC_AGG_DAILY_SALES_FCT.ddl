
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
    item_id BIGINT NOT NULL ,
    Sales_Value DECIMAL(18,10) NOT NULL ,
    Sales_Units INTEGER NOT NULL ,
    Sales_Transaction_count INTEGER NOT NULL ,
    Promotion_Sales_Value DECIMAL(18,10) NOT NULL ,
    Promotion_Sales_Units INTEGER NOT NULL ,
    Promotion_Sales_Transaction_count INTEGER NOT NULL ,
    Clearance_Sales_Value DECIMAL(18,10) NOT NULL ,
    Clearance_Sales_Units INTEGER NOT NULL ,
    Clearance_Sales_Transaction_count INTEGER NOT NULL ,
    Regular_Sales_Value DECIMAL(18,10) NOT NULL ,
    Regular_Sales_Units INTEGER NOT NULL ,
    Regular_Sales_Transaction_count INTEGER NOT NULL ,
    Emp_Discount_Sales_Value DECIMAL(18,10) NOT NULL ,
    Emp_Discount_Sales_Units INTEGER NOT NULL ,
    Emp_Discount_Sales_Transaction_count INTEGER NOT NULL ,
    Cash_Sales_Value DECIMAL(18,10) NOT NULL ,
    Cash_Sales_Units INTEGER NOT NULL ,
    Cash_Sales_Transaction_count INTEGER NOT NULL ,
    Card_Sales_Value DECIMAL(18,10) NOT NULL ,
    Card_Sales_Units INTEGER NOT NULL ,
    Card_Sales_Transaction_count INTEGER NOT NULL ,
    Gift_Sales_Value DECIMAL(18,10) NOT NULL ,
    Gift_Sales_Units INTEGER NOT NULL ,
    Gift_Sales_Transaction_count INTEGER NOT NULL ,
    Others_Sales_Value DECIMAL(18,10) NOT NULL ,
    Others_Sales_Units INTEGER NOT NULL ,
    Others_Sales_Transaction_count INTEGER NOT NULL ,
    Return_Value DECIMAL(18,10) NOT NULL ,
    Return_Units INTEGER NOT NULL ,
    Return_Transaction_count INTEGER NOT NULL ,
    Promotion_Return_Value DECIMAL(18,10) NOT NULL ,
    Promotion_Return_Units INTEGER NOT NULL ,
    Promotion_Return_Transaction_count INTEGER NOT NULL ,
    Clearance_Return_Value DECIMAL(18,10) NOT NULL ,
    Clearance_Return_Units INTEGER NOT NULL ,
    Clearance_Return_Transaction_count INTEGER NOT NULL ,
    Regular_Return_Value DECIMAL(18,10) NOT NULL ,
    Regular_Return_Units INTEGER NOT NULL ,
    Regular_Return_Transaction_count INTEGER NOT NULL ,
    Emp_Discount_Return_Value DECIMAL(18,10) NOT NULL ,
    Emp_Discount_Return_Units INTEGER NOT NULL ,
    Emp_Discount_Return_Transaction_count INTEGER NOT NULL ,
    Cash_Return_Value DECIMAL(18,10) NOT NULL ,
    Cash_Return_Units INTEGER NOT NULL ,
    Cash_Return_Transaction_count INTEGER NOT NULL ,
    Card_Return_Value DECIMAL(18,10) NOT NULL ,
    Card_Return_Units INTEGER NOT NULL ,
    Card_Return_Transaction_count INTEGER NOT NULL ,
    Gift_Return_Value DECIMAL(18,10) NOT NULL ,
    Gift_Return_Units INTEGER NOT NULL ,
    Gift_Return_Transaction_count INTEGER NOT NULL ,
    Others_Return_Value DECIMAL(18,10) NOT NULL ,
    Others_Return_Units INTEGER NOT NULL ,
    Others_Return_Transaction_count INTEGER NOT NULL ,
    exchange_Value DECIMAL(18,10) NOT NULL ,
    exchange_Units INTEGER NOT NULL ,
    exchange_Transaction_count INTEGER NOT NULL ,
    Promotion_Exchange_Value DECIMAL(18,10) NOT NULL ,
    Promotion_exchange_Units INTEGER NOT NULL ,
    Promotion_exchange_Transaction_count INTEGER NOT NULL ,
    Clearance_exchange_Value DECIMAL(18,10) NOT NULL ,
    Clearance_exchange_Units INTEGER NOT NULL ,
    Clearance_exchange_Transaction_count INTEGER NOT NULL ,
    Regular_exchange_Value DECIMAL(18,10) NOT NULL ,
    Regular_exchange_Units INTEGER NOT NULL ,
    Regular_exchange_Transaction_count INTEGER NOT NULL ,
    Emp_Discount_exchange_Value DECIMAL(18,10) NOT NULL ,
    Emp_Discount_exchange_Units INTEGER NOT NULL ,
    Emp_Discount_exchange_Transaction_count INTEGER NOT NULL ,
    Cash_exchange_Value DECIMAL(18,10) NOT NULL ,
    Cash_exchange_Units INTEGER NOT NULL ,
    Cash_exchange_Transaction_count INTEGER NOT NULL ,
    Card_exchange_Value DECIMAL(18,10) NOT NULL ,
    Card_exchange_Units INTEGER NOT NULL ,
    Card_exchange_Transaction_count INTEGER NOT NULL ,
    Gift_exchange_Value DECIMAL(18,10) NOT NULL ,
    Gift_exchange_Units INTEGER NOT NULL ,
    Gift_exchange_Transaction_count INTEGER NOT NULL ,
    Others_exchange_Value DECIMAL(18,10) NOT NULL ,
    Others_exchange_Units INTEGER NOT NULL ,
    Others_exchange_Transaction_count INTEGER NOT NULL ,
    SALES_TAX_AMT DECIMAL(18,10) NOT NULL ,
    RETURN_TAX_AMT DECIMAL(18,10) NOT NULL ,
    Void_Transaction_count INTEGER NOT NULL ,
    Post_void_Transaction_count INTEGER NOT NULL ,
    Other_Transaction_count INTEGER NOT NULL ,
    Sales_Manual_Markup_Amt DECIMAL(18,10) NOT NULL ,
    Return_Manual_Markdown_Amt DECIMAL(18,10) NOT NULL ,
    Sales_Manual_Count INTEGER NOT NULL ,
    Sales_Manual_Markdown_Amt DECIMAL(18,10) NOT NULL ,
    Exchanges_with_reciepts INTEGER NOT NULL ,
    Exchanges_without_reciepts INTEGER NOT NULL ,
    Returns_with_reciepts INTEGER NOT NULL ,
    Returns_without_reciepts INTEGER NOT NULL ,
    Sales_Scan_Count INTEGER NOT NULL ,
    No_Sale_Transaction_count INTEGER NOT NULL ,
    Previous_Full_Week_Sales DECIMAL(18,10) NOT NULL ,
    SPV DECIMAL(18,10) NOT NULL ,
    Sales_1st_Date DATE  ,
    Sales_1st_Week DATE  ,
    Days_at_Clearance DATE  ,
    Net_Sales DECIMAL(18,10) NOT NULL ,
    Regular_Sell_Price DECIMAL(18,10) NOT NULL ,
    Sales_VAT DECIMAL(18,10) NOT NULL ,
    Weeks_in_Store DECIMAL(18,10) NOT NULL ,
    Item_Selling_Price DECIMAL(18,10)  ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    PRIMARY INDEX ( loc_ID ,Item_Id ) PARTITION BY RANGE_N(Business_dt BETWEEN DATE '2015-01-01' AND DATE '2030-12-31' EACH INTERVAL '1' DAY )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.business_dt AS 'Business Date (PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.loc_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Value AS 'Sales value*10000 (4 implied decimal places.), value of units sold in this prom type.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Units AS 'Number of net units of merchandise sold for a subclass/location for the day.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Transaction_count AS 'This Column is used identify the Sales Transaction Count'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Sales_Value AS 'Sales value of items on promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Sales_Units AS 'This Column is used identify the Units sold in promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Sales_Transaction_count AS 'count of sales Transactions where an item is in promotion price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Sales_Value AS 'Sales Clearance Value including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Sales_Units AS 'Sales Clearance Units including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Sales_Transaction_count AS 'Sales Clearance Transaction count including only like for like stores.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Sales_Value AS 'SALES VALUE where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance. This amount is inclusive of VAT and net of returns.This shouldnot include Gift Cards'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Sales_Units AS 'SALES UNITS where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance.'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Sales_Transaction_count AS 'Count of sales Transactions returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Sales_Value AS 'Sales value of transactions on Employee discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Sales_Units AS 'Sales Units of transactions on Employee discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Sales_Transaction_count AS 'Sales transaction count on Employee discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Sales_Value AS 'Sales value of cash transaction'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Sales_Units AS 'Sales Units of cash transactions'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Sales_Transaction_count AS 'Sales transaction count where TENDOR TYPE is Cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Sales_Value AS 'Sales value of card transactions'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Sales_Units AS 'Sales units of card transactions'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Sales_Transaction_count AS 'Sales transaction count where TENDOR TYPE is Cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Sales_Value AS 'Sales value including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Sales_Units AS 'Sales Units including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Sales_Transaction_count AS 'Sales Transaction count including only like for like stores where tender type is Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Sales_Value AS 'Sales Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Sales_Units AS 'Sales Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Sales_Transaction_count AS 'Sales Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Return_Value AS 'Total Retail Value of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Return_Units AS 'Total Retail Units of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Return_Transaction_count AS 'Total Transaction count of the Items Returned'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Return_Value AS 'Sales value of items returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Return_Units AS 'Units of items returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Return_Transaction_count AS 'Count of sales Transactions returned which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Return_Value AS 'Sales value of items returned which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Return_Units AS 'Units of items returned which where sold in the Clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Return_Transaction_count AS 'Count of sales Transactions returned which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Return_Value AS 'Sales value of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Return_Units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Return_Transaction_count AS 'count of returned transaction which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Return_Value AS 'Sales value of items returned which where sold in the Employee Discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Return_Units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Return_Transaction_count AS 'Count of sales Transactions returned which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Return_Value AS 'Sales value of items returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Return_Units AS 'Units of items returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Return_Transaction_count AS 'Count of sales Transactions returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Return_Value AS 'Sales value of items returned which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Return_Units AS 'Units of items returned which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Return_Transaction_count AS 'Count of sales Transactions returned which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Return_Value AS 'Sales value of items returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Return_Units AS 'Units of items returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Return_Transaction_count AS 'Count of sales Transactions returned which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Return_Value AS 'Return Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Return_Units AS 'Return Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Return_Transaction_count AS 'Return Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_Value AS 'Total Retail Value of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_Units AS 'Total Retail Units of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_Transaction_count AS 'Total Transaction count of the Items Exchange'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Exchange_Value AS 'Sales value of items Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_exchange_Units AS 'Units of items Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_exchange_Transaction_count AS 'Transactions Exchange which where sold in the promotion'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_exchange_Value AS 'Sales value of items Exchange which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_exchange_Units AS 'Units of items Exchange which where sold in the Clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where sold in the clearance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_exchange_Value AS 'Sales value of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_exchange_Units AS 'Units of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_exchange_Transaction_count AS 'count of exchange transactions which were sold in the regularprice'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_exchange_Value AS 'Sales value of items Exchange which where sold in the Employee Discount'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_exchange_Units AS 'Units of items Exchange which where sold in the Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where sold inthe Regular price'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_exchange_Value AS 'Sales value of items Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_exchange_Units AS 'Units of items Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_exchange_Value AS 'Sales value of items Exchange which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_exchange_Units AS 'Units of items Exchange which where tender type as card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where tender type as cash'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_exchange_Value AS 'Sales value of items Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_exchange_Units AS 'Units of items Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where tender type as Gift Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_exchange_Value AS 'Exchange Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_exchange_Units AS 'Exchange Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_exchange_Transaction_count AS 'Exchange Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.SALES_TAX_AMT AS 'This Column is used identify the Tax amount for the sales Value'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.RETURN_TAX_AMT AS 'Tax amount for the return Sales value'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Void_Transaction_count AS 'Transaction count where Type = VOID'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Post_void_Transaction_count AS 'Transaction count where Type = VOID'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Other_Transaction_count AS 'Transaction count other than VOID and POST VOID'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Manual_Markup_Amt AS 'Manual Mark-up done at store level'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Return_Manual_Markdown_Amt AS 'Value of returns which were sold on manual mark down at store'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Manual_Count AS 'Count of sales transaction where the barcode was manually entered(when the POS Scan did not work)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Manual_Markdown_Amt AS 'Manual Mark-down done at store level'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Exchanges_with_reciepts AS 'number of exchange transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Exchanges_without_reciepts AS 'number of exchange transactions where a receipt was not present'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Returns_with_reciepts AS 'number of return transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Returns_without_reciepts AS 'number of return transactions where a receipt was present'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Scan_Count AS 'This Column is used identify the Count of scans in POS'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.No_Sale_Transaction_count AS 'Count of transactions where there is no sale'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Previous_Full_Week_Sales AS 'This Column is used identify the last week sales'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.SPV AS 'This Column is used identify the Sale Price Variance'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_1st_Date AS 'First day when store start selling an item.Date of SALES 1ST DATE'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_1st_Week AS 'First Week when store start selling an item.WEEK of SALES 1ST WEEK (This is at SKU ORIN level)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Days_at_Clearance AS 'Count of days that a store has been selling product at Clearance price DATE (Current) - CLEARANCE DATE'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Net_Sales AS 'Calculates the total value of sales exclusive of VAT. This amount is net of returns and net of VAT.SALES VALUE - SALES VAT AMOUNT'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Sell_Price AS 'Selling Price of the item when its at its ORIGINAL Full Price (REGULAR SELL PRICE)'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_VAT AS 'This Column is used identify the Vat amount on the sales'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Weeks_in_Store AS 'Count of weeks that a product has be in and selling in a store CURRENT DATE - SALES 1ST DATE'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Item_Selling_Price AS 'This Column is used identify the Primark Item(Sku) Selling Price of the item.'
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