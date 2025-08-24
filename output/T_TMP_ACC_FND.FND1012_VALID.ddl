
/*----------------------------------------------------------------------
* FileName: T_TMP_ACC_FND.FND1012_VALID.ddl
* Project: Primark Reclassification Foundation
* Database: DW${INSTANCE}T_TMP_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for FND1012_VALID = */
CREATE MULTISET TABLE DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID
    (
    calendar_dt DATE NOT NULL   ,
    year_start_dt DATE NOT NULL   ,
    year_end_dt DATE NOT NULL   ,
    period_start_dt DATE NOT NULL   ,
    period_end_dt DATE NOT NULL   ,
    week_start_dt DATE NOT NULL   ,
    week_end_dt DATE NOT NULL   ,
    day_of_year_num SMALLINT NOT NULL   ,
    day_of_period_num SMALLINT NOT NULL   ,
    day_of_week_num BYTEINT NOT NULL   ,
    week_of_year_num BYTEINT NOT NULL   ,
    week_of_period_num BYTEINT NOT NULL   ,
    period_of_year_num BYTEINT NOT NULL   ,
    year_week INTEGER NOT NULL   ,
    year_period INTEGER NOT NULL   ,
    year_num INTEGER NOT NULL   ,
    season_code INTEGER    ,
    season_name VARCHAR(6)    ,
    season_description VARCHAR(20)    ,
    season_map BYTE(14)    ,
    season_wid SMALLINT    ,
    ly_calendar_dt DATE    ,
    ly_year_start_dt DATE    ,
    ly_year_end_dt DATE    ,
    ly_period_start_dt DATE    ,
    ly_period_end_dt DATE    ,
    ly_week_start_dt DATE    ,
    ly_week_end_dt DATE    ,
    ly_day_of_year_num SMALLINT    ,
    ly_day_of_period_num SMALLINT    ,
    ly_day_of_week_num SMALLINT    ,
    ly_week_of_year_num BIGINT    ,
    ly_week_of_period_num BIGINT    ,
    ly_period_of_year_num BIGINT    ,
    ly_year_week INTEGER    ,
    ly_year_period INTEGER    ,
    ly_year_num INTEGER    ,
    lly_calendar_dt DATE    ,
    lly_year_start_dt DATE    ,
    lly_year_end_dt DATE    ,
    lly_period_start_dt DATE    ,
    lly_period_end_dt DATE    ,
    lly_week_start_dt DATE    ,
    lly_week_end_dt DATE    ,
    lly_day_of_year_num SMALLINT    ,
    lly_day_of_period_num SMALLINT    ,
    lly_day_of_week_num SMALLINT    ,
    lly_week_of_year_num BIGINT    ,
    lly_week_of_period_num BIGINT    ,
    lly_period_of_year_num BIGINT    ,
    lly_year_week INTEGER    ,
    lly_year_period INTEGER    ,
    lly_year_num INTEGER    ,
    llly_calendar_dt DATE    ,
    llly_year_start_dt DATE    ,
    llly_year_end_dt DATE    ,
    llly_period_start_dt DATE    ,
    llly_period_end_dt DATE    ,
    llly_week_start_dt DATE    ,
    llly_week_end_dt DATE    ,
    llly_day_of_year_num SMALLINT    ,
    llly_day_of_period_num SMALLINT    ,
    llly_day_of_week_num SMALLINT    ,
    llly_week_of_year_num BIGINT    ,
    llly_week_of_period_num BIGINT    ,
    llly_period_of_year_num BIGINT    ,
    llly_year_week INTEGER    ,
    llly_year_period INTEGER    ,
    llly_year_num INTEGER    ,
    ny_calendar_dt DATE    ,
    ny_year_start_dt DATE    ,
    ny_year_end_dt DATE    ,
    ny_period_start_dt DATE    ,
    ny_period_end_dt DATE    ,
    ny_week_start_dt DATE    ,
    ny_week_end_dt DATE    ,
    ny_day_of_year_num SMALLINT    ,
    ny_day_of_period_num SMALLINT    ,
    ny_day_of_week_num SMALLINT    ,
    ny_week_of_year_num BIGINT    ,
    ny_week_of_period_num BIGINT    ,
    ny_period_of_year_num BIGINT    ,
    ny_year_week INTEGER    ,
    ny_year_period INTEGER    ,
    ny_year_num INTEGER    ,
    ty_cstm_cal_dy_wid BIGINT    ,
    ty_cstm_cal_wk_wid BIGINT    ,
    ty_cstm_cal_prd_wid BIGINT    ,
    ty_cstm_cal_yr_wid BIGINT    ,
    ly_cstm_cal_dy_wid BIGINT    ,
    ly_cstm_cal_wk_wid BIGINT    ,
    ly_cstm_cal_prd_wid BIGINT    ,
    ly_cstm_cal_yr_wid BIGINT    ,
    lly_cstm_cal_dy_wid BIGINT    ,
    lly_cstm_cal_wk_wid BIGINT    ,
    lly_cstm_cal_prd_wid BIGINT    ,
    lly_cstm_cal_yr_wid BIGINT    ,
    llly_cstm_cal_dy_wid BIGINT    ,
    llly_cstm_cal_wk_wid BIGINT    ,
    llly_cstm_cal_prd_wid BIGINT    ,
    llly_cstm_cal_yr_wid BIGINT    ,
    ny_cstm_cal_dy_wid BIGINT    ,
    ny_cstm_cal_wk_wid BIGINT    ,
    ny_cstm_cal_prd_wid BIGINT    ,
    ny_cstm_cal_yr_wid BIGINT    ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(16) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(16) COMPRESS(NULL)
    )
    PRIMARY INDEX(calendar_dt)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.calendar_dt AS 'primary key on table'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.year_start_dt AS 'primark year start date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.year_end_dt AS 'primark year end date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.period_start_dt AS 'primark period start date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.period_end_dt AS 'primark period end date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.week_start_dt AS 'primark week start date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.week_end_dt AS 'primark week end date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.day_of_year_num AS 'day number within primark year , starting from 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.day_of_period_num AS 'day number within primark period , starting from 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.day_of_week_num AS 'day number within primark weak , starting from Sunday 1 till Saturday 7'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.week_of_year_num AS 'week number within primark year , starting from 1 till 52 , with a leep week 53'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.week_of_period_num AS 'week number within primark period, starting from 1 till 4, for a leap primark year 5'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.period_of_year_num AS 'period within primark year starting from 1'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.year_week AS 'primark year week in the form YYYYDD'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.year_period AS 'primark year period in the form YYYYPP'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.year_num AS 'primark year number YYYY'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.season_code AS 'this is the season code for this date'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.season_name AS 'This is the name of the season in SSYYYY based on SS = AW or SS , YYYY - primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.season_description AS 'This is the season name in words SS AW = 2025 Autumn Winter'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.season_map AS 'This is the bit mapping of the season based on the season_wid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.season_wid AS 'This is the season wid for the season'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_calendar_dt AS 'last year calendar date , aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_year_start_dt AS 'last year start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_year_end_dt AS 'last year end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_period_start_dt AS 'last year period start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_period_end_dt AS 'last year period end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_week_start_dt AS 'last year week start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_week_end_dt AS 'last year week end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_day_of_year_num AS 'last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_day_of_period_num AS 'last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_day_of_week_num AS 'last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_week_of_year_num AS 'last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_week_of_period_num AS 'last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_period_of_year_num AS 'last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_year_week AS 'last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_year_period AS 'last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_year_num AS 'last year number YYYY aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_calendar_dt AS 'last last year calendar date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_year_start_dt AS 'last last year start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_year_end_dt AS 'last last year end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_period_start_dt AS 'last last year period start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_period_end_dt AS 'last last year period end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_week_start_dt AS 'last last year week start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_week_end_dt AS 'last last year week end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_day_of_year_num AS 'last last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_day_of_period_num AS 'last last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_day_of_week_num AS 'last last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_week_of_year_num AS 'last last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_week_of_period_num AS 'last last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_period_of_year_num AS 'last last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_year_week AS 'last last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_year_period AS 'last last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_year_num AS 'last last year number YYYY aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_calendar_dt AS 'last last last year calendar date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_year_start_dt AS 'last last last year start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_year_end_dt AS 'last last last year end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_period_start_dt AS 'last last last year period start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_period_end_dt AS 'last last last year period end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_week_start_dt AS 'last last last year week start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_week_end_dt AS 'last last last year week end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_day_of_year_num AS 'last last last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_day_of_period_num AS 'last last last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_day_of_week_num AS 'last last last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_week_of_year_num AS 'last last last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_week_of_period_num AS 'last last last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_period_of_year_num AS 'last last last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_year_week AS 'last last last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_year_period AS 'last last last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_year_num AS 'last last last year number YYYY aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_calendar_dt AS 'next year calendar date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_year_start_dt AS 'next year start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_year_end_dt AS 'next year end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_period_start_dt AS 'next year period start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_period_end_dt AS 'next year period end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_week_start_dt AS 'next year week start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_week_end_dt AS 'next year week end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_day_of_year_num AS 'next year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_day_of_period_num AS 'next year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_day_of_week_num AS 'next year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_week_of_year_num AS 'next year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_week_of_period_num AS 'next year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_period_of_year_num AS 'next year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_year_week AS 'next year week in the form YYYYDD aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_year_period AS 'next year period in the form YYYYPP aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_year_num AS 'next year number YYYY aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ty_cstm_cal_dy_wid AS 'Surrogate key for the day in the current year (TY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ty_cstm_cal_wk_wid AS 'Surrogate key for the week in the current year (TY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ty_cstm_cal_prd_wid AS 'Surrogate key for the period (month) in the current year (TY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ty_cstm_cal_yr_wid AS 'Surrogate key for the year of the current year (TY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_cstm_cal_dy_wid AS 'Surrogate key for the corresponding day last year (LY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_cstm_cal_wk_wid AS 'Surrogate key for the corresponding week last year (LY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_cstm_cal_prd_wid AS 'Surrogate key for the corresponding period (month) last year (LY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ly_cstm_cal_yr_wid AS 'Surrogate key for the corresponding year last year (LY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_cstm_cal_dy_wid AS 'Surrogate key for the corresponding day two years ago (LLY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_cstm_cal_wk_wid AS 'Surrogate key for the corresponding week two years ago (LLY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_cstm_cal_prd_wid AS 'Surrogate key for the corresponding period (month) two years ago (LLY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.lly_cstm_cal_yr_wid AS 'Surrogate key for the corresponding year two years ago (LLY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_cstm_cal_dy_wid AS 'Surrogate key for the corresponding day three years ago (LLLY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_cstm_cal_wk_wid AS 'Surrogate key for the corresponding week three years ago (LLLY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_cstm_cal_prd_wid AS 'Surrogate key for the corresponding period (month) three years ago (LLLY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.llly_cstm_cal_yr_wid AS 'Surrogate key for the corresponding year three years ago (LLLY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_cstm_cal_dy_wid AS 'Surrogate key for the corresponding day next year (NY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_cstm_cal_wk_wid AS 'Surrogate key for the corresponding week next year (NY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_cstm_cal_prd_wid AS 'Surrogate key for the corresponding period (month) next year (NY).'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.ny_cstm_cal_yr_wid AS 'Surrogate key for the corresponding year next year (NY).'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_TMP_ACC_FND.FND1012_VALID.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/