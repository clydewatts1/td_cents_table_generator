/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : FND1040.200.VALID.sql
# Pattern             : 
# Purpose             : Insertion in TRANS table
# Author              : TERADATA
# File Type           : SQL
# Creation Date       : 2025-08-19
# -------------------------------------------------------------------------------
# Change History :
# Ver  | Date        |  Modified By           |  Change Description
# -------------------------------------------------------------------------------
# 1.0  | 2025-08-19 |  Mr Primark                |  INITIAL CODE
*/

/* Set query band */
SET QUERY_BAND = 'ApplicationName=TJC;Group=FND_BASE;JobId=FND1040.200.VALID.sql;JobSeq=200;Instance=T04;RUNID=8601;STREAMID=TEST;' UPDATE FOR SESSION
;
--.IF ERRORCODE <> 0 THEN .QUIT 101





DELETE FROM DWT04T_TMP_ACC_FND.FND1040_VALID
;

--.IF ERRORCODE <> 0 THEN .QUIT 101

/*----------------------------------------------------------------------------

# Insert into target table
# This step inserts data into the target table from the source table.
# It uses a left outer join to detect changes and only inserts records that are new or have changed.
# The control columns are set to indicate the effective date range and deletion status.
# The run_id and job_id are also set for tracking purposes.

-------------------------------------------------------------------------------*/

INSERT INTO DWT04T_TMP_ACC_FND.FND1040_VALID
(
    styl_wid, 
    item_sbclas_wid, 
    /* Control Columnts */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
)

SELECT
    TRANS.styl_wid, 
    TRANS.item_sbclas_wid, 
    /* Control Columnts */
    date '2025-08-20' AS eff_from_dt,
    DATE '3500-12-31' AS eff_to_dt,
    0 AS del_ind,
    8601 AS run_id,
    NULL AS update_run_id,
    'FND1040.200.VALID.sql' AS job_id,
    NULL AS update_job_id
FROM DWT04T_TMP_ACC_FND.FND1040_TRANS AS TRANS
LEFT OUTER JOIN DWT04T_ACC_FND.DW_FND_STYL_SBCLASS_XREF AS TRG
ON  TRG.eff_to_dt = DATE '3500-12-31' /* Current effective record */
AND TRG.del_ind = 0 /* Not deleted */
AND TRG.styl_wid = TRANS.styl_wid 
    
WHERE (  /* Change detection */ 
    TRG.del_ind IS NULL /* No existing or a deleted */
OR TRG.item_sbclas_wid <> TRANS.item_sbclas_wid 
OR (TRG.item_sbclas_wid IS NULL AND TRANS.item_sbclas_wid IS NOT NULL)
OR (TRG.item_sbclas_wid IS NOT NULL AND TRANS.item_sbclas_wid IS NULL)
    
) /* end of change detection */

;

--.IF ERRORCODE <> 0 THEN .QUIT 101

/*------------------------------------------------------------------------------------------

# Insert deleted records into the valid table 
# these are records which are not present in source / transformation table 

-------------------------------------------------------------------------------------------*/

INSERT INTO DWT04T_TMP_ACC_FND.FND1040_VALID
(
    styl_wid, 
    item_sbclas_wid, 
    /* Control Columnts */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
)

SELECT
    TRG.styl_wid, 
    TRG.item_sbclas_wid, 
    /* Control Columnts */
    date '2025-08-20' AS eff_from_dt,
    DATE '3500-12-31' AS eff_to_dt,
    1 AS del_ind, /* Mark as deleted */
    8601 AS run_id,
    NULL AS update_run_id,
    'FND1040.200.VALID.sql' AS job_id,
    NULL AS update_job_id
FROM DWT04T_ACC_FND.DW_FND_STYL_SBCLASS_XREF AS TRG
LEFT OUTER JOIN DWT04T_TMP_ACC_FND.FND1040_TRANS AS TRANS
ON
TRG.styl_wid = TRANS.styl_wid 
    
WHERE TRG.eff_to_dt = DATE '3500-12-31' /* Current effective record */
AND TRANS.styl_wid is NULL /* No existing or a deleted */
;

--.IF ERRORCODE <> 0 THEN .QUIT 101



/* Collect statistics for the table */
COLLECT STATISTICS COLUMN(styl_wid) ON DWT04T_TMP_ACC_FND.FND1040_VALID
;
--.IF ERRORCODE <> 0 THEN .QUIT 101


/* End of step */