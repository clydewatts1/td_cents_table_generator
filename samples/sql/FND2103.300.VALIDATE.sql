-- =============================================================================
-- Script Name: Duplicate Primary Key Check
-- Description: This script checks for duplicate records in the staging table
--              'DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG' based on the
--              composite primary key (business_date, loc_wid, item_wid).
--              It will exit with an error code if duplicates are found.
-- =============================================================================
-- Use a Common Table Expression (CTE) to identify duplicate records.
WITH TST AS (
    SELECT
        business_date,
        loc_wid,
        item_wid,
        COUNT(*) AS dupl_count
    FROM
        DW${INSTANCE}T_TMP_ACC_FND.FND_STK_FCT_01_FCT_STG
    GROUP BY
        -- Group by the columns that form the unique key to find duplicates.
        business_date,
        loc_wid,
        item_wid
    HAVING
        -- Filter for groups with more than one record, which indicates a duplicate.
        dupl_count > 1
)
-- Select the top 10 duplicate records to display as a sample.
SELECT TOP 10
    'Duplicate count check' AS Error_Desc,
    TST.* -- Select all columns from the CTE
FROM
    TST
ORDER BY
    -- Order by loc_wid to make the output consistent.
    dupl_count DESC
;
-- =============================================================================
-- BTEQ Control Logic (Teradata Specific)
-- =============================================================================
-- Check the error code from the last SQL statement.
-- If ERRORCODE is not 0, it means the SELECT statement failed for some reason.
.IF ERRORCODE <> 0 THEN .QUIT 101
-- Check the activity count from the last SQL statement.
-- If ACTIVITYCOUNT is not 0, it means our query found and returned duplicate rows.
-- The script then quits with a specific error code (102) to signal this failure.
.IF ACTIVITYCOUNT <> 0 THEN .QUIT 102