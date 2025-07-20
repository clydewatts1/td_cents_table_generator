--.IF ERRORCODE <> 0 THEN .QUIT 101




/* Collect statistics for the table */
COLLECT STATISTICS INDEX(calendar_dt) ON DWT04T_ACC_FND.DW_FND_DATE_DIM
;
-------------------------------------------------------------------------------------

-- EXECUTED SUCCESSFULLY
-- ROW COUNT: 2
