--.IF ERRORCODE <> 0 THEN .QUIT 101



/* Collect statistics for the table */
COLLECT STATISTICS INDEX(calendar_dt) ON DWT04T_TMP_ACC_FND.FND1010_DW_FND_DATE_DIM
;
-------------------------------------------------------------------------------------

-- EXECUTED SUCCESSFULLY
