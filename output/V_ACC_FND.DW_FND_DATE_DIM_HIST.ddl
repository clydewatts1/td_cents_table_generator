
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}V_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_DATE_DIM */
REPLACE VIEW DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST
    AS
SELECT
    calendar_dt ,
    year_start_dt ,
    year_end_dt ,
    period_start_dt ,
    period_end_dt ,
    week_start_dt ,
    week_end_dt ,
    day_of_year_num ,
    day_of_period_num ,
    day_of_week_num ,
    week_of_year_num ,
    week_of_period_num ,
    period_of_year_num ,
    year_week ,
    year_period ,
    year_num ,
    season_code ,
    season_name ,
    season_description ,
    season_map ,
    season_wid ,
    ly_calendar_dt ,
    ly_year_start_dt ,
    ly_year_end_dt ,
    ly_period_start_dt ,
    ly_period_end_dt ,
    ly_week_start_dt ,
    ly_week_end_dt ,
    ly_day_of_year_num ,
    ly_day_of_period_num ,
    ly_day_of_week_num ,
    ly_week_of_year_num ,
    ly_week_of_period_num ,
    ly_period_of_year_num ,
    ly_year_week ,
    ly_year_period ,
    ly_year_num ,
    lly_calendar_dt ,
    lly_year_start_dt ,
    lly_year_end_dt ,
    lly_period_start_dt ,
    lly_period_end_dt ,
    lly_week_start_dt ,
    lly_week_end_dt ,
    lly_day_of_year_num ,
    lly_day_of_period_num ,
    lly_day_of_week_num ,
    lly_week_of_year_num ,
    lly_week_of_period_num ,
    lly_period_of_year_num ,
    lly_year_week ,
    lly_year_period ,
    lly_year_num ,
    llly_calendar_dt ,
    llly_year_start_dt ,
    llly_year_end_dt ,
    llly_period_start_dt ,
    llly_period_end_dt ,
    llly_week_start_dt ,
    llly_week_end_dt ,
    llly_day_of_year_num ,
    llly_day_of_period_num ,
    llly_day_of_week_num ,
    llly_week_of_year_num ,
    llly_week_of_period_num ,
    llly_period_of_year_num ,
    llly_year_week ,
    llly_year_period ,
    llly_year_num ,
    ny_calendar_dt ,
    ny_year_start_dt ,
    ny_year_end_dt ,
    ny_period_start_dt ,
    ny_period_end_dt ,
    ny_week_start_dt ,
    ny_week_end_dt ,
    ny_day_of_year_num ,
    ny_day_of_period_num ,
    ny_day_of_week_num ,
    ny_week_of_year_num ,
    ny_week_of_period_num ,
    ny_period_of_year_num ,
    ny_year_week ,
    ny_year_period ,
    ny_year_num ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST AS ''
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.calendar_dt AS 'primary key on table'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.year_start_dt AS 'primark year start date'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.year_end_dt AS 'primark year end date'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.period_start_dt AS 'primark period start date'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.period_end_dt AS 'primark period end date'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.week_start_dt AS 'primark week start date'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.week_end_dt AS 'primark week end date'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.day_of_year_num AS 'day number within primark year , starting from 1'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.day_of_period_num AS 'day number within primark period , starting from 1'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.day_of_week_num AS 'day number within primark weak , starting from Sunday 1 till Saturday 7'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.week_of_year_num AS 'week number within primark year , starting from 1 till 52 , with a leep week 53'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.week_of_period_num AS 'week number within primark period, starting from 1 till 4, for a leap primark year 5'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.period_of_year_num AS 'period within primark year starting from 1'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.year_week AS 'primark year week in the form YYYYDD'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.year_period AS 'primark year period in the form YYYYPP'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.year_num AS 'primark year number YYYY'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.season_code AS 'this is the season code for this date'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.season_name AS 'This is the name of the season in SSYYYY based on SS = AW or SS , YYYY - primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.season_description AS 'This is the season name in words SS AW = 2025 Autumn Winter'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.season_map AS 'This is the bit mapping of the season based on the season_wid'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.season_wid AS 'This is the season wid for the season'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_calendar_dt AS 'last year calendar date , aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_year_start_dt AS 'last year start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_year_end_dt AS 'last year end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_period_start_dt AS 'last year period start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_period_end_dt AS 'last year period end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_week_start_dt AS 'last year week start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_week_end_dt AS 'last year week end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_day_of_year_num AS 'last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_day_of_period_num AS 'last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_day_of_week_num AS 'last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_week_of_year_num AS 'last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_week_of_period_num AS 'last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_period_of_year_num AS 'last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_year_week AS 'last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_year_period AS 'last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ly_year_num AS 'last year number YYYY aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_calendar_dt AS 'last last year calendar date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_year_start_dt AS 'last last year start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_year_end_dt AS 'last last year end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_period_start_dt AS 'last last year period start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_period_end_dt AS 'last last year period end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_week_start_dt AS 'last last year week start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_week_end_dt AS 'last last year week end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_day_of_year_num AS 'last last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_day_of_period_num AS 'last last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_day_of_week_num AS 'last last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_week_of_year_num AS 'last last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_week_of_period_num AS 'last last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_period_of_year_num AS 'last last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_year_week AS 'last last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_year_period AS 'last last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.lly_year_num AS 'last last year number YYYY aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_calendar_dt AS 'last last last year calendar date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_year_start_dt AS 'last last last year start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_year_end_dt AS 'last last last year end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_period_start_dt AS 'last last last year period start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_period_end_dt AS 'last last last year period end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_week_start_dt AS 'last last last year week start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_week_end_dt AS 'last last last year week end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_day_of_year_num AS 'last last last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_day_of_period_num AS 'last last last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_day_of_week_num AS 'last last last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_week_of_year_num AS 'last last last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_week_of_period_num AS 'last last last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_period_of_year_num AS 'last last last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_year_week AS 'last last last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_year_period AS 'last last last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.llly_year_num AS 'last last last year number YYYY aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_calendar_dt AS 'next year calendar date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_year_start_dt AS 'next year start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_year_end_dt AS 'next year end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_period_start_dt AS 'next year period start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_period_end_dt AS 'next year period end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_week_start_dt AS 'next year week start date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_week_end_dt AS 'next year week end date aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_day_of_year_num AS 'next year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_day_of_period_num AS 'next year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_day_of_week_num AS 'next year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_week_of_year_num AS 'next year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_week_of_period_num AS 'next year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_period_of_year_num AS 'next year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_year_week AS 'next year week in the form YYYYDD aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_year_period AS 'next year period in the form YYYYPP aligned with primark year'
;

COMMENT ON COLUMN DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.ny_year_num AS 'next year number YYYY aligned with primark year'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}V_ACC_FND.DW_FND_DATE_DIM_HIST.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/