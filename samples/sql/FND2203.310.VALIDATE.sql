-- =============================================================================
-- Script Name: Single Business Date Check
-- Description: This script verifies that the staging table
--              'DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG' contains records
--              for only one 'business_date'. The process should fail if
--              data for multiple dates is present.
-- =============================================================================
-- Use a Common Table Expression (CTE) to count the number of distinct dates.
WITH TST AS (
    SELECT
        COUNT(DISTINCT business_date) AS business_date_count
    FROM
        DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG
    HAVING
        -- This condition is the core of the test. The query will only
        -- return a row if there is more than one distinct business_date.
        business_date_count > 1
)
-- This SELECT statement will only run and return a row if the CTE above
-- found more than one business_date.
SELECT
    'Only One Business Date check failed' AS Error_Desc,
    TST.* -- Select all columns from the CTE
FROM
    TST;
-- =============================================================================
-- BTEQ Control Logic (Teradata Specific)
-- =============================================================================
-- Check the error code from the last SQL statement.
-- If ERRORCODE is not 0, it means the SELECT statement failed for some reason.
.IF ERRORCODE <> 0 THEN .QUIT 101
-- Check the activity count from the last SQL statement.
-- If ACTIVITYCOUNT is not 0, it means our query found multiple business dates
-- and returned a row. The script then quits with a specific error code to
-- signal this data quality failure.
.IF ACTIVITYCOUNT <> 0 THEN .QUIT 103 -- Using 103 to differentiate from previous check