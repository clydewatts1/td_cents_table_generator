/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : FND1040.300.TARGET.sql
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
SET QUERY_BAND = 'ApplicationName=TJC;Group=FND_BASE;JobId=${JOB};JobSeq=300;Instance=${INSTANCE};RUNID=${RUNID};STREAMID=${STREAMID};' UPDATE FOR SESSION
;
.IF ERRORCODE <> 0 THEN .QUIT 101




BEGIN TRANSACTION
;
.IF ERRORCODE <> 0 THEN .QUIT 101

/* Lock target table */
LOCKING DW${INSTANCE}V_ACC_FND.DW_FND_STYL_SBCLASS_XREF FOR WRITE
;
.IF ERRORCODE <> 0 THEN .QUIT 101

/* Update the target table by closing of the previous records */
UPDATE TRG FROM  DW${INSTANCE}V_ACC_FND.DW_FND_STYL_SBCLASS_XREF AS TRG
                ,DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID AS SRC
SET eff_to_dt = SRC.eff_from_dt
  , update_job_id = SRC.job_id
  , update_run_id = SRC.run_id
WHERE TRG.eff_to_dt = '3500-12-31'
AND TRG.styl_wid = SRC.styl_wid 
    
;
.IF ERRORCODE <> 0 THEN .QUIT 101

/* INSERT INTO target table */
INSERT INTO DW${INSTANCE}V_ACC_FND.DW_FND_STYL_SBCLASS_XREF
(
    styl_wid, 
    item_sbclas_wid, 
    /* Control Columns */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
)

SELECT
    SRC.styl_wid AS styl_wid, 
    SRC.item_sbclas_wid AS item_sbclas_wid, 
    SRC.eff_from_dt,
    SRC.eff_to_dt,
    SRC.del_ind,
    SRC.run_id,
    SRC.update_run_id,
    SRC.job_id,
    SRC.update_job_id
FROM DW${INSTANCE}T_TMP_ACC_FND.FND1040_VALID AS SRC
;
.IF ERRORCODE <> 0 THEN .QUIT 101

/* End of INSERT statement */


END TRANSACTION
;
.IF ERRORCODE <> 0 THEN .QUIT 101