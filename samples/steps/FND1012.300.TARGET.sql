/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : OLR1001.100.TRANS.sql
# Pattern             : 
# Purpose             : Insertion in TRANS table
# Author              : TERADATA
# File Type           : SQL
# Creation Date       : 2025-07-20
# -------------------------------------------------------------------------------
# Change History :
# Ver  | Date        |  Modified By           |  Change Description
# -------------------------------------------------------------------------------
# Automatically generated by 10cents_table_generator
# 1.0  | 2025-07-20 | TERADATA               |  INITIAL CODE
# Build Time 14:51:29
# 1.0  | 2025-07-20 | TERADATA               |  INITIAL CODE
*/

BEGIN TRANSACTION
;
.IF ERRORCODE <> 0 THEN .QUIT 101

/* Lock target table */
LOCKING DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM FOR WRITE
;
.IF ERRORCODE <> 0 THEN .QUIT 101


DELETE FROM DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM
;

.IF ERRORCODE <> 0 THEN .QUIT 101

INSERT INTO DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM
(
    calendar_dt, 
    year_start_dt, 
    year_end_dt, 
    period_start_dt, 
    period_end_dt, 
    week_start_dt, 
    week_end_dt, 
    day_of_year_num, 
    day_of_period_num, 
    day_of_week_num, 
    week_of_year_num, 
    week_of_period_num, 
    period_of_year_num, 
    year_week, 
    year_period, 
    year_num, 
    season_code, 
    season_name, 
    season_description, 
    season_map, 
    season_wid, 
    ly_calendar_dt, 
    ly_year_start_dt, 
    ly_year_end_dt, 
    ly_period_start_dt, 
    ly_period_end_dt, 
    ly_week_start_dt, 
    ly_week_end_dt, 
    ly_day_of_year_num, 
    ly_day_of_period_num, 
    ly_day_of_week_num, 
    ly_week_of_year_num, 
    ly_week_of_period_num, 
    ly_period_of_year_num, 
    ly_year_week, 
    ly_year_period, 
    ly_year_num, 
    lly_calendar_dt, 
    lly_year_start_dt, 
    lly_year_end_dt, 
    lly_period_start_dt, 
    lly_period_end_dt, 
    lly_week_start_dt, 
    lly_week_end_dt, 
    lly_day_of_year_num, 
    lly_day_of_period_num, 
    lly_day_of_week_num, 
    lly_week_of_year_num, 
    lly_week_of_period_num, 
    lly_period_of_year_num, 
    lly_year_week, 
    lly_year_period, 
    lly_year_num, 
    llly_calendar_dt, 
    llly_year_start_dt, 
    llly_year_end_dt, 
    llly_period_start_dt, 
    llly_period_end_dt, 
    llly_week_start_dt, 
    llly_week_end_dt, 
    llly_day_of_year_num, 
    llly_day_of_period_num, 
    llly_day_of_week_num, 
    llly_week_of_year_num, 
    llly_week_of_period_num, 
    llly_period_of_year_num, 
    llly_year_week, 
    llly_year_period, 
    llly_year_num, 
    ny_calendar_dt, 
    ny_year_start_dt, 
    ny_year_end_dt, 
    ny_period_start_dt, 
    ny_period_end_dt, 
    ny_week_start_dt, 
    ny_week_end_dt, 
    ny_day_of_year_num, 
    ny_day_of_period_num, 
    ny_day_of_week_num, 
    ny_week_of_year_num, 
    ny_week_of_period_num, 
    ny_period_of_year_num, 
    ny_year_week, 
    ny_year_period, 
    ny_year_num, 
    /* Control Columnts */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
)
-- This query selects all columns from a pre-built, denormalized date dimension staging table.
-- The table contains a wide range of calendar and date-related attributes for the current
-- year (TY), last year (LY), two years prior (LLY), three years prior (LLLY), and next year (NY).
SELECT
    -- Current calendar date and its attributes
    STG.calendar_dt,
    STG.year_start_dt,
    STG.year_end_dt,
    STG.period_start_dt,
    STG.period_end_dt,
    STG.week_start_dt,
    STG.week_end_dt,
    STG.day_of_year_num,
    STG.day_of_period_num,
    STG.day_of_week_num,
    STG.week_of_year_num,
    STG.week_of_period_num,
    STG.period_of_year_num,
    STG.year_week,
    STG.year_period,
    STG.year_num,
    -- Seasonal attributes
    STG.season_code,
    STG.season_name,
    STG.season_description,
    STG.season_map,
    STG.season_wid,
    -- Last Year (LY) attributes
    STG.ly_calendar_dt,
    STG.ly_year_start_dt,
    STG.ly_year_end_dt,
    STG.ly_period_start_dt,
    STG.ly_period_end_dt,
    STG.ly_week_start_dt,
    STG.ly_week_end_dt,
    STG.ly_day_of_year_num,
    STG.ly_day_of_period_num,
    STG.ly_day_of_week_num,
    STG.ly_week_of_year_num,
    STG.ly_week_of_period_num,
    STG.ly_period_of_year_num,
    STG.ly_year_week,
    STG.ly_year_period,
    STG.ly_year_num,
    -- Last Last Year (LLY) attributes
    STG.lly_calendar_dt,
    STG.lly_year_start_dt,
    STG.lly_year_end_dt,
    STG.lly_period_start_dt,
    STG.lly_period_end_dt,
    STG.lly_week_start_dt,
    STG.lly_week_end_dt,
    STG.lly_day_of_year_num,
    STG.lly_day_of_period_num,
    STG.lly_day_of_week_num,
    STG.lly_week_of_year_num,
    STG.lly_week_of_period_num,
    STG.lly_period_of_year_num,
    STG.lly_year_week,
    STG.lly_year_period,
    STG.lly_year_num,
    -- Last Last Last Year (LLLY) attributes
    STG.llly_calendar_dt,
    STG.llly_year_start_dt,
    STG.llly_year_end_dt,
    STG.llly_period_start_dt,
    STG.llly_period_end_dt,
    STG.llly_week_start_dt,
    STG.llly_week_end_dt,
    STG.llly_day_of_year_num,
    STG.llly_day_of_period_num,
    STG.llly_day_of_week_num,
    STG.llly_week_of_year_num,
    STG.llly_week_of_period_num,
    STG.llly_period_of_year_num,
    STG.llly_year_week,
    STG.llly_year_period,
    STG.llly_year_num,
    -- Next Year (NY) attributes
    STG.ny_calendar_dt,
    STG.ny_year_start_dt,
    STG.ny_year_end_dt,
    STG.ny_period_start_dt,
    STG.ny_period_end_dt,
    STG.ny_week_start_dt,
    STG.ny_week_end_dt,
    STG.ny_day_of_year_num,
    STG.ny_day_of_period_num,
    STG.ny_day_of_week_num,
    STG.ny_week_of_year_num,
    STG.ny_week_of_period_num,
    STG.ny_period_of_year_num,
    STG.ny_year_week,
    STG.ny_year_period,
    STG.ny_year_num,
    /* Control Columns */
    date '${EFF_TO_DATE}' AS eff_from_dt,
    date '3500-12-31' AS eff_to_dt,
    0 AS del_ind,
    ${RUNID} AS run_id,
    NULL AS update_run_id,
    '$JOB' AS job_id,
    NULL AS update_job_id
FROM
    -- Source is the temporary/staging date dimension table
    DW${INSTANCE}T_TMP_ACC_FND.FND1010_DW_FND_DATE_DIM AS STG
;
.IF ERRORCODE <> 0 THEN .QUIT 101

/* End of INSERT statement */
END TRANSACTION
;
.IF ERRORCODE <> 0 THEN .QUIT 101




/* Collect statistics for the table */
COLLECT STATISTICS INDEX(calendar_dt) ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM
;
.IF ERRORCODE <> 0 THEN .QUIT 101


/* End of step */