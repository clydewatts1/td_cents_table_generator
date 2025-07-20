--.IF ERRORCODE <> 0 THEN .QUIT 101

INSERT INTO DWT04T_TMP_ACC_FND.FND1010_DW_FND_DATE_DIM
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
    ny_year_num
)
/*
This query builds a comprehensive custom calendar dimension table.
It gathers data for days, weeks, months, periods, and years, and then
joins them to create a record for each day with corresponding information
for the current year (TY), last year (LY), the year before last (LLY), 
three years ago (LLLY), and the next year (NY). It also includes seasonal information.
*/
-- Common Table Expressions (CTEs) to pre-filter calendar tables for current records.
WITH
  -- Day level calendar data
  DY AS (
    SELECT * FROM DWT04A_IDW.CSTM_CAL_DY
    WHERE
      cur_flg = 'Y'
  ),
  -- Week level calendar data
  WK AS (
    SELECT * FROM DWT04A_IDW.CSTM_CAL_WK
    WHERE
      cur_flg = 'Y'
  ),
  -- Month-Week mapping data
  MT AS (
    SELECT * FROM DWT04A_IDW.CSTM_CAL_MTH_WK
    WHERE
      cur_flg = 'Y'
  ),
  -- Period (Month) level calendar data
  PD AS (
    SELECT * FROM DWT04A_IDW.CSTM_CAL_MTH
    WHERE
      cur_flg = 'Y'
  ),
  -- Year level calendar data
  YR AS (
    SELECT * FROM DWT04A_IDW.CSTM_CAL_YR
    WHERE
      cur_flg = 'Y'
  ),
  -- Seasonal information based on Gregorian date
  SSN AS (
    SELECT
      SSD.greg_dt AS calendar_dt,
      SSD.sson_cd AS season_code,
      SSN.sson_name AS season_name,
      -- Creates a more descriptive season name (e.g., "2023 Spring Summer")
      SUBSTRING(season_name FROM 3 FOR 4) || ' ' || DECODE(
        SUBSTRING(season_name FROM 1 FOR 2),
        'AW', 'Autumn Winter',
        'SS', 'Spring Summer',
        'UA', 'Unknown 0',
        season_name
      ) AS season_description,
      -- Creates a bitmap for the season
      SETBIT(
        (CAST(TO_BYTES('0', 'base10') AS BYTE(14))),
        SSD.sson_wid(SMALLINT)
      ) AS season_map,
      SSN.sson_wid AS season_wid
    FROM
      DWT04A_IDW.PMK_SSON_DAY AS SSD
      INNER JOIN DWT04A_IDW.SSON AS SSN ON SSD.sson_wid = SSN.sson_wid
      AND SSD.cur_flg = 'Y'
      AND SSN.cur_flg = 'Y'
  )
-- Main SELECT statement to construct the final calendar dimension
SELECT
  -- This Year (TY) columns
  TYCD.greg_dt AS calendar_dt,
  TYYR.pmk_yr_strt_dt AS year_start_dt,
  TYYR.pmk_yr_end_dt AS year_end_dt,
  TYPD.pmk_prd_strt_dt AS period_start_dt,
  TYPD.pmk_prd_end_dt AS period_end_dt,
  TYWK.pmk_wk_strt_dt AS week_start_dt,
  TYWK.pmk_wk_end_dt AS week_end_dt,
  TYCD.dy_of_yr_num AS day_of_year_num,
  TYCD.dom_num AS day_of_period_num,
  TYCD.dy_of_wk_num AS day_of_week_num,
  TYWK.pmk_wk_of_yr_num AS week_of_year_num,
  COALESCE(TYWK.pmk_wk_of_prd_num,0) AS week_of_period_num,
  TYPD.pmk_prd_of_yr_num AS period_of_year_num,
  TYWK.cstm_cal_wk_id AS year_week,
  TYPD.cstm_cal_mth_id AS year_period,
  TYYR.cstm_cal_yr_id AS year_num,
  -- Season columns
  SSN.season_code,
  SSN.season_name,
  SSN.season_description,
  SSN.season_map,
  SSN.season_wid,
  -- Last Year (LY) columns
  LYCD.greg_dt AS ly_calendar_dt,
  LYYR.pmk_yr_strt_dt AS ly_year_start_dt,
  LYYR.pmk_yr_end_dt AS ly_year_end_dt,
  LYPD.pmk_prd_strt_dt AS ly_period_start_dt,
  LYPD.pmk_prd_end_dt AS ly_period_end_dt,
  LYWK.pmk_wk_strt_dt AS ly_week_start_dt,
  LYWK.pmk_wk_end_dt AS ly_week_end_dt,
  LYCD.dy_of_yr_num AS ly_day_of_year_num,
  LYCD.dom_num AS ly_day_of_period_num,
  LYCD.dy_of_wk_num AS ly_day_of_week_num,
  LYWK.pmk_wk_of_yr_num AS ly_week_of_year_num,
  LYWK.pmk_wk_of_prd_num AS ly_week_of_period_num,
  LYPD.pmk_prd_of_yr_num AS ly_period_of_year_num,
  LYWK.cstm_cal_wk_id AS ly_year_week,
  LYPD.cstm_cal_mth_id AS ly_year_period,
  LYYR.cstm_cal_yr_id AS ly_year_num,
  -- Last Last Year (LLY) columns
  LLYCD.greg_dt AS lly_calendar_dt,
  LLYYR.pmk_yr_strt_dt AS lly_year_start_dt,
  LLYYR.pmk_yr_end_dt AS lly_year_end_dt,
  LLYPD.pmk_prd_strt_dt AS lly_period_start_dt,
  LLYPD.pmk_prd_end_dt AS lly_period_end_dt,
  LLYWK.pmk_wk_strt_dt AS lly_week_start_dt,
  LLYWK.pmk_wk_end_dt AS lly_week_end_dt,
  LLYCD.dy_of_yr_num AS lly_day_of_year_num,
  LLYCD.dom_num AS lly_day_of_period_num,
  LLYCD.dy_of_wk_num AS lly_day_of_week_num,
  LLYWK.pmk_wk_of_yr_num AS lly_week_of_year_num,
  LLYWK.pmk_wk_of_prd_num AS lly_week_of_period_num,
  LLYPD.pmk_prd_of_yr_num AS lly_period_of_year_num,
  LLYWK.cstm_cal_wk_id AS lly_year_week,
  LLYPD.cstm_cal_mth_id AS lly_year_period,
  LLYYR.cstm_cal_yr_id AS lly_year_num,
  -- Last Last Last year (LLLY) columns
  LLLYCD.greg_dt AS llly_calendar_dt,
  LLLYYR.pmk_yr_strt_dt AS llly_year_start_dt,
  LLLYYR.pmk_yr_end_dt AS llly_year_end_dt,
  LLLYPD.pmk_prd_strt_dt AS llly_period_start_dt,
  LLLYPD.pmk_prd_end_dt AS llly_period_end_dt,
  LLLYWK.pmk_wk_strt_dt AS llly_week_start_dt,
  LLLYWK.pmk_wk_end_dt AS llly_week_end_dt,
  LLLYCD.dy_of_yr_num AS llly_day_of_year_num,
  LLLYCD.dom_num AS llly_day_of_period_num,
  LLLYCD.dy_of_wk_num AS llly_day_of_week_num,
  LLLYWK.pmk_wk_of_yr_num AS llly_week_of_year_num,
  LLLYWK.pmk_wk_of_prd_num AS llly_week_of_period_num,
  LLLYPD.pmk_prd_of_yr_num AS llly_period_of_year_num,
  LLLYWK.cstm_cal_wk_id AS llly_year_week,
  LLLYPD.cstm_cal_mth_id AS llly_year_period,
  LLLYYR.cstm_cal_yr_id AS llly_year_num,
  -- Next Year (NY) columns
  NYCD.greg_dt AS ny_calendar_dt,
  NYYR.pmk_yr_strt_dt AS ny_year_start_dt,
  NYYR.pmk_yr_end_dt AS ny_year_end_dt,
  NYPD.pmk_prd_strt_dt AS ny_period_start_dt,
  NYPD.pmk_prd_end_dt AS ny_period_end_dt,
  NYWK.pmk_wk_strt_dt AS ny_week_start_dt,
  NYWK.pmk_wk_end_dt AS ny_week_end_dt,
  NYCD.dy_of_yr_num AS ny_day_of_year_num,
  NYCD.dom_num AS ny_day_of_period_num,
  NYCD.dy_of_wk_num AS ny_day_of_week_num,
  NYWK.pmk_wk_of_yr_num AS ny_week_of_year_num,
  NYWK.pmk_wk_of_prd_num AS ny_week_of_period_num,
  NYPD.pmk_prd_of_yr_num AS ny_period_of_year_num,
  NYWK.cstm_cal_wk_id AS ny_year_week,
  NYPD.cstm_cal_mth_id AS ny_year_period,
  NYYR.cstm_cal_yr_id AS ny_year_num
FROM
  -- Start with the Day table for the current year (TYCD)
  DY AS TYCD
  -- Join to get the corresponding day for the previous year (LYCD)
  LEFT OUTER JOIN DY AS LYCD ON TYCD.pmk_prior_cal_dy_wid = LYCD.cstm_cal_dy_wid
  -- Join to get the corresponding day for two years ago (LLYCD)
  LEFT OUTER JOIN DY AS LLYCD ON LYCD.pmk_prior_cal_dy_wid = LLYCD.cstm_cal_dy_wid
  -- Join to get the corresponding day for three years ago (LLLYCD)
  LEFT OUTER JOIN DY AS LLLYCD ON LLYCD.pmk_prior_cal_dy_wid = LLLYCD.cstm_cal_dy_wid
  -- Join to get the corresponding day for the next year (NYCD)
  LEFT OUTER JOIN DY AS NYCD ON TYCD.pmk_prior_cal_dy_wid = NYCD.cstm_cal_dy_wid
  /* Join to Week level for all years */
  LEFT OUTER JOIN WK AS TYWK ON TYCD.cstm_cal_wk_wid = TYWK.cstm_cal_wk_wid
  LEFT OUTER JOIN WK AS LYWK ON LYCD.cstm_cal_wk_wid = LYWK.cstm_cal_wk_wid
  LEFT OUTER JOIN WK AS LLYWK ON LLYCD.cstm_cal_wk_wid = LLYWK.cstm_cal_wk_wid
  LEFT OUTER JOIN WK AS LLLYWK ON LLLYCD.cstm_cal_wk_wid = LLLYWK.cstm_cal_wk_wid
  LEFT OUTER JOIN WK AS NYWK ON NYCD.cstm_cal_wk_wid = NYWK.cstm_cal_wk_wid
  /* Join to Month-Week mapping for all years */
  LEFT OUTER JOIN MT AS TYMT ON TYWK.cstm_cal_wk_wid = TYMT.cstm_cal_wk_wid
  LEFT OUTER JOIN MT AS LYMT ON LYWK.cstm_cal_wk_wid = LYMT.cstm_cal_wk_wid
  LEFT OUTER JOIN MT AS LLYMT ON LLYWK.cstm_cal_wk_wid = LLYMT.cstm_cal_wk_wid
  LEFT OUTER JOIN MT AS LLLYMT ON LLLYWK.cstm_cal_wk_wid = LLLYMT.cstm_cal_wk_wid
  LEFT OUTER JOIN MT AS NYMT ON NYWK.cstm_cal_wk_wid = NYMT.cstm_cal_wk_wid
  /* Join to Period (Month) level for all years */
  LEFT OUTER JOIN PD AS TYPD ON TYMT.cstm_cal_prd_wid = TYPD.cstm_cal_prd_wid
  LEFT OUTER JOIN PD AS LYPD ON LYMT.cstm_cal_prd_wid = LYPD.cstm_cal_prd_wid
  LEFT OUTER JOIN PD AS LLYPD ON LLYMT.cstm_cal_prd_wid = LLYPD.cstm_cal_prd_wid
  LEFT OUTER JOIN PD AS LLLYPD ON LLLYMT.cstm_cal_prd_wid = LLLYPD.cstm_cal_prd_wid
  LEFT OUTER JOIN PD AS NYPD ON NYMT.cstm_cal_prd_wid = NYPD.cstm_cal_prd_wid
  /* Join to Year level for all years */
  LEFT OUTER JOIN YR AS TYYR ON TYPD.cstm_cal_yr_wid = TYYR.cstm_cal_yr_wid
  LEFT OUTER JOIN YR AS LYYR ON LYPD.cstm_cal_yr_wid = LYYR.cstm_cal_yr_wid
  LEFT OUTER JOIN YR AS LLYYR ON LLYPD.cstm_cal_yr_wid = LLYYR.cstm_cal_yr_wid
  LEFT OUTER JOIN YR AS LLLYYR ON LLLYPD.cstm_cal_yr_wid = LLLYYR.cstm_cal_yr_wid
  LEFT OUTER JOIN YR AS NYYR ON NYPD.cstm_cal_yr_wid = NYYR.cstm_cal_yr_wid
  /* Join to Seasonal data */
  LEFT OUTER JOIN SSN ON SSN.calendar_dt = TYCD.greg_dt
;
-------------------------------------------------------------------------------------

-- EXECUTED SUCCESSFULLY
