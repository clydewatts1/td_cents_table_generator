--.IF ERRORCODE <> 0 THEN .QUIT 101

/* Lock target table */
LOCKING DWT04T_ACC_FND.DW_FND_DATE_DIM FOR WRITE
;
-------------------------------------------------------------------------------------

-- EXECUTED SUCCESSFULLY
-- ROW COUNT: 0
