/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : FND2202.300.TARGET.sql
# Pattern             : 
# Purpose             : Insertion in TRANS table
# Author              : TERADATA
# File Type           : SQL
# Creation Date       : 2025-08-15
# -------------------------------------------------------------------------------
# Change History :
# Ver  | Date        |  Modified By           |  Change Description
# -------------------------------------------------------------------------------
# 1.0  | 2025-08-15 |  Mr Primark                |  INITIAL CODE
*/

/* Set query band */
SET QUERY_BAND = 'ApplicationName=TJC;Group=FND_BASE;JobId=${JOB};JobSeq=300;Instance=${INSTANCE};RUNID=${RUNID};STREAMID=${STREAMID};' UPDATE FOR SESSION
;
.IF ERRORCODE <> 0 THEN .QUIT 101




DELETE FROM DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG
;

.IF ERRORCODE <> 0 THEN .QUIT 101

INSERT INTO DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG
(
    business_date,
    loc_wid,
    item_wid,
    fct_src_map,
    sales_1st_date,
    clearance_1st_date,
    sales_value,
    sales_units,
    sales_transaction_count,
    return_value,
    return_units,
    return_transaction_count,
    exchange_value,
    exchange_units,
    exchange_transaction_count,
    emp_discount_exchange_value,
    emp_discount_exchange_units,
    emp_discount_exchange_transaction_count,
    emp_discount_sales_value,
    emp_discount_sales_units,
    emp_discount_sales_transaction_count,
    emp_discount_return_value,
    emp_discount_return_units,
    emp_discount_return_transaction_count,
    sales_tax_amt,
    return_tax_amt,
    void_transaction_count,
    post_void_transaction_count,
    other_transaction_count,
    sales_manual_markup_amt,
    sales_manual_markdown_amt,
    return_manual_markdown_amt,
    sales_manual_count,
    sales_scan_count,
    exchanges_with_reciepts,
    exchanges_without_reciepts,
    returns_with_reciepts,
    returns_without_reciepts,
    no_sale_transaction_count,
    markdown_sales,
    cash_sales_value,
    cash_sales_units,
    cash_sales_transaction_count,
    card_sales_value,
    card_sales_units,
    card_sales_transaction_count,
    gift_sales_value,
    gift_sales_units,
    gift_sales_transaction_count,
    others_sales_value,
    others_sales_units,
    others_sales_transaction_count,
    cash_return_value,
    cash_return_units,
    cash_return_transaction_count,
    card_return_value,
    card_return_units,
    card_return_transaction_count,
    gift_return_value,
    gift_return_units,
    gift_return_transaction_count,
    others_return_value,
    others_return_units,
    others_return_transaction_count,
    cash_exchange_value,
    cash_exchange_units,
    cash_exchange_transaction_count,
    card_exchange_value,
    card_exchange_units,
    card_exchange_transaction_count,
    gift_exchange_value,
    gift_exchange_units,
    gift_exchange_transaction_count,
    others_exchange_value,
    others_exchange_units,
    others_exchange_transaction_count,
    promotion_sales_value,
    promotion_sales_units,
    promotion_sales_transaction_count,
    clearance_sales_value,
    clearance_sales_units,
    clearance_sales_transaction_count,
    regular_sales_value,
    regular_sales_units,
    regular_sales_transaction_count,
    promotion_return_value,
    promotion_return_units,
    promotion_return_transaction_count,
    clearance_return_value,
    clearance_return_units,
    clearance_return_transaction_count,
    regular_return_value,
    regular_return_units,
    regular_return_transaction_count,
    promotion_exchange_value,
    promotion_exchange_units,
    promotion_exchange_transaction_count,
    clearance_exchange_value,
    clearance_exchange_units,
    clearance_exchange_transaction_count,
    regular_exchange_value,
    regular_exchange_units,
    regular_exchange_transaction_count
)
-- CTE 1: TRANSACTIONS_PREPARED
-- Purpose: To select and prepare the initial sales transaction data from the source table.
-- This CTE filters for a specific business date, excludes voided transactions, and separates
-- standard sales and returns from post-voided (PVOID) transactions.
WITH TRANSACTIONS_PREPARED AS (
    SELECT
        SLS.loc_wid,
        item_wid,
        sales_txn_id,
        sales_business_dt,
        till_num,
        calendar_hour_id,
        cashier_id,
        -- Flag to identify if a transaction is a post-void
        -- CASE WHEN sales_type_cd <> 'PVOID' THEN 1 ELSE 0 END AS flag,
        sales_type_cd,
        orignl_sls_tsactn_id,
        original_sales_txn_item_id,
        sales_txn_dt,
        -- Isolate original sales amounts, setting to 0 for PVOID
        CASE WHEN sales_type_cd <> 'PVOID' THEN sales_amt ELSE 0 END AS sales_amt,
        CASE WHEN sales_type_cd <> 'PVOID' THEN sales_units ELSE 0 END AS sales_units,
        CASE WHEN sales_type_cd <> 'PVOID' THEN return_units ELSE 0 END AS return_units,
        CASE WHEN sales_type_cd <> 'PVOID' THEN return_amt ELSE 0 END AS return_amt,
        -- Isolate post-voided sales amounts, setting to 0 for standard transactions
        CASE WHEN sales_type_cd = 'PVOID' THEN sales_amt ELSE 0 END AS pvoid_sales_amt,
        CASE WHEN sales_type_cd = 'PVOID' THEN sales_units ELSE 0 END AS pvoid_sales_units,
        CASE WHEN sales_type_cd = 'PVOID' THEN return_amt ELSE 0 END AS pvoid_return_amt,
        CASE WHEN sales_type_cd = 'PVOID' THEN return_units ELSE 0 END AS pvoid_return_units,
        -- Isolate original tax amounts
        CASE WHEN sales_type_cd <> 'PVOID' THEN sales_tax_amt ELSE 0 END AS sales_tax_amt,
        CASE WHEN sales_type_cd <> 'PVOID' THEN return_tax_amt ELSE 0 END AS return_tax_amt,
        -- Isolate post-voided tax amounts
        CASE WHEN sales_type_cd = 'PVOID' THEN sales_tax_amt ELSE 0 END AS pvoid_sales_tax_amt,
        CASE WHEN sales_type_cd = 'PVOID' THEN return_tax_amt ELSE 0 END AS pvoid_return_tax_amt,
        sales_employee_discount_amt,
        sales_scan_count,
        sales_manual_count,
        return_employee_discount_amt,
        return_scan_count,
        return_manual_count,
        sales_manual_markdown_amt,
        sales_manual_markup_amt,
        return_manual_markdown_amt,
        return_manual_markup_amt,
        void_flg,
        no_sale_flg,
        cancelled_flg,
        sales_currency_cd,
        processing_ind,
        sales_tsactn_line_number,
        updated_sales_type_cd,
        gift_card_item_ind,
        eff_from_dttm,
        eff_to_dttm,
        cur_flg,
        del_flg,
        w_insrt_dttm,
        w_updt_dttm,
        ssor_id,
        nrt_processing_ind,
        retail_type
    FROM DW${INSTANCE}A_ACC_ODS.DW_ODS_SLS_TXN_LN_FV AS SLS
    -- Filter for yesterday's sales data.
    WHERE SLS.sales_business_dt = date '${LDTK_DATE}'
        -- Filter out fully voided transactions and ensure the void flag is not true.
        AND sales_type_cd <> 'VOID' AND COALESCE(void_flg, 'false') = 'false'
        AND item_wid IS NOT NULL AND loc_wid IS NOT NULL
        AND cur_flg = 'Y'
),
-- CTE 2: VOL_DW_ODS_SLS_TXN_LN_FV
-- Purpose: To calculate the net transaction amounts by subtracting the post-voided values
-- from the original transaction values. This CTE effectively cleans the data.
VOL_DW_ODS_SLS_TXN_LN_FV AS (
    SELECT
        -- Key identifiers for the transaction
        loc_wid, --1
        item_wid, --2
        sales_txn_id, --3
        sales_business_dt, --4
        till_num, --5
        calendar_hour_id, --6
        cashier_id, --7
        sales_type_cd, --8
        orignl_sls_tsactn_id, --9
        original_sales_txn_item_id, --10
        sales_txn_dt, --11
        -- Calculate net sales tax by subtracting post-voided tax from the original tax amount
        SUM(sales_tax_amt) - SUM(pvoid_sales_tax_amt) AS sales_tax_amt, --12 (Aggregated)
        sales_employee_discount_amt, --13
        sales_scan_count, --14
        sales_manual_count, --15
        -- Calculate net return tax similarly
        SUM(return_tax_amt) - SUM(pvoid_return_tax_amt) AS return_tax_amt, --16 (Aggregated)
        return_employee_discount_amt, --17
        return_scan_count, --18
        return_manual_count, --19
        sales_manual_markdown_amt, --20
        sales_manual_markup_amt, --21
        return_manual_markdown_amt, --22
        return_manual_markup_amt, --23
        -- Flags and metadata
        void_flg, --24
        no_sale_flg, --25
        cancelled_flg, --26
        sales_currency_cd, --27
        processing_ind, --28
        sales_tsactn_line_number, --29
        updated_sales_type_cd, --30
        gift_card_item_ind, --31
        eff_from_dttm, --32
        eff_to_dttm, --33
        cur_flg, --34
        del_flg, --35
        w_insrt_dttm, --36
        w_updt_dttm, --37
        ssor_id, --38
        nrt_processing_ind, --39
        retail_type, --40
        -- Calculate net sales units and amounts
        SUM(sales_units) - SUM(pvoid_sales_units) AS sales_units, --41 (Aggregated)
        SUM(sales_amt) - SUM(pvoid_sales_amt) AS sales_amt, --42 (Aggregated)
        -- Calculate net return units and amounts
        SUM(return_units) - SUM(pvoid_return_units) AS return_units, --43 (Aggregated)
        SUM(return_amt) - SUM(pvoid_return_amt) AS return_amt --44 (Aggregated)
    FROM TRANSACTIONS_PREPARED
    -- FIX: The GROUP BY clause now correctly includes all non-aggregated columns by their position number
    -- and excludes the aggregated columns.
    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40
),
-- CTE 3: VOL_SLS_TXN_TY_DATA
-- Purpose: To select the cleaned transaction data for the specific business day being processed.
VOL_SLS_TXN_TY_DATA AS (
    SELECT
        loc_wid,
        item_wid,
        date '${LDTK_DATE}' AS business_day_id,
        CAST(eff_from_dttm AS DATE) AS effective_from_dt,
        no_sale_flg,
        void_flg,
        sales_type_cd,
        updated_sales_type_cd,
        sales_txn_id,
        sales_tsactn_line_number,
        cancelled_flg,
        orignl_sls_tsactn_id AS original_sales_txn_id,
        retail_type,
        sales_amt,
        sales_units,
        return_amt,
        return_units,
        sales_employee_discount_amt,
        return_employee_discount_amt,
        sales_tax_amt,
        return_tax_amt,
        sales_manual_markup_amt,
        sales_manual_markdown_amt,
        return_manual_markdown_amt,
        sales_manual_count,
        sales_scan_count
    FROM VOL_DW_ODS_SLS_TXN_LN_FV
    -- Filter to ensure data is for the correct day and is the current active record.
    -- not need done earlier   -- WHERE business_day_id = CURRENT_DATE - 1
    ---    AND cur_flg = 'Y'
),
-- CTE 4: VOL_SLS_TXN_TY_DELTA_DATA
-- Purpose: A staging CTE that passes the data through to the next aggregation step.
VOL_SLS_TXN_TY_DELTA_DATA AS (
    SELECT
        loc_wid,
        item_wid,
        business_day_id,
        effective_from_dt,
        no_sale_flg,
        void_flg,
        sales_type_cd,
        updated_sales_type_cd,
        sales_txn_id,
        sales_tsactn_line_number,
        cancelled_flg,
        original_sales_txn_id,
        retail_type,
        sales_amt,
        sales_units,
        return_amt,
        return_units,
        sales_employee_discount_amt,
        return_employee_discount_amt,
        sales_tax_amt,
        return_tax_amt,
        sales_manual_markup_amt,
        sales_manual_markdown_amt,
        return_manual_markdown_amt,
        sales_manual_count,
        sales_scan_count
    FROM VOL_SLS_TXN_TY_DATA AS TY
),
-- CTE 5: VOL_SLS_TXN_TY
-- Purpose: To aggregate the transaction data to the transaction line level.
VOL_SLS_TXN_TY AS (
    SELECT
        loc_wid,
        item_wid,
        business_day_id,
        no_sale_flg,
        void_flg,
        sales_type_cd,
        updated_sales_type_cd,
        sales_txn_id,
        cancelled_flg,
        original_sales_txn_id,
        retail_type,
        SUM(sales_amt) AS sales_amt,
        SUM(sales_units) AS sales_units,
        SUM(return_amt) AS return_amt,
        SUM(return_units) AS return_units,
        SUM(sales_employee_discount_amt) AS sales_employee_discount_amt,
        SUM(return_employee_discount_amt) AS return_employee_discount_amt,
        SUM(sales_tax_amt) AS sales_tax_amt,
        SUM(return_tax_amt) AS return_tax_amt,
        SUM(sales_manual_markup_amt) AS sales_manual_markup_amt,
        SUM(sales_manual_markdown_amt) AS sales_manual_markdown_amt,
        SUM(return_manual_markdown_amt) AS return_manual_markdown_amt,
        SUM(sales_manual_count) AS sales_manual_count,
        SUM(sales_scan_count) AS sales_scan_count
    FROM VOL_SLS_TXN_TY_DELTA_DATA
    -- FIX: Changed to numbered GROUP BY as requested.
    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
),
-- CTE 6: VOL_POS_TENDER_TYPE
-- Purpose: To create a reference map for tender types, converting tender codes into descriptive categories.
VOL_POS_TENDER_TYPE AS (
    SELECT
        tender_type_description,
        tender_group_description,
        tender_type_code,
        CASE
            WHEN TND.tender_type_code = '3020' THEN 'Amex'
            WHEN TND.tender_type_code = '3260' THEN 'Giftcard'
            WHEN TND.tender_type_code BETWEEN '1000' AND '1999' THEN 'Cash'
            WHEN (TND.tender_type_code BETWEEN '3000' AND '3999' OR tender_type_code = '6') AND TND.tender_type_code NOT IN ('3020') THEN 'Card'
            ELSE 'Others'
        END AS tender_type
    FROM DW${INSTANCE}A_ACC_ORR.DW_POS_TENDER_TYPE_DV AS TND
    WHERE current_flg = 'Y'
),
-- CTE 7: VOL_TENDER_SALES_TXN_TY
-- Purpose: To fetch tender data for the previous day's sales transactions.
VOL_SLS_TSACTN AS (
    SELECT
        sls_tsactn_id,
        pos_dvc_id,
        rptd_as_dttm,
        updt_tsactn_type,
        tsactn_type_cd,
        ssor_id
    FROM DW${INSTANCE}A_IDW.SLS_TSACTN
    WHERE
        CAST(rptd_as_dttm AS DATE) = DATE '${LDTK_DATE}'
        AND ssor_id <> 3
        AND COALESCE(updt_tsactn_type, tsactn_type_cd) <> 'PVOID'
),
-- CTE 8: Selects device event data for join logic.
VOL_POS_DVC_EV AS (
    SELECT
        pos_dvc_id,
        sls_tsactn_id,
        pos_dvc_ev_dttm,
        ssor_id
    FROM DW${INSTANCE}A_IDW.POS_DVC_EV
    WHERE
        CAST(pos_dvc_ev_dttm AS DATE) = DATE '${LDTK_DATE}'
        AND ssor_id <> 3
),
-- CTE 9: Selects payment line data to link sales transactions to payment transactions.
VOL_SLS_PMT_LN AS (
    SELECT
        sls_tsactn_id,
        pmt_tsactn_id,
        pmt_appl_dttm,
        ssor_id
    FROM DW${INSTANCE}A_IDW.SLS_PMT_LN
    WHERE
        CAST(pmt_appl_dttm AS DATE) = DATE '${LDTK_DATE}'
        AND ssor_id <> 3
),
-- CTE 10: Selects payment transaction details like tender type and amount.
VOL_PMT_TSACTN AS (
    SELECT
        pmt_tsactn_id,
        pmt_type_cd,
        tndrd_pmt_amt,
        tndrd_pmt_dttm,
        ssor_id
    FROM DW${INSTANCE}A_IDW.PMT_TSACTN
    WHERE
        CAST(tndrd_pmt_dttm AS DATE) = DATE '${LDTK_DATE}'
        AND ssor_id <> 3
),
-- CTE 11: TNDR_TY - Joins the above CTEs to create a detailed tender transaction view.
TNDR_TY AS (
    SELECT DISTINCT
        A.loc_wid,
        B.sls_tsactn_id AS "sales_transaction_id",
        B.rptd_as_dttm AS "sales_business_date",
        E.pmt_type_cd AS "tender_type_code",
        E.tndrd_pmt_amt AS "tender_sales_amount",
        A.eff_from_dttm AS "effective_from_dt"
    FROM DW${INSTANCE}A_IDW.POS_DVC AS A
    INNER JOIN VOL_SLS_TSACTN AS B
        ON A.pos_dvc_id = B.pos_dvc_id
    INNER JOIN VOL_POS_DVC_EV AS C
        ON A.pos_dvc_id = C.pos_dvc_id AND B.sls_tsactn_id = C.sls_tsactn_id
    INNER JOIN VOL_SLS_PMT_LN AS D
        ON B.sls_tsactn_id = D.sls_tsactn_id
    INNER JOIN VOL_PMT_TSACTN AS E
        ON D.pmt_tsactn_id = E.pmt_tsactn_id
    WHERE A.ssor_id <> 3
),
-- CTE 12: Filters tender data for the specific business date required.
VOL_TENDER_SALES_TXN_TY AS (
    SELECT
        TNDR_TY."sales_transaction_id",
        TNDR_TY.loc_wid,
        DATE '${LDTK_DATE}' AS sales_business_date,
        TNDR_TY."effective_from_dt",
        TNDR_TY."tender_type_code",
        TNDR_TY."tender_sales_amount"
    FROM TNDR_TY
    WHERE
        TNDR_TY."sales_business_date" = DATE '${LDTK_DATE}'
),
-- CTE 13: VOL_TND_SLS_TXN_TY_PRE
-- Purpose: To calculate the ratio of each tender type used within a single transaction.
-- This is necessary to prorate sales amounts across multiple payment methods.
VOL_TND_SLS_TXN_TY_PRE AS (
    SELECT
        sales_transaction_id,
        loc_wid,
        sales_business_date,
        TND.tender_type_code,
        POS.tender_type,
        -- Calculate the total tender amount for the entire transaction.
        SUM(tender_sales_amount) OVER (PARTITION BY sales_transaction_id) AS full_tndr,
        -- Calculate the ratio of this specific tender line to the total transaction amount.
        COALESCE((tender_sales_amount / (CASE WHEN full_tndr IS NULL OR full_tndr = 0 THEN 1 ELSE full_tndr END)), 0) AS rat_tndr,
        -- Create ratio and count columns for each tender category.
        CASE WHEN tender_type = 'Cash' THEN rat_tndr ELSE 0 END AS cash_rat,
        CASE WHEN tender_type = 'Cash' THEN 1 ELSE 0 END AS cash_txn_cnt,
        CASE WHEN tender_type = 'Card' THEN rat_tndr ELSE 0 END AS card_rat,
        CASE WHEN tender_type = 'Card' THEN 1 ELSE 0 END AS card_txn_cnt,
        CASE WHEN tender_type = 'Amex' THEN rat_tndr ELSE 0 END AS amex_rat,
        CASE WHEN tender_type = 'Amex' THEN 1 ELSE 0 END AS amex_txn_cnt,
        CASE WHEN tender_type = 'Giftcard' THEN rat_tndr ELSE 0 END AS giftcard_rat,
        CASE WHEN tender_type = 'Giftcard' THEN 1 ELSE 0 END AS giftcard_txn_cnt,
        CASE WHEN tender_type = 'Others' THEN rat_tndr ELSE 0 END AS others_rat,
        CASE WHEN tender_type = 'Others' THEN 1 ELSE 0 END AS others_txn_cnt
    FROM VOL_TENDER_SALES_TXN_TY AS TND
    INNER JOIN VOL_POS_TENDER_TYPE AS POS
        ON TND.tender_type_code = POS.tender_type_code
),
-- CTE 14: VOL_TND_SLS_TXN_TY
-- Purpose: To aggregate the tender ratios to get the final tender split for each transaction.
VOL_TND_SLS_TXN_TY AS (
    SELECT
        sales_transaction_id,
        loc_wid,
        sales_business_date,
        SUM(cash_rat) AS cash_rat,
        SUM(card_rat) AS card_rat,
        SUM(amex_rat) AS amex_rat,
        SUM(giftcard_rat) AS giftcard_rat,
        SUM(others_rat) AS others_rat,
        SUM(cash_txn_cnt) AS cash_txn_cnt,
        SUM(card_txn_cnt) AS card_txn_cnt,
        SUM(amex_txn_cnt) AS amex_txn_cnt,
        SUM(giftcard_txn_cnt) AS giftcard_txn_cnt,
        SUM(others_txn_cnt) AS others_txn_cnt
    FROM VOL_TND_SLS_TXN_TY_PRE
    GROUP BY 1, 2, 3
),
-- CTE 15: SLS_TNDR_TY
-- Purpose: This is the main calculation engine. It joins sales data with tender data
-- and calculates a wide range of metrics based on transaction type, retail type, and tender type.
SLS_TNDR_TY AS (
    SELECT
        TY.sales_txn_id,
        TY.loc_wid,
        TY.item_wid,
        TY.business_day_id,
        -- Base sales and return metrics
        TY.sales_amt AS sales_amt,
        TY.sales_units AS sales_units,
        CASE WHEN TY.sales_type_cd = 'SALE' THEN 1 ELSE 0 END AS sales_transaction_count,
        TY.return_amt AS return_amt,
        TY.return_units AS return_units,
        CASE WHEN TY.sales_type_cd = 'RETURN' THEN 1 ELSE 0 END AS return_transaction_count,
        -- Exchange metrics
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN TY.sales_amt ELSE 0 END AS exchange_value,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN TY.sales_units ELSE 0 END AS exchange_units,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN 1 ELSE 0 END AS exchange_transaction_count,
        -- Employee discount metrics
        CASE WHEN (COALESCE(TY.sales_employee_discount_amt, 0) > 0 AND TY.sales_amt > 0 AND TY.return_amt > 0) THEN TY.sales_amt ELSE 0 END AS emp_discount_exchange_value,
        CASE WHEN (COALESCE(TY.sales_employee_discount_amt, 0) > 0 AND TY.sales_amt > 0 AND TY.return_amt > 0) THEN TY.sales_units ELSE 0 END AS emp_discount_exchange_units,
        CASE WHEN (COALESCE(TY.sales_employee_discount_amt, 0) > 0 AND TY.sales_amt > 0 AND TY.return_amt > 0) THEN 1 ELSE 0 END AS emp_discount_exchange_transaction_count,
        CASE WHEN TY.sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN TY.sales_employee_discount_amt ELSE 0 END AS emp_discount_sales_value,
        CASE WHEN TY.sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' AND TY.sales_employee_discount_amt > 0 THEN TY.sales_units ELSE 0 END AS emp_discount_sales_units,
        CASE WHEN TY.sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' AND TY.sales_employee_discount_amt > 0 THEN 1 ELSE 0 END AS emp_discount_sales_transaction_count,
        CASE WHEN TY.sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN TY.return_employee_discount_amt ELSE 0 END AS emp_discount_return_value,
        CASE WHEN TY.sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' AND TY.return_employee_discount_amt > 0 THEN TY.return_units ELSE 0 END AS emp_discount_return_units,
        CASE WHEN TY.sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' AND TY.return_employee_discount_amt > 0 THEN 1 ELSE 0 END AS emp_discount_return_transaction_count,
        -- Tax and transaction status metrics
        TY.sales_tax_amt AS sales_tax_amt,
        TY.return_tax_amt AS return_tax_amt,
        CASE WHEN TY.void_flg = 'Y' THEN 1 ELSE 0 END AS void_transaction_count,
        CASE WHEN TY.updated_sales_type_cd = 'PVOID' THEN 1 ELSE 0 END AS post_void_transaction_count,
        CASE WHEN TY.cancelled_flg = 'N' AND TY.void_flg = 'N' THEN 1 ELSE 0 END AS other_transaction_count,
        -- Manual adjustment and receipt metrics
        TY.sales_manual_markup_amt AS sales_manual_markup_amt,
        TY.sales_manual_markdown_amt AS sales_manual_markdown_amt,
        TY.return_manual_markdown_amt AS return_manual_markdown_amt,
        CASE WHEN TY.sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN TY.sales_manual_count ELSE 0 END AS sales_manual_count,
        CASE WHEN TY.sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN TY.sales_scan_count ELSE 0 END AS sales_scan_count,
        CASE WHEN TY.updated_sales_type_cd = 'EXCH' AND TY.original_sales_txn_id IS NOT NULL AND TY.sales_amt > 0 THEN TY.sales_amt ELSE 0 END AS exchanges_with_reciepts,
        CASE WHEN TY.updated_sales_type_cd = 'EXCH' AND TY.original_sales_txn_id IS NULL AND TY.sales_amt > 0 THEN TY.sales_amt ELSE 0 END AS exchanges_without_reciepts,
        CASE WHEN TY.updated_sales_type_cd = 'RETURN' AND TY.original_sales_txn_id IS NOT NULL AND TY.return_amt > 0 THEN TY.return_amt ELSE 0 END AS returns_with_reciepts,
        CASE WHEN TY.updated_sales_type_cd = 'RETURN' AND TY.original_sales_txn_id IS NULL AND TY.return_amt > 0 THEN TY.return_amt ELSE 0 END AS returns_without_reciepts,
        CASE WHEN TY.no_sale_flg = 'Y' THEN 1 ELSE 0 END AS no_sale_transaction_count,
        -- Markdown sales metrics
        CASE WHEN TY.sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' AND TY.retail_type IN ('P', 'C') THEN TY.sales_amt ELSE 0 END AS markdown_sales,
        -- Sales metrics prorated by tender type
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN (TY.sales_amt * TN_DY.cash_rat) ELSE 0 END AS cash_sales_value,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN CEIL((TY.sales_units * TN_DY.cash_rat)) ELSE 0 END AS cash_sales_units,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN TN_DY.cash_txn_cnt ELSE 0 END AS cash_sales_transaction_count,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN (TY.sales_amt * TN_DY.card_rat) ELSE 0 END AS card_sales_value,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN CEIL((TY.sales_units * TN_DY.card_rat)) ELSE 0 END AS card_sales_units,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN TN_DY.card_txn_cnt ELSE 0 END AS card_sales_transaction_count,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN (TY.sales_amt * TN_DY.giftcard_rat) ELSE 0 END AS gift_sales_value,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN CEIL((TY.sales_units * TN_DY.giftcard_rat)) ELSE 0 END AS gift_sales_units,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN TN_DY.giftcard_txn_cnt ELSE 0 END AS gift_sales_transaction_count,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN (TY.sales_amt * TN_DY.others_rat) ELSE 0 END AS others_sales_value,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN CEIL((TY.sales_units * TN_DY.others_rat)) ELSE 0 END AS others_sales_units,
        CASE WHEN sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN TN_DY.others_txn_cnt ELSE 0 END AS others_sales_transaction_count,
        -- Return metrics prorated by tender type
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN (TY.return_amt * TN_DY.cash_rat) ELSE 0 END AS cash_return_value,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN CEIL((TY.return_units * TN_DY.cash_rat)) ELSE 0 END AS cash_return_units,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN TN_DY.cash_txn_cnt ELSE 0 END AS cash_return_transaction_count,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN (TY.return_amt * TN_DY.card_rat) ELSE 0 END AS card_return_value,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN CEIL((TY.return_units * TN_DY.card_rat)) ELSE 0 END AS card_return_units,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN TN_DY.card_txn_cnt ELSE 0 END AS card_return_transaction_count,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN (TY.return_amt * TN_DY.giftcard_rat) ELSE 0 END AS gift_return_value,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN CEIL((TY.return_units * TN_DY.giftcard_rat)) ELSE 0 END AS gift_return_units,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN TN_DY.giftcard_txn_cnt ELSE 0 END AS gift_return_transaction_count,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN (TY.return_amt * TN_DY.others_rat) ELSE 0 END AS others_return_value,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN CEIL((TY.return_units * TN_DY.others_rat)) ELSE 0 END AS others_return_units,
        CASE WHEN sales_type_cd = 'RETURN' AND TY.updated_sales_type_cd = 'RETURN' THEN TN_DY.others_txn_cnt ELSE 0 END AS others_return_transaction_count,
        -- Exchange metrics prorated by tender type
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN (TY.sales_amt * TN_DY.cash_rat) ELSE 0 END AS cash_exchange_value,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN CEIL((TY.sales_units * TN_DY.cash_rat)) ELSE 0 END AS cash_exchange_units,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN TN_DY.cash_txn_cnt ELSE 0 END AS cash_exchange_transaction_count,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN (TY.sales_amt * TN_DY.card_rat) ELSE 0 END AS card_exchange_value,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN CEIL((TY.sales_units * TN_DY.card_rat)) ELSE 0 END AS card_exchange_units,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN TN_DY.card_txn_cnt ELSE 0 END AS card_exchange_transaction_count,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN (TY.sales_amt * TN_DY.giftcard_rat) ELSE 0 END AS gift_exchange_value,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN CEIL((TY.sales_units * TN_DY.giftcard_rat)) ELSE 0 END AS gift_exchange_units,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN TN_DY.giftcard_txn_cnt ELSE 0 END AS gift_exchange_transaction_count,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN (TY.sales_amt * TN_DY.others_rat) ELSE 0 END AS others_exchange_value,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN CEIL((TY.sales_units * TN_DY.others_rat)) ELSE 0 END AS others_exchange_units,
        CASE WHEN (TY.updated_sales_type_cd = 'EXCH' AND TY.sales_type_cd = 'SALE') THEN TN_DY.others_txn_cnt ELSE 0 END AS others_exchange_transaction_count,
        -- Sales metrics by retail type (Promotion, Clearance, Regular)
        CASE WHEN TY.retail_type = 'P' THEN TY.sales_amt ELSE 0 END AS promotion_sales_value,
        CASE WHEN TY.retail_type = 'P' THEN TY.sales_units ELSE 0 END AS promotion_sales_units,
        CASE WHEN TY.retail_type = 'P' AND TY.sales_type_cd = 'SALE' THEN 1 ELSE 0 END AS promotion_sales_transaction_count,
        CASE WHEN TY.retail_type = 'C' THEN TY.sales_amt ELSE 0 END AS clearance_sales_value,
        CASE WHEN TY.retail_type = 'C' THEN TY.sales_units ELSE 0 END AS clearance_sales_units,
        CASE WHEN TY.retail_type = 'C' AND TY.sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN 1 ELSE 0 END AS clearance_sales_transaction_count,
        CASE WHEN TY.retail_type = 'R' THEN TY.sales_amt ELSE 0 END AS regular_sales_value,
        CASE WHEN TY.retail_type = 'R' THEN TY.sales_units ELSE 0 END AS regular_sales_units,
        CASE WHEN TY.retail_type = 'R' AND TY.sales_type_cd = 'SALE' AND TY.updated_sales_type_cd = 'SALE' THEN 1 ELSE 0 END AS regular_sales_transaction_count,
        -- Return metrics by retail type
        CASE WHEN TY.retail_type = 'P' THEN TY.return_amt ELSE 0 END AS promotion_return_value,
        CASE WHEN TY.retail_type = 'P' THEN TY.return_units ELSE 0 END AS promotion_return_units,
        CASE WHEN TY.retail_type = 'P' AND TY.sales_type_cd = 'RETURN' THEN 1 ELSE 0 END AS promotion_return_transaction_count,
        CASE WHEN TY.retail_type = 'C' THEN TY.return_amt ELSE 0 END AS clearance_return_value,
        CASE WHEN TY.retail_type = 'C' THEN TY.return_units ELSE 0 END AS clearance_return_units,
        CASE WHEN TY.retail_type = 'C' AND TY.sales_type_cd = 'RETURN' THEN 1 ELSE 0 END AS clearance_return_transaction_count,
        CASE WHEN TY.retail_type = 'R' THEN TY.return_amt ELSE 0 END AS regular_return_value,
        CASE WHEN TY.retail_type = 'R' THEN TY.return_units ELSE 0 END AS regular_return_units,
        CASE WHEN TY.retail_type = 'R' AND TY.sales_type_cd = 'RETURN' THEN 1 ELSE 0 END AS regular_return_transaction_count,
        -- Exchange metrics by retail type
        CASE WHEN TY.retail_type = 'P' THEN TY.sales_amt ELSE 0 END AS promotion_exchange_value,
        CASE WHEN TY.retail_type = 'P' THEN TY.sales_units ELSE 0 END AS promotion_exchange_units,
        CASE WHEN TY.retail_type = 'P' AND (TY.updated_sales_type_cd = 'EXCH') THEN 1 ELSE 0 END AS promotion_exchange_transaction_count,
        CASE WHEN TY.retail_type = 'C' THEN (TY.sales_amt - TY.return_amt) ELSE 0 END AS clearance_exchange_value,
        CASE WHEN TY.retail_type = 'C' THEN TY.sales_units ELSE 0 END AS clearance_exchange_units,
        CASE WHEN TY.retail_type = 'C' AND (TY.updated_sales_type_cd = 'EXCH') THEN 1 ELSE 0 END AS clearance_exchange_transaction_count,
        CASE WHEN TY.retail_type = 'R' THEN TY.sales_amt ELSE 0 END AS regular_exchange_value,
        CASE WHEN TY.retail_type = 'R' THEN TY.sales_units ELSE 0 END AS regular_exchange_units,
        CASE WHEN TY.retail_type = 'R' AND (TY.updated_sales_type_cd = 'EXCH') THEN 1 ELSE 0 END AS regular_exchange_transaction_count
    FROM VOL_SLS_TXN_TY AS TY
    LEFT OUTER JOIN VOL_TND_SLS_TXN_TY AS TN_DY
        ON TY.sales_txn_id = TN_DY.sales_transaction_id
        AND TY.loc_wid = TN_DY.loc_wid
        AND TY.business_day_id = TN_DY.sales_business_date
),
-- CTE 16: VOL_SLS_TXN_THY
-- Purpose: To perform the main aggregation, summing up all the calculated metrics to the
-- item, location, and day level. This creates the final summary data.
VOL_SLS_TXN_THY AS (
    SELECT
        loc_wid,
        item_wid,
        business_day_id,
        SUM(sales_amt) AS sales_amt,
        SUM(sales_units) AS sales_units,
        SUM(sales_transaction_count) AS sales_transaction_count,
        SUM(return_amt) AS return_amt,
        SUM(return_units) AS return_units,
        SUM(return_transaction_count) AS return_transaction_count,
        SUM(exchange_value) AS exchange_value,
        SUM(exchange_units) AS exchange_units,
        SUM(exchange_transaction_count) AS exchange_transaction_count,
        SUM(emp_discount_exchange_value) AS emp_discount_exchange_value,
        SUM(emp_discount_exchange_units) AS emp_discount_exchange_units,
        SUM(emp_discount_exchange_transaction_count) AS emp_discount_exchange_transaction_count,
        SUM(emp_discount_sales_value) AS emp_discount_sales_value,
        SUM(emp_discount_sales_units) AS emp_discount_sales_units,
        SUM(emp_discount_sales_transaction_count) AS emp_discount_sales_transaction_count,
        SUM(emp_discount_return_value) AS emp_discount_return_value,
        SUM(emp_discount_return_units) AS emp_discount_return_units,
        SUM(emp_discount_return_transaction_count) AS emp_discount_return_transaction_count,
        SUM(sales_tax_amt) AS sales_tax_amt,
        SUM(return_tax_amt) AS return_tax_amt,
        SUM(void_transaction_count) AS void_transaction_count,
        SUM(post_void_transaction_count) AS post_void_transaction_count,
        SUM(other_transaction_count) AS other_transaction_count,
        SUM(sales_manual_markup_amt) AS sales_manual_markup_amt,
        SUM(sales_manual_markdown_amt) AS sales_manual_markdown_amt,
        SUM(return_manual_markdown_amt) AS return_manual_markdown_amt,
        SUM(sales_manual_count) AS sales_manual_count,
        SUM(sales_scan_count) AS sales_scan_count,
        SUM(exchanges_with_reciepts) AS exchanges_with_reciepts,
        SUM(exchanges_without_reciepts) AS exchanges_without_reciepts,
        SUM(returns_with_reciepts) AS returns_with_reciepts,
        SUM(returns_without_reciepts) AS returns_without_reciepts,
        SUM(no_sale_transaction_count) AS no_sale_transaction_count,
        SUM(markdown_sales) AS markdown_sales,
        SUM(cash_sales_value) AS cash_sales_value,
        SUM(cash_sales_units) AS cash_sales_units,
        SUM(cash_sales_transaction_count) AS cash_sales_transaction_count,
        SUM(card_sales_value) AS card_sales_value,
        SUM(card_sales_units) AS card_sales_units,
        SUM(card_sales_transaction_count) AS card_sales_transaction_count,
        SUM(gift_sales_value) AS gift_sales_value,
        SUM(gift_sales_units) AS gift_sales_units,
        SUM(gift_sales_transaction_count) AS gift_sales_transaction_count,
        SUM(others_sales_value) AS others_sales_value,
        SUM(others_sales_units) AS others_sales_units,
        SUM(others_sales_transaction_count) AS others_sales_transaction_count,
        SUM(cash_return_value) AS cash_return_value,
        SUM(cash_return_units) AS cash_return_units,
        SUM(cash_return_transaction_count) AS cash_return_transaction_count,
        SUM(card_return_value) AS card_return_value,
        SUM(card_return_units) AS card_return_units,
        SUM(card_return_transaction_count) AS card_return_transaction_count,
        SUM(gift_return_value) AS gift_return_value,
        SUM(gift_return_units) AS gift_return_units,
        SUM(gift_return_transaction_count) AS gift_return_transaction_count,
        SUM(others_return_value) AS others_return_value,
        SUM(others_return_units) AS others_return_units,
        SUM(others_return_transaction_count) AS others_return_transaction_count,
        SUM(cash_exchange_value) AS cash_exchange_value,
        SUM(cash_exchange_units) AS cash_exchange_units,
        SUM(cash_exchange_transaction_count) AS cash_exchange_transaction_count,
        SUM(card_exchange_value) AS card_exchange_value,
        SUM(card_exchange_units) AS card_exchange_units,
        SUM(card_exchange_transaction_count) AS card_exchange_transaction_count,
        SUM(gift_exchange_value) AS gift_exchange_value,
        SUM(gift_exchange_units) AS gift_exchange_units,
        SUM(gift_exchange_transaction_count) AS gift_exchange_transaction_count,
        SUM(others_exchange_value) AS others_exchange_value,
        SUM(others_exchange_units) AS others_exchange_units,
        SUM(others_exchange_transaction_count) AS others_exchange_transaction_count,
        SUM(promotion_sales_value) AS promotion_sales_value,
        SUM(promotion_sales_units) AS promotion_sales_units,
        SUM(promotion_sales_transaction_count) AS promotion_sales_transaction_count,
        SUM(clearance_sales_value) AS clearance_sales_value,
        SUM(clearance_sales_units) AS clearance_sales_units,
        SUM(clearance_sales_transaction_count) AS clearance_sales_transaction_count,
        SUM(regular_sales_value) AS regular_sales_value,
        SUM(regular_sales_units) AS regular_sales_units,
        SUM(regular_sales_transaction_count) AS regular_sales_transaction_count,
        SUM(promotion_return_value) AS promotion_return_value,
        SUM(promotion_return_units) AS promotion_return_units,
        SUM(promotion_return_transaction_count) AS promotion_return_transaction_count,
        SUM(clearance_return_value) AS clearance_return_value,
        SUM(clearance_return_units) AS clearance_return_units,
        SUM(clearance_return_transaction_count) AS clearance_return_transaction_count,
        SUM(regular_return_value) AS regular_return_value,
        SUM(regular_return_units) AS regular_return_units,
        SUM(regular_return_transaction_count) AS regular_return_transaction_count,
        SUM(promotion_exchange_value) AS promotion_exchange_value,
        SUM(promotion_exchange_units) AS promotion_exchange_units,
        SUM(promotion_exchange_transaction_count) AS promotion_exchange_transaction_count,
        SUM(clearance_exchange_value) AS clearance_exchange_value,
        SUM(clearance_exchange_units) AS clearance_exchange_units,
        SUM(clearance_exchange_transaction_count) AS clearance_exchange_transaction_count,
        SUM(regular_exchange_value) AS regular_exchange_value,
        SUM(regular_exchange_units) AS regular_exchange_units,
        SUM(regular_exchange_transaction_count) AS regular_exchange_transaction_count
    FROM SLS_TNDR_TY
    GROUP BY 1, 2, 3
),
-- CTE 17: VOL_SLS_CLEAR_THY
-- Purpose: To find the first date an item was sold on clearance at a specific location.
VOL_SLS_CLEAR_THY AS (
    SELECT
        item_wid,
        loc_wid,
        MIN(business_day_id) AS clearance_1st_date
    FROM VOL_SLS_TXN_TY_DATA
    WHERE sales_type_cd = 'SALE' AND updated_sales_type_cd = 'SALE' AND retail_type = 'C'
    GROUP BY 1, 2
),
-- CTE 18: VOL_SLS_1_THY
-- Purpose: To find the first date an item was ever sold at a specific location.
VOL_SLS_1_THY AS (
    SELECT
        item_wid,
        loc_wid,
        MIN(business_day_id) AS sales_1st_date
    FROM VOL_SLS_TXN_TY_DATA
    GROUP BY 1, 2
)
-- Final Select Statement
-- Purpose: To join the aggregated sales data with the first-sale and first-clearance dates,
-- and present the final, fully aggregated results.
SELECT
    SUB.business_day_id AS business_date,
    SUB.loc_wid AS loc_wid,
    -- SUB.loc_wid AS location_wid, -- Waiting for design change
    SUB.item_wid AS item_wid,
    -- SUB.item_wid AS item_wid, -- Waiting for design change
    setbit((0(INTEGER)),0,1) AS fct_src_map,
    MIN(SL.sales_1st_date) AS sales_1st_date,
    MIN(CLEAR.clearance_1st_date) AS clearance_1st_date,
    SUM(sales_amt) AS sales_value,
    SUM(sales_units) AS sales_units,
    SUM(sales_transaction_count) AS sales_transaction_count,
    SUM(return_amt) AS return_value,
    SUM(return_units) AS return_units,
    SUM(return_transaction_count) AS return_transaction_count,
    SUM(exchange_value) AS exchange_value,
    SUM(exchange_units) AS exchange_units,
    SUM(exchange_transaction_count) AS exchange_transaction_count,
    SUM(emp_discount_exchange_value) AS emp_discount_exchange_value,
    SUM(emp_discount_exchange_units) AS emp_discount_exchange_units,
    SUM(emp_discount_exchange_transaction_count) AS emp_discount_exchange_transaction_count,
    SUM(emp_discount_sales_value) AS emp_discount_sales_value,
    SUM(emp_discount_sales_units) AS emp_discount_sales_units,
    SUM(emp_discount_sales_transaction_count) AS emp_discount_sales_transaction_count,
    SUM(emp_discount_return_value) AS emp_discount_return_value,
    SUM(emp_discount_return_units) AS emp_discount_return_units,
    SUM(emp_discount_return_transaction_count) AS emp_discount_return_transaction_count,
    SUM(sales_tax_amt) AS sales_tax_amt,
    SUM(return_tax_amt) AS return_tax_amt,
    SUM(void_transaction_count) AS void_transaction_count,
    SUM(post_void_transaction_count) AS post_void_transaction_count,
    SUM(other_transaction_count) AS other_transaction_count,
    SUM(sales_manual_markup_amt) AS sales_manual_markup_amt,
    SUM(sales_manual_markdown_amt) AS sales_manual_markdown_amt,
    SUM(return_manual_markdown_amt) AS return_manual_markdown_amt,
    SUM(sales_manual_count) AS sales_manual_count,
    SUM(sales_scan_count) AS sales_scan_count,
    SUM(exchanges_with_reciepts) AS exchanges_with_reciepts,
    SUM(exchanges_without_reciepts) AS exchanges_without_reciepts,
    SUM(returns_with_reciepts) AS returns_with_reciepts,
    SUM(returns_without_reciepts) AS returns_without_reciepts,
    SUM(no_sale_transaction_count) AS no_sale_transaction_count,
    SUM(markdown_sales) AS markdown_sales,
    SUM(cash_sales_value) AS cash_sales_value,
    SUM(cash_sales_units) AS cash_sales_units,
    SUM(cash_sales_transaction_count) AS cash_sales_transaction_count,
    SUM(card_sales_value) AS card_sales_value,
    SUM(card_sales_units) AS card_sales_units,
    SUM(card_sales_transaction_count) AS card_sales_transaction_count,
    SUM(gift_sales_value) AS gift_sales_value,
    SUM(gift_sales_units) AS gift_sales_units,
    SUM(gift_sales_transaction_count) AS gift_sales_transaction_count,
    SUM(others_sales_value) AS others_sales_value,
    SUM(others_sales_units) AS others_sales_units,
    SUM(others_sales_transaction_count) AS others_sales_transaction_count,
    SUM(cash_return_value) AS cash_return_value,
    SUM(cash_return_units) AS cash_return_units,
    SUM(cash_return_transaction_count) AS cash_return_transaction_count,
    SUM(card_return_value) AS card_return_value,
    SUM(card_return_units) AS card_return_units,
    SUM(card_return_transaction_count) AS card_return_transaction_count,
    SUM(gift_return_value) AS gift_return_value,
    SUM(gift_return_units) AS gift_return_units,
    SUM(gift_return_transaction_count) AS gift_return_transaction_count,
    SUM(others_return_value) AS others_return_value,
    SUM(others_return_units) AS others_return_units,
    SUM(others_return_transaction_count) AS others_return_transaction_count,
    SUM(cash_exchange_value) AS cash_exchange_value,
    SUM(cash_exchange_units) AS cash_exchange_units,
    SUM(cash_exchange_transaction_count) AS cash_exchange_transaction_count,
    SUM(card_exchange_value) AS card_exchange_value,
    SUM(card_exchange_units) AS card_exchange_units,
    SUM(card_exchange_transaction_count) AS card_exchange_transaction_count,
    SUM(gift_exchange_value) AS gift_exchange_value,
    SUM(gift_exchange_units) AS gift_exchange_units,
    SUM(gift_exchange_transaction_count) AS gift_exchange_transaction_count,
    SUM(others_exchange_value) AS others_exchange_value,
    SUM(others_exchange_units) AS others_exchange_units,
    SUM(others_exchange_transaction_count) AS others_exchange_transaction_count,
 --   SUM(markdown_sales) AS markdown_sales,
    SUM(promotion_sales_value) AS promotion_sales_value,
    SUM(promotion_sales_units) AS promotion_sales_units,
    SUM(promotion_sales_transaction_count) AS promotion_sales_transaction_count,
    SUM(clearance_sales_value) AS clearance_sales_value,
    SUM(clearance_sales_units) AS clearance_sales_units,
    SUM(clearance_sales_transaction_count) AS clearance_sales_transaction_count,
    SUM(regular_sales_value) AS regular_sales_value,
    SUM(regular_sales_units) AS regular_sales_units,
    SUM(regular_sales_transaction_count) AS regular_sales_transaction_count,
    SUM(promotion_return_value) AS promotion_return_value,
    SUM(promotion_return_units) AS promotion_return_units,
    SUM(promotion_return_transaction_count) AS promotion_return_transaction_count,
    SUM(clearance_return_value) AS clearance_return_value,
    SUM(clearance_return_units) AS clearance_return_units,
    SUM(clearance_return_transaction_count) AS clearance_return_transaction_count,
    SUM(regular_return_value) AS regular_return_value,
    SUM(regular_return_units) AS regular_return_units,
    SUM(regular_return_transaction_count) AS regular_return_transaction_count,
    SUM(promotion_exchange_value) AS promotion_exchange_value,
    SUM(promotion_exchange_units) AS promotion_exchange_units,
    SUM(promotion_exchange_transaction_count) AS promotion_exchange_transaction_count,
    SUM(clearance_exchange_value) AS clearance_exchange_value,
    SUM(clearance_exchange_units) AS clearance_exchange_units,
    SUM(clearance_exchange_transaction_count) AS clearance_exchange_transaction_count,
    SUM(regular_exchange_value) AS regular_exchange_value,
    SUM(regular_exchange_units) AS regular_exchange_units,
    SUM(regular_exchange_transaction_count) AS regular_exchange_transaction_count
FROM VOL_SLS_TXN_THY AS SUB
LEFT OUTER JOIN VOL_SLS_1_THY AS SL
    ON SUB.item_wid = SL.item_wid
    AND SUB.loc_wid = SL.loc_wid
LEFT OUTER JOIN VOL_SLS_CLEAR_THY AS CLEAR
    ON SUB.item_wid = CLEAR.item_wid
    AND SUB.loc_wid = CLEAR.loc_wid
GROUP BY 1, 2, 3;
;
.IF ERRORCODE <> 0 THEN .QUIT 101


/* End of step */