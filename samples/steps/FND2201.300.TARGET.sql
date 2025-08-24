/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : FND2201.300.TARGET.sql
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



DELETE FROM DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG
;

.IF ERRORCODE <> 0 THEN .QUIT 101





/* Collect statistics for the table */
COLLECT STATISTICS COLUMN(business_date,loc_wid,item_wid) ON DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG
;
.IF ERRORCODE <> 0 THEN .QUIT 101


/* End of step */