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
# Build Time 14:07:28
# 1.0  | 2025-07-20 | TERADATA               |  INITIAL CODE
*/


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
    ny_year_num
)

;
.IF ERRORCODE <> 0 THEN .QUIT 101



/* Collect statistics for the table */
COLLECT STATISTICS INDEX(calendar_dt) ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM
;
.IF ERRORCODE <> 0 THEN .QUIT 101


/* End of step */