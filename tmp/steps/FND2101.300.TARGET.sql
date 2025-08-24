/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : FND2101.300.TARGET.sql
# Pattern             : 
# Purpose             : Insertion in TRANS table
# Author              : TERADATA
# File Type           : SQL
# Creation Date       : 2025-08-14
# -------------------------------------------------------------------------------
# Change History :
# Ver  | Date        |  Modified By           |  Change Description
# -------------------------------------------------------------------------------
# 1.0  | 2025-08-14 |  Mr Primark                |  INITIAL CODE
*/

/* Set query band */
SET QUERY_BAND = 'ApplicationName=TJC;Group=FND_BASE;JobId=FND2101.300.TARGET.sql;JobSeq=300;Instance=T04;RUNID=3323;STREAMID=TEST;' UPDATE FOR SESSION
;
--.IF ERRORCODE <> 0 THEN .QUIT 101



DELETE FROM DWT04T_TMP_ACC_FND.FND_STK_FCT_PVT_STG
;

--.IF ERRORCODE <> 0 THEN .QUIT 101




/* End of step */