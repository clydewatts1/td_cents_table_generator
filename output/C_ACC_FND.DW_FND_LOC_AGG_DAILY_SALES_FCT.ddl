
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}C_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create view for DW_FND_LOC_AGG_DAILY_SALES_FCT */
REPLACE VIEW DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT
    AS LOCKING ROW FOR ACCESS

SELECT
    business_dt ,
    loc_id ,
    item_id ,
    Sales_Value ,
    Sales_Units ,
    Sales_Transaction_count ,
    Promotion_Sales_Value ,
    Promotion_Sales_Units ,
    Promotion_Sales_Transaction_count ,
    Clearance_Sales_Value ,
    Clearance_Sales_Units ,
    Clearance_Sales_Transaction_count ,
    Regular_Sales_Value ,
    Regular_Sales_Units ,
    Regular_Sales_Transaction_count ,
    Emp_Discount_Sales_Value ,
    Emp_Discount_Sales_Units ,
    Emp_Discount_Sales_Transaction_count ,
    Cash_Sales_Value ,
    Cash_Sales_Units ,
    Cash_Sales_Transaction_count ,
    Card_Sales_Value ,
    Card_Sales_Units ,
    Card_Sales_Transaction_count ,
    Gift_Sales_Value ,
    Gift_Sales_Units ,
    Gift_Sales_Transaction_count ,
    Others_Sales_Value ,
    Others_Sales_Units ,
    Others_Sales_Transaction_count ,
    Return_Value ,
    Return_Units ,
    Return_Transaction_count ,
    Promotion_Return_Value ,
    Promotion_Return_Units ,
    Promotion_Return_Transaction_count ,
    Clearance_Return_Value ,
    Clearance_Return_Units ,
    Clearance_Return_Transaction_count ,
    Regular_Return_Value ,
    Regular_Return_Units ,
    Regular_Return_Transaction_count ,
    Emp_Discount_Return_Value ,
    Emp_Discount_Return_Units ,
    Emp_Discount_Return_Transaction_count ,
    Cash_Return_Value ,
    Cash_Return_Units ,
    Cash_Return_Transaction_count ,
    Card_Return_Value ,
    Card_Return_Units ,
    Card_Return_Transaction_count ,
    Gift_Return_Value ,
    Gift_Return_Units ,
    Gift_Return_Transaction_count ,
    Others_Return_Value ,
    Others_Return_Units ,
    Others_Return_Transaction_count ,
    exchange_Value ,
    exchange_Units ,
    exchange_Transaction_count ,
    Promotion_Exchange_Value ,
    Promotion_exchange_Units ,
    Promotion_exchange_Transaction_count ,
    Clearance_exchange_Value ,
    Clearance_exchange_Units ,
    Clearance_exchange_Transaction_count ,
    Regular_exchange_Value ,
    Regular_exchange_Units ,
    Regular_exchange_Transaction_count ,
    Emp_Discount_exchange_Value ,
    Emp_Discount_exchange_Units ,
    Emp_Discount_exchange_Transaction_count ,
    Cash_exchange_Value ,
    Cash_exchange_Units ,
    Cash_exchange_Transaction_count ,
    Card_exchange_Value ,
    Card_exchange_Units ,
    Card_exchange_Transaction_count ,
    Gift_exchange_Value ,
    Gift_exchange_Units ,
    Gift_exchange_Transaction_count ,
    Others_exchange_Value ,
    Others_exchange_Units ,
    Others_exchange_Transaction_count ,
    SALES_TAX_AMT ,
    RETURN_TAX_AMT ,
    Void_Transaction_count ,
    Post_void_Transaction_count ,
    Other_Transaction_count ,
    Sales_Manual_Markup_Amt ,
    Return_Manual_Markdown_Amt ,
    Sales_Manual_Count ,
    Sales_Manual_Markdown_Amt ,
    Exchanges_with_reciepts ,
    Exchanges_without_reciepts ,
    Returns_with_reciepts ,
    Returns_without_reciepts ,
    Sales_Scan_Count ,
    No_Sale_Transaction_count ,
    Previous_Full_Week_Sales ,
    SPV ,
    Sales_1st_Date ,
    Sales_1st_Week ,
    Days_at_Clearance ,
    Net_Sales ,
    Regular_Sell_Price ,
    Sales_VAT ,
    Weeks_in_Store ,
    Item_Selling_Price ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT AS ''
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.business_dt AS 'Business Date (PK)'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.loc_id AS 'Location ID - this can either be a store or depot (PK)'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.item_id AS 'Item ID - this is the SKU Orin ( PK)'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Value AS 'Sales value*10000 (4 implied decimal places.), value of units sold in this prom type.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Units AS 'Number of net units of merchandise sold for a subclass/location for the day.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Transaction_count AS 'This Column is used identify the Sales Transaction Count'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Sales_Value AS 'Sales value of items on promotion'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Sales_Units AS 'This Column is used identify the Units sold in promotion'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Sales_Transaction_count AS 'count of sales Transactions where an item is in promotion price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Sales_Value AS 'Sales Clearance Value including only like for like stores.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Sales_Units AS 'Sales Clearance Units including only like for like stores.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Sales_Transaction_count AS 'Sales Clearance Transaction count including only like for like stores.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Sales_Value AS 'SALES VALUE where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance. This amount is inclusive of VAT and net of returns.This shouldnot include Gift Cards'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Sales_Units AS 'SALES UNITS where PRICE STATUS in Regular price (know as Full price at Primark) without any promotion or clearance.'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Sales_Transaction_count AS 'Count of sales Transactions returned which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Sales_Value AS 'Sales value of transactions on Employee discount'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Sales_Units AS 'Sales Units of transactions on Employee discount'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Sales_Transaction_count AS 'Sales transaction count on Employee discount'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Sales_Value AS 'Sales value of cash transaction'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Sales_Units AS 'Sales Units of cash transactions'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Sales_Transaction_count AS 'Sales transaction count where TENDOR TYPE is Cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Sales_Value AS 'Sales value of card transactions'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Sales_Units AS 'Sales units of card transactions'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Sales_Transaction_count AS 'Sales transaction count where TENDOR TYPE is Cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Sales_Value AS 'Sales value including only like for like stores where tender type is Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Sales_Units AS 'Sales Units including only like for like stores where tender type is Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Sales_Transaction_count AS 'Sales Transaction count including only like for like stores where tender type is Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Sales_Value AS 'Sales Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Sales_Units AS 'Sales Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Sales_Transaction_count AS 'Sales Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Return_Value AS 'Total Retail Value of the Items Returned'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Return_Units AS 'Total Retail Units of the Items Returned'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Return_Transaction_count AS 'Total Transaction count of the Items Returned'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Return_Value AS 'Sales value of items returned which where sold in the promotion'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Return_Units AS 'Units of items returned which where sold in the promotion'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Return_Transaction_count AS 'Count of sales Transactions returned which where sold in the promotion'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Return_Value AS 'Sales value of items returned which where sold in the clearance'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Return_Units AS 'Units of items returned which where sold in the Clearance'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_Return_Transaction_count AS 'Count of sales Transactions returned which where sold in the clearance'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Return_Value AS 'Sales value of items returned which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Return_Units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Return_Transaction_count AS 'count of returned transaction which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Return_Value AS 'Sales value of items returned which where sold in the Employee Discount'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Return_Units AS 'Units of items returned which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_Return_Transaction_count AS 'Count of sales Transactions returned which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Return_Value AS 'Sales value of items returned which where tender type as cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Return_Units AS 'Units of items returned which where tender type as cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_Return_Transaction_count AS 'Count of sales Transactions returned which where tender type as cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Return_Value AS 'Sales value of items returned which where tender type as card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Return_Units AS 'Units of items returned which where tender type as card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_Return_Transaction_count AS 'Count of sales Transactions returned which where tender type as cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Return_Value AS 'Sales value of items returned which where tender type as Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Return_Units AS 'Units of items returned which where tender type as Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_Return_Transaction_count AS 'Count of sales Transactions returned which where tender type as Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Return_Value AS 'Return Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Return_Units AS 'Return Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_Return_Transaction_count AS 'Return Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_Value AS 'Total Retail Value of the Items Exchange'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_Units AS 'Total Retail Units of the Items Exchange'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.exchange_Transaction_count AS 'Total Transaction count of the Items Exchange'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_Exchange_Value AS 'Sales value of items Exchange which where sold in the promotion'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_exchange_Units AS 'Units of items Exchange which where sold in the promotion'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Promotion_exchange_Transaction_count AS 'Transactions Exchange which where sold in the promotion'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_exchange_Value AS 'Sales value of items Exchange which where sold in the clearance'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_exchange_Units AS 'Units of items Exchange which where sold in the Clearance'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Clearance_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where sold in the clearance'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_exchange_Value AS 'Sales value of items Exchange which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_exchange_Units AS 'Units of items Exchange which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_exchange_Transaction_count AS 'count of exchange transactions which were sold in the regularprice'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_exchange_Value AS 'Sales value of items Exchange which where sold in the Employee Discount'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_exchange_Units AS 'Units of items Exchange which where sold in the Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Emp_Discount_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where sold inthe Regular price'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_exchange_Value AS 'Sales value of items Exchange which where tender type as cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_exchange_Units AS 'Units of items Exchange which where tender type as cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Cash_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where tender type as cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_exchange_Value AS 'Sales value of items Exchange which where tender type as card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_exchange_Units AS 'Units of items Exchange which where tender type as card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Card_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where tender type as cash'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_exchange_Value AS 'Sales value of items Exchange which where tender type as Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_exchange_Units AS 'Units of items Exchange which where tender type as Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Gift_exchange_Transaction_count AS 'Count of sales Transactions Exchange which where tender type as Gift Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_exchange_Value AS 'Exchange Values except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_exchange_Units AS 'Exchange Units except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Others_exchange_Transaction_count AS 'Exchange Transaction count except tender type is CARD,CASH,AMEX and GIFT Card'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.SALES_TAX_AMT AS 'This Column is used identify the Tax amount for the sales Value'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.RETURN_TAX_AMT AS 'Tax amount for the return Sales value'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Void_Transaction_count AS 'Transaction count where Type = VOID'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Post_void_Transaction_count AS 'Transaction count where Type = VOID'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Other_Transaction_count AS 'Transaction count other than VOID and POST VOID'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Manual_Markup_Amt AS 'Manual Mark-up done at store level'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Return_Manual_Markdown_Amt AS 'Value of returns which were sold on manual mark down at store'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Manual_Count AS 'Count of sales transaction where the barcode was manually entered(when the POS Scan did not work)'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Manual_Markdown_Amt AS 'Manual Mark-down done at store level'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Exchanges_with_reciepts AS 'number of exchange transactions where a receipt was present'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Exchanges_without_reciepts AS 'number of exchange transactions where a receipt was not present'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Returns_with_reciepts AS 'number of return transactions where a receipt was present'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Returns_without_reciepts AS 'number of return transactions where a receipt was present'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_Scan_Count AS 'This Column is used identify the Count of scans in POS'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.No_Sale_Transaction_count AS 'Count of transactions where there is no sale'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Previous_Full_Week_Sales AS 'This Column is used identify the last week sales'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.SPV AS 'This Column is used identify the Sale Price Variance'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_1st_Date AS 'First day when store start selling an item.Date of SALES 1ST DATE'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_1st_Week AS 'First Week when store start selling an item.WEEK of SALES 1ST WEEK (This is at SKU ORIN level)'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Days_at_Clearance AS 'Count of days that a store has been selling product at Clearance price DATE (Current) - CLEARANCE DATE'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Net_Sales AS 'Calculates the total value of sales exclusive of VAT. This amount is net of returns and net of VAT.SALES VALUE - SALES VAT AMOUNT'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Regular_Sell_Price AS 'Selling Price of the item when its at its ORIGINAL Full Price (REGULAR SELL PRICE)'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Sales_VAT AS 'This Column is used identify the Vat amount on the sales'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Weeks_in_Store AS 'Count of weeks that a product has be in and selling in a store CURRENT DATE - SALES 1ST DATE'
;

COMMENT ON COLUMN DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.Item_Selling_Price AS 'This Column is used identify the Primark Item(Sku) Selling Price of the item.'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}C_ACC_FND.DW_FND_LOC_AGG_DAILY_SALES_FCT.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/