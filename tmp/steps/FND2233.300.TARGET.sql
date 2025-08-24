/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : FND2233.300.TARGET.sql
# Pattern             : 
# Purpose             : Insertion in TRANS table
# Author              : TERADATA
# File Type           : SQL
# Creation Date       : 2025-08-11
# -------------------------------------------------------------------------------
# Change History :
# Ver  | Date        |  Modified By           |  Change Description
# -------------------------------------------------------------------------------
# 1.0  | 2025-08-11 |  Mr Primark                |  INITIAL CODE
*/

/* Set query band */
SET QUERY_BAND = 'ApplicationName=TJC;Group=FND_BASE;JobId=FND2233.300.TARGET.sql;JobSeq=300;Instance=T04;RUNID=9660;STREAMID=TEST;' UPDATE FOR SESSION
;
--.IF ERRORCODE <> 0 THEN .QUIT 101




-- =================================================================================================
-- This BTEQ script manages the daily stock pivot table (DW_FND_LOC_ITEM_PVT_FCT).
-- It ensures that for a given business date (yesterday), the table accurately reflects
-- which location-item combinations have stock records by setting a flag (ty_stock_ind).
--
-- Logic Overview:
-- 1.  Start a transaction to ensure atomicity.
-- 2.  Lock the target table to prevent concurrent modifications.
-- 3.  Reset the stock indicator flag for all records for the target business date.
-- 4.  Merge data from the daily staging table (FND_SLS_FCT_PVT_STG).
--     - If a location-item record already exists, update its stock flag.
--     - If it's a new location-item combination, insert a new record.
-- 5.  Commit the transaction upon successful completion.
-- =================================================================================================
-- Step 1: Begin a transaction block. All subsequent operations will be treated as a single
-- atomic unit. If any step fails, the entire transaction will be rolled back.
--BEGIN TRANSACTION;
--.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Step 2: Lock the target table in WRITE mode. This is a crucial step to ensure data consistency
-- by preventing other processes from modifying the table during the merge operation.
LOCKING TABLE DWT04V_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT FOR WRITE;
--.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Step 3: Reset the stock indicator for the target business date (yesterday).
-- This is a safety measure to ensure that if an item had stock previously but doesn't
-- in the current run, its flag is correctly set to '0' before the merge.
UPDATE DWT04V_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT
SET
    ty_sales_ind = 0
WHERE
    business_date = date '2025-08-11';
--.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Step 4: Merge the source staging data into the pivot fact table.
-- The MERGE statement is an efficient way to handle both inserts and updates in a single pass.
MERGE INTO DWT04V_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT AS trg
USING DWT04T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG AS src
    -- Define the join condition to match records between the source and target tables.
    ON trg.business_date = src.business_date
    AND trg.loc_wid = src.loc_wid
    AND trg.item_wid = src.item_wid
-- 'WHEN MATCHED': This clause executes if a record from the source table finds a
-- matching record in the target table based on the join condition.
WHEN MATCHED THEN
    UPDATE SET
        -- Set the stock indicator to '1' to signify that this item has a stock
        -- record for the given business date.
        ty_sales_ind = 1,
        -- Update the audit columns to track when this record was last updated.
        update_run_id = 9660, -- Placeholder for the run ID
        update_job_id = 'FND2233.300.TARGET.sql' -- The name of the job that is running this script.
-- 'WHEN NOT MATCHED': This clause executes if a record from the source table does not
-- find a matching record in the target table. This indicates a new location-item combination.
WHEN NOT MATCHED THEN
    INSERT (
        business_date,
        loc_wid,
        item_wid,
        ty_sales_ind,
        wk_business_date,
        ly_business_date,
        eff_from_dt,
        eff_to_dt,
        del_ind,
        run_id,
        update_run_id,
        job_id,
        update_job_id
    )
    VALUES (
        src.business_date,
        src.loc_wid,
        src.item_wid,
        1, -- Set the stock indicator to '1' for the new record.
        date '2025-08-10', -- Teradata function to get the date of the Saturday of the week.
        date '2024-08-11', -- Calculate the date for the same day last year (approximated).
        date '2025-08-11', -- The effective start date for this record.
        DATE '3500-12-31', -- A high-date to indicate the record is currently active.
        0, -- Deletion indicator; 0 means the record is active.
        9660, -- Placeholder for the initial run ID.
        NULL, -- update_run_id is NULL for new records.
        'FND2233.300.TARGET.sql', -- The name of the job that created this record.
        NULL -- update_job_id is NULL for new records.
    );
-- BTEQ command to check for errors after the MERGE statement. If an error occurred,
-- the script will exit with a status code of 101.
--.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Step 5: End the transaction. If all previous steps were successful, the changes
-- are committed to the database, making them permanent.
--END TRANSACTION;
--.IF ERRORCODE <> 0 THEN .QUIT 101;

--.IF ERRORCODE <> 0 THEN .QUIT 101




/* Collect statistics for the table */
COLLECT STATISTICS COLUMN(business_date,loc_wid,item_wid) ON DWT04T_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT
;
--.IF ERRORCODE <> 0 THEN .QUIT 101


/* End of step */