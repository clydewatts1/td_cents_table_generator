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
    styl_sbclass_vers_num, 
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
    TRANS.styl_sbclass_vers_num, 
    /* Control Columnts */
    date '2025-07-24' AS eff_from_dt,
    DATE '3500-12-31' AS eff_to_dt,
    0 AS del_ind,
    8625 AS run_id,
    NULL AS update_run_id,
    'FND1040.200.VALID.sql' AS job_id,
    NULL AS update_job_id
FROM DWT04T_TMP_ACC_FND.FND1040_TRANS AS TRANS
LEFT OUTER JOIN DWT04T_ACC_FND.FND_RECLASFCN_STYL_SBCLASS_XREF AS TRG
ON  TRG.eff_to_dt = DATE '3500-12-31' /* Current effective record */
AND TRG.del_ind = 0 /* Not deleted */
AND TRG.styl_wid = TRANS.styl_wid 
    
WHERE (  /* Change detection */ 
    TRG.del_ind IS NULL /* No existing or a deleted */
OR TRG.item_sbclas_wid <> TRANS.item_sbclas_wid 
OR (TRG.item_sbclas_wid IS NULL AND TRANS.item_sbclas_wid IS NOT NULL)
OR (TRG.item_sbclas_wid IS NOT NULL AND TRANS.item_sbclas_wid IS NULL)
    
OR TRG.styl_sbclass_vers_num <> TRANS.styl_sbclass_vers_num 
OR (TRG.styl_sbclass_vers_num IS NULL AND TRANS.styl_sbclass_vers_num IS NOT NULL)
OR (TRG.styl_sbclass_vers_num IS NOT NULL AND TRANS.styl_sbclass_vers_num IS NULL)
    
) /* end of change detection */

;
-------------------------------------------------------------------------------------

-- ERROR: [Version 20.0.0.32] [Session 862950] [Teradata Database] [Error 2644] No more room in database DWT04T_TMP_ACC_FND.
 at gosqldriver/teradatasql.formatError ErrorUtil.go:85
 at gosqldriver/teradatasql.(*teradataConnection).formatDatabaseError ErrorUtil.go:223
 at gosqldriver/teradatasql.(*teradataConnection).makeChainedDatabaseError ErrorUtil.go:239
 at gosqldriver/teradatasql.(*teradataConnection).processErrorParcel TeradataConnection.go:816
 at gosqldriver/teradatasql.(*TeradataRows).processResponseBundle TeradataRows.go:2494
 at gosqldriver/teradatasql.(*TeradataRows).executeSQLRequest TeradataRows.go:970
 at gosqldriver/teradatasql.newTeradataRows TeradataRows.go:791
 at gosqldriver/teradatasql.(*teradataStatement).QueryContext TeradataStatement.go:122
 at gosqldriver/teradatasql.(*teradataConnection).QueryContext TeradataConnection.go:1335
 at database/sql.ctxDriverQuery ctxutil.go:48
 at database/sql.(*DB).queryDC.func1 sql.go:1786
 at database/sql.withLock sql.go:3574
 at database/sql.(*DB).queryDC sql.go:1781
 at database/sql.(*Conn).QueryContext sql.go:2037
 at main.createRows goside.go:1080
 at main.goCreateRows goside.go:959
 at _cgoexp_ff5e33a08e40_goCreateRows _cgo_gotypes.go:417
 at runtime.cgocallbackg1 cgocall.go:446
 at runtime.cgocallbackg cgocall.go:350
 at runtime.cgocallback asm_amd64.s:1084
 at runtime.goexit asm_amd64.s:1700
