
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_DATE_DIM = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM
    (
    "calendar_dt" DATE NOT NULL FORMAT 'yyyy-mm-dd',
    year_start_dt DATE NOT NULL FORMAT 'yyyy-mm-dd',
    year_end_dt DATE NOT NULL FORMAT 'yyyy-mm-dd',
    "period_start_dt" DATE NOT NULL FORMAT 'yyyy-mm-dd',
    period_end_dt DATE NOT NULL FORMAT 'yyyy-mm-dd',
    week_start_dt DATE NOT NULL FORMAT 'yyyy-mm-dd',
    week_end_dt DATE NOT NULL FORMAT 'yyyy-mm-dd',
    day_of_year_num SMALLINT NOT NULL FORMAT '99',
    day_of_period_num SMALLINT NOT NULL FORMAT '99',
    day_of_week_num BYTEINT NOT NULL FORMAT '99',
    week_of_year_num BYTEINT NOT NULL FORMAT '99',
    week_of_period_num BYTEINT NOT NULL FORMAT '99',
    period_of_year_num BYTEINT NOT NULL FORMAT '99',
    year_week INTEGER NOT NULL FORMAT '999999',
    year_period INTEGER NOT NULL FORMAT '999999',
    year_num INTEGER NOT NULL FORMAT '9999',
    season_code INTEGER  ,
    season_name VARCHAR(5)  ,
    season_description VARCHAR(5)  ,
    season_map BYTE(14)  ,
    season_wid SMALLINT  ,
    ly_calendar_dt DATE  FORMAT 'yyyy-mm-dd',
    ly_year_start_dt DATE  FORMAT 'yyyy-mm-dd',
    ly_year_end_dt DATE  FORMAT 'yyyy-mm-dd',
    ly_period_start_dt DATE  FORMAT 'yyyy-mm-dd',
    ly_period_end_dt DATE  FORMAT 'yyyy-mm-dd',
    ly_week_start_dt DATE  FORMAT 'yyyy-mm-dd',
    ly_week_end_dt DATE  FORMAT 'yyyy-mm-dd',
    ly_day_of_year_num SMALLINT  FORMAT '99',
    ly_day_of_period_num SMALLINT  FORMAT '99',
    ly_day_of_week_num SMALLINT  FORMAT '99',
    ly_week_of_year_num BIGINT  FORMAT '99',
    ly_week_of_period_num BIGINT  FORMAT '99',
    ly_period_of_year_num BIGINT  FORMAT '99',
    ly_year_week INTEGER  FORMAT '999999',
    ly_year_period INTEGER  FORMAT '999999',
    ly_year_num INTEGER  FORMAT '9999',
    lly_calendar_dt DATE  FORMAT 'yyyy-mm-dd',
    lly_year_start_dt DATE  FORMAT 'yyyy-mm-dd',
    lly_year_end_dt DATE  FORMAT 'yyyy-mm-dd',
    lly_period_start_dt DATE  FORMAT 'yyyy-mm-dd',
    lly_period_end_dt DATE  FORMAT 'yyyy-mm-dd',
    lly_week_start_dt DATE  FORMAT 'yyyy-mm-dd',
    lly_week_end_dt DATE  FORMAT 'yyyy-mm-dd',
    lly_day_of_year_num SMALLINT  FORMAT '99',
    lly_day_of_period_num SMALLINT  FORMAT '99',
    lly_day_of_week_num SMALLINT  FORMAT '99',
    lly_week_of_year_num BIGINT  FORMAT '99',
    lly_week_of_period_num BIGINT  FORMAT '99',
    lly_period_of_year_num BIGINT  FORMAT '99',
    lly_year_week INTEGER  FORMAT '999999',
    lly_year_period INTEGER  FORMAT '999999',
    lly_year_num INTEGER  FORMAT '9999',
    llly_calendar_dt DATE  FORMAT 'yyyy-mm-dd',
    llly_year_start_dt DATE  FORMAT 'yyyy-mm-dd',
    llly_year_end_dt DATE  FORMAT 'yyyy-mm-dd',
    llly_period_start_dt DATE  FORMAT 'yyyy-mm-dd',
    llly_period_end_dt DATE  FORMAT 'yyyy-mm-dd',
    llly_week_start_dt DATE  FORMAT 'yyyy-mm-dd',
    llly_week_end_dt DATE  FORMAT 'yyyy-mm-dd',
    llly_day_of_year_num SMALLINT  FORMAT '99',
    llly_day_of_period_num SMALLINT  FORMAT '99',
    llly_day_of_week_num SMALLINT  FORMAT '99',
    llly_week_of_year_num BIGINT  FORMAT '99',
    llly_week_of_period_num BIGINT  FORMAT '99',
    llly_period_of_year_num BIGINT  FORMAT '99',
    llly_year_week INTEGER  FORMAT '999999',
    llly_year_period INTEGER  FORMAT '999999',
    llly_year_num INTEGER  FORMAT '9999',
    ny_calendar_dt DATE  FORMAT 'yyyy-mm-dd',
    ny_year_start_dt DATE  FORMAT 'yyyy-mm-dd',
    ny_year_end_dt DATE  FORMAT 'yyyy-mm-dd',
    ny_period_start_dt DATE  FORMAT 'yyyy-mm-dd',
    ny_period_end_dt DATE  FORMAT 'yyyy-mm-dd',
    ny_week_start_dt DATE  FORMAT 'yyyy-mm-dd',
    ny_week_end_dt DATE  FORMAT 'yyyy-mm-dd',
    ny_day_of_year_num SMALLINT  FORMAT '99',
    ny_day_of_period_num SMALLINT  FORMAT '99',
    ny_day_of_week_num SMALLINT  FORMAT '99',
    ny_week_of_year_num BIGINT  FORMAT '99',
    ny_week_of_period_num BIGINT  FORMAT '99',
    ny_period_of_year_num BIGINT  FORMAT '99',
    ny_year_week INTEGER  FORMAT '999999',
    ny_year_period INTEGER  FORMAT '999999',
    ny_year_num INTEGER  FORMAT '9999',
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    UNIQUE PRIMARY INDEX(calendar_dt)
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM."calendar_dt" AS 'primary key on table'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.year_start_dt AS 'primark year start date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.year_end_dt AS 'primark year end date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM."period_start_dt" AS 'primark period start date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.period_end_dt AS 'primark period end date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.week_start_dt AS 'primark week start date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.week_end_dt AS 'primark week end date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.day_of_year_num AS 'day number within primark year , starting from 1'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.day_of_period_num AS 'day number within primark period , starting from 1'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.day_of_week_num AS 'day number within primark weak , starting from Sunday 1 till Saturday 7'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.week_of_year_num AS 'week number within primark year , starting from 1 till 52 , with a leep week 53'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.week_of_period_num AS 'week number within primark period, starting from 1 till 4, for a leap primark year 5'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.period_of_year_num AS 'period within primark year starting from 1'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.year_week AS 'primark year week in the form YYYYDD'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.year_period AS 'primark year period in the form YYYYPP'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.year_num AS 'primark year number YYYY'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.season_code AS 'this is the season code for this date'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.season_name AS 'This is the name of the season in SSYYYY based on SS = AW or SS , YYYY - primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.season_description AS 'This is the season name in words SS AW = 2025 Autumn Winter'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.season_map AS 'This is the bit mapping of the season based on the season_wid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.season_wid AS 'This is the season wid for the season'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_calendar_dt AS 'last year calendar date , aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_year_start_dt AS 'last year start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_year_end_dt AS 'last year end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_period_start_dt AS 'last year period start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_period_end_dt AS 'last year period end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_week_start_dt AS 'last year week start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_week_end_dt AS 'last year week end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_day_of_year_num AS 'last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_day_of_period_num AS 'last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_day_of_week_num AS 'last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_week_of_year_num AS 'last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_week_of_period_num AS 'last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_period_of_year_num AS 'last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_year_week AS 'last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_year_period AS 'last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ly_year_num AS 'last year number YYYY aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_calendar_dt AS 'last last year calendar date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_year_start_dt AS 'last last year start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_year_end_dt AS 'last last year end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_period_start_dt AS 'last last year period start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_period_end_dt AS 'last last year period end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_week_start_dt AS 'last last year week start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_week_end_dt AS 'last last year week end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_day_of_year_num AS 'last last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_day_of_period_num AS 'last last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_day_of_week_num AS 'last last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_week_of_year_num AS 'last last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_week_of_period_num AS 'last last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_period_of_year_num AS 'last last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_year_week AS 'last last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_year_period AS 'last last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.lly_year_num AS 'last last year number YYYY aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_calendar_dt AS 'last last last year calendar date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_year_start_dt AS 'last last last year start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_year_end_dt AS 'last last last year end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_period_start_dt AS 'last last last year period start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_period_end_dt AS 'last last last year period end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_week_start_dt AS 'last last last year week start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_week_end_dt AS 'last last last year week end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_day_of_year_num AS 'last last last year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_day_of_period_num AS 'last last last year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_day_of_week_num AS 'last last last year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_week_of_year_num AS 'last last last year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_week_of_period_num AS 'last last last year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_period_of_year_num AS 'last last last year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_year_week AS 'last last last year week in the form YYYYDD aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_year_period AS 'last last last year period in the form YYYYPP aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.llly_year_num AS 'last last last year number YYYY aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_calendar_dt AS 'next year calendar date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_year_start_dt AS 'next year start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_year_end_dt AS 'next year end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_period_start_dt AS 'next year period start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_period_end_dt AS 'next year period end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_week_start_dt AS 'next year week start date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_week_end_dt AS 'next year week end date aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_day_of_year_num AS 'next year day number within primark year, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_day_of_period_num AS 'next year day number within primark period, starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_day_of_week_num AS 'next year day number within primark week, starting from Sunday=1 till Saturday=7, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_week_of_year_num AS 'next year week number within primark year, starting from 1 till 52, with a leap week 53, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_week_of_period_num AS 'next year week number within primark period, starting from 1 till 4, for a leap primark year 5, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_period_of_year_num AS 'next year period within primark year starting from 1, aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_year_week AS 'next year week in the form YYYYDD aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_year_period AS 'next year period in the form YYYYPP aligned with primark year'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.ny_year_num AS 'next year number YYYY aligned with primark year'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_DATE_DIM.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/