/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : FND2133.300.TARGET.sql
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




-- =================================================================================================
-- SCRIPT: Manages the daily stock pivot table (DW_FND_LOC_ITEM_PVT_FCT).
--
-- PURPOSE: This script updates the pivot table to indicate which location-item combinations
-- have stock for a given business date. It uses a staging table to efficiently
-- merge daily stock data, setting a 'ty_stock_ind' flag for items in stock.
--
-- LOGIC:
-- 1. Lock the target table to prevent conflicts.
-- 2. Reset the stock flag for the given week to handle items that are no longer in stock.
-- 3. Merge today's stock data, updating existing records and inserting new ones.
-- 4. Merge last year's stock data to update the 'ly_stock_ind' for historical comparison.
-- 5. All operations are performed within a single transaction to ensure atomicity.
-- =================================================================================================
-- Begin a transaction to ensure all operations are completed as a single atomic unit.
BEGIN TRANSACTION;
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Lock the target table to prevent other processes from modifying it during the update.
LOCKING TABLE DW${INSTANCE}V_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT FOR WRITE;
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Reset the stock indicator for the entire week before applying daily updates.
-- This ensures that items without new stock records are correctly flagged as out of stock.
UPDATE DW${INSTANCE}V_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT
SET
    ty_stock_ind = 0
WHERE
    business_date BETWEEN date '${WEEK_START_DT}' AND date '${WEEK_END_DT}';
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Merge daily stock data from the staging table into the main pivot table.
-- This handles both updates to existing location-item pairs and inserts for new ones.
MERGE INTO DW${INSTANCE}V_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT AS trg
USING DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_PVT_STG AS src
    -- Match records on business_date, location, and item.
    ON trg.business_date = src.business_date
    AND trg.loc_wid = src.loc_wid
    AND trg.item_wid = src.item_wid
-- If a matching record exists, update its stock flag and audit columns.
WHEN MATCHED THEN
    UPDATE SET
        ty_stock_ind = 1, -- Set flag to 1 to indicate stock for the day.
        update_run_id = ${RUNID},
        update_job_id = '${JOB}'
-- If no matching record exists, insert a new row for the new location-item combination.
WHEN NOT MATCHED THEN
    INSERT (
        business_date, loc_wid, item_wid, ty_stock_ind,
        ty_wk_business_date, ly_business_date, ly_wk_business_date, lw_business_date,
        eff_from_dt, eff_to_dt, del_ind,
        run_id, update_run_id, job_id, update_job_id
    )
    VALUES (
        src.business_date, src.loc_wid, src.item_wid, 1, -- New record, so set stock flag to 1.
        date '${WEEK_END_DT}', -- End of the current business week.
        date '${LY_CALENDAR_DT}', -- Corresponding date from the previous year.
        td_saturday(td_sunday(date '${WEEK_END_DT}')+1), -- End of the business week from the previous year.
        date '${WEEK_END_DT}' - 7, -- Corresponding date from the previous week.
        date '${EFF_FROM_DT}', -- Effective start date for the record.
        DATE '3500-12-31', -- High-date indicating the record is currently active.
        0, -- Deletion indicator; 0 means active.
        ${RUNID}, NULL, -- Initial run ID; update_run_id is NULL for new records.
        '${JOB}', NULL -- Initial job ID; update_job_id is NULL for new records.
    );
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Merge last year's stock data to populate the 'ly_stock_ind' flag.
-- This self-join allows for year-over-year stock comparison on the same record.
MERGE INTO DWT04V_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT AS trg
USING DWT04V_ACC_FND.DW_FND_LOC_ITEM_PVT_FCT AS src
    -- Match today's records with the corresponding records from last year.
    ON trg.business_date = date '${LDTK_DATE}' -- Today's date.
    AND src.business_date = date '${LY_CALENDAR_DT}' -- Corresponding date from last year.
    AND trg.loc_wid = src.loc_wid
    AND trg.item_wid = src.item_wid
-- If a match is found, update the 'ly_stock_ind' flag to indicate there was stock last year.
WHEN MATCHED THEN
    UPDATE SET
        ly_stock_ind = 1,
        update_run_id =${RUNID},
        update_job_id = '${JOB}'
-- If no match is found for today's date, insert a new record to capture last year's stock data.
WHEN NOT MATCHED THEN
    INSERT (
        business_date, loc_wid, item_wid, ly_stock_ind,
        ty_wk_business_date, ly_business_date, ly_wk_business_date, lw_business_date,
        eff_from_dt, eff_to_dt, del_ind,
        run_id, update_run_id, job_id, update_job_id
    )
    VALUES (
        date '${LDTK_DATE}', src.loc_wid, src.item_wid, 1, -- Set last year's stock flag to 1.
        date '${WEEK_END_DT}', -- End of the current business week.
        date '${LY_CALENDAR_DT}', -- Corresponding date from the previous year.
        td_saturday(td_sunday(date '${WEEK_END_DT}')+1), -- End of the business week from the previous year.
        date '${WEEK_END_DT}' - 7, -- Corresponding date from the previous week.
        date '${EFF_FROM_DT}', -- Effective start date for the record.
        DATE '3500-12-31', -- High-date indicating the record is currently active.
        0, -- Deletion indicator; 0 means active.
        ${RUNID}, NULL,
        '${JOB}', NULL
    );
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Commit the transaction to make all changes permanent.
END TRANSACTION;
.IF ERRORCODE <> 0 THEN .QUIT 101;
        ly_business_date,
        ly_wk_business_date,
        lw_business_date,
        eff_from_dt,
        eff_to_dt,
        del_ind,
        run_id,
        update_run_id,
        job_id,
        update_job_id
    )
    VALUES (
        date '${LDTK_DATE}',
       src.loc_wid,
        src.item_wid,
        1, -- Set the stock indicator to '1' for the new record.
        date '${WEEK_END_DT}', -- Teradata function to get the date of the Saturday of the week.
        date '${LY_CALENDAR_DT}', -- Calculate the date for the same day last year (approximated).
        td_saturday(td_sunday(date '${WEEK_END_DT}')+1), -- Last years end of business week
        date '${EFF_FROM_DT}', -- The effective start date for this record.
        date '${WEEK_END_DT}' - 7, -- Last weeks equivalent business date
        DATE '3500-12-31', -- A high-date to indicate the record is currently active.
        0, -- Deletion indicator; 0 means the record is active.
        ${RUNID}, -- Placeholder for the initial run ID.
        NULL, -- update_run_id is NULL for new records.
        '${JOB}', -- The name of the job that created this record.
        NULL -- update_job_id is NULL for new records.
    );
-- BTEQ command to check for errors after the MERGE statement. If an error occurred,
-- the script will exit with a status code of 101.
.IF ERRORCODE <> 0 THEN .QUIT 101;
-- Step 5: End the transaction. If all previous steps were successful, the changes
-- are committed to the database, making them permanent.
END TRANSACTION;
.IF ERRORCODE <> 0 THEN .QUIT 101;

.IF ERRORCODE <> 0 THEN .QUIT 101




/* Collect statistics for the table */
COLLECT STATISTICS COLUMN(business_date,loc_wid,item_wid) ON DW${INSTANCE}T_ACC_FND.DW_FND_AGG_DAILY_STOCK_FCT
;
.IF ERRORCODE <> 0 THEN .QUIT 101


/* End of step */