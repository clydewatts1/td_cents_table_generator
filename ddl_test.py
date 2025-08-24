import teradatasql
import os
import sys
import yaml
from pathlib import Path
import sqlparse
import logging
from datetime import datetime, timedelta


conn = None

def get_parameters_for_step(conn, parameters, step_name,INSTANCE, LDTK_DATE):
    sql = f"""
        WITH dte AS (
    SELECT
        TO_CHAR(dte.calendar_dt, 'YYYY-MM-DD') AS calendar_dt,
        TO_CHAR(dte.year_start_dt, 'YYYY-MM-DD') AS year_start_dt,
        TO_CHAR(dte.year_end_dt, 'YYYY-MM-DD') AS year_end_dt,
        TO_CHAR(dte.period_start_dt, 'YYYY-MM-DD') AS period_start_dt,
        TO_CHAR(dte.period_end_dt, 'YYYY-MM-DD') AS period_end_dt,
        TO_CHAR(dte.week_start_dt, 'YYYY-MM-DD') AS week_start_dt,
        TO_CHAR(dte.week_end_dt, 'YYYY-MM-DD') AS week_end_dt,
        TO_CHAR(dte.day_of_year_num, '000') AS day_of_year_num,
        TO_CHAR(dte.day_of_period_num, '00') AS day_of_period_num,
        TO_CHAR(dte.day_of_week_num, '0') AS day_of_week_num,
        TO_CHAR(dte.week_of_year_num, '00') AS week_of_year_num,
        TO_CHAR(dte.week_of_period_num, '00') AS week_of_period_num,
        TO_CHAR(dte.period_of_year_num, '00') AS period_of_year_num,
        TO_CHAR(dte.year_week, '000000') AS year_week,
        TO_CHAR(dte.year_period, '000000') AS year_period,
        TO_CHAR(dte.year_num, '0000') AS year_num,
        dte.season_code,
        dte.season_name,
        dte.season_description,
        TO_CHAR(dte.ly_calendar_dt, 'YYYY-MM-DD') AS ly_calendar_dt,
        TO_CHAR(dte.ly_year_start_dt, 'YYYY-MM-DD') AS ly_year_start_dt,
        TO_CHAR(dte.ly_year_end_dt, 'YYYY-MM-DD') AS ly_year_end_dt,
        TO_CHAR(dte.ly_period_start_dt, 'YYYY-MM-DD') AS ly_period_start_dt,
        TO_CHAR(dte.ly_period_end_dt, 'YYYY-MM-DD') AS ly_period_end_dt,
        TO_CHAR(dte.ly_week_start_dt, 'YYYY-MM-DD') AS ly_week_start_dt,
        TO_CHAR(dte.ly_week_end_dt, 'YYYY-MM-DD') AS ly_week_end_dt,
        TO_CHAR(dte.ly_day_of_year_num, '000') AS ly_day_of_year_num,
        TO_CHAR(dte.ly_day_of_period_num, '00') AS ly_day_of_period_num,
        TO_CHAR(dte.ly_day_of_week_num, '0') AS ly_day_of_week_num,
        TO_CHAR(dte.ly_week_of_year_num, '00') AS ly_week_of_year_num,
        TO_CHAR(dte.ly_week_of_period_num, '00') AS ly_week_of_period_num,
        TO_CHAR(dte.ly_period_of_year_num, '00') AS ly_period_of_year_num,
        TO_CHAR(dte.ly_year_week, '000000') AS ly_year_week,
        TO_CHAR(dte.ly_year_period, '000000') AS ly_year_period,
        TO_CHAR(dte.ly_year_num, '0000') AS ly_year_num,
        TO_CHAR(dte.lly_calendar_dt, 'YYYY-MM-DD') AS lly_calendar_dt,
        TO_CHAR(dte.lly_year_start_dt, 'YYYY-MM-DD') AS lly_year_start_dt,
        TO_CHAR(dte.lly_year_end_dt, 'YYYY-MM-DD') AS lly_year_end_dt,
        TO_CHAR(dte.lly_period_start_dt, 'YYYY-MM-DD') AS lly_period_start_dt,
        TO_CHAR(dte.lly_period_end_dt, 'YYYY-MM-DD') AS lly_period_end_dt,
        TO_CHAR(dte.lly_week_start_dt, 'YYYY-MM-DD') AS lly_week_start_dt,
        TO_CHAR(dte.lly_week_end_dt, 'YYYY-MM-DD') AS lly_week_end_dt,
        TO_CHAR(dte.lly_day_of_year_num, '000') AS lly_day_of_year_num,
        TO_CHAR(dte.lly_day_of_period_num, '00') AS lly_day_of_period_num,
        TO_CHAR(dte.lly_day_of_week_num, '0') AS lly_day_of_week_num,
        TO_CHAR(dte.lly_week_of_year_num, '00') AS lly_week_of_year_num,
        TO_CHAR(dte.lly_week_of_period_num, '00') AS lly_week_of_period_num,
        TO_CHAR(dte.lly_period_of_year_num, '00') AS lly_period_of_year_num,
        TO_CHAR(dte.lly_year_week, '000000') AS lly_year_week,
        TO_CHAR(dte.lly_year_period, '000000') AS lly_year_period,
        TO_CHAR(dte.lly_year_num, '0000') AS lly_year_num,
        TO_CHAR(dte.llly_calendar_dt, 'YYYY-MM-DD') AS llly_calendar_dt,
        TO_CHAR(dte.llly_year_start_dt, 'YYYY-MM-DD') AS llly_year_start_dt,
        TO_CHAR(dte.llly_year_end_dt, 'YYYY-MM-DD') AS llly_year_end_dt,
        TO_CHAR(dte.llly_period_start_dt, 'YYYY-MM-DD') AS llly_period_start_dt,
        TO_CHAR(dte.llly_period_end_dt, 'YYYY-MM-DD') AS llly_period_end_dt,
        TO_CHAR(dte.llly_week_start_dt, 'YYYY-MM-DD') AS llly_week_start_dt,
        TO_CHAR(dte.llly_week_end_dt, 'YYYY-MM-DD') AS llly_week_end_dt,
        TO_CHAR(dte.llly_day_of_year_num, '000') AS llly_day_of_year_num,
        TO_CHAR(dte.llly_day_of_period_num, '00') AS llly_day_of_period_num,
        TO_CHAR(dte.llly_day_of_week_num, '0') AS llly_day_of_week_num,
        TO_CHAR(dte.llly_week_of_year_num, '00') AS llly_week_of_year_num,
        TO_CHAR(dte.llly_week_of_period_num, '00') AS llly_week_of_period_num,
        TO_CHAR(dte.llly_period_of_year_num, '00') AS llly_period_of_year_num,
        TO_CHAR(dte.llly_year_week, '000000') AS llly_year_week,
        TO_CHAR(dte.llly_year_period, '000000') AS llly_year_period,
        TO_CHAR(dte.llly_year_num, '0000') AS llly_year_num,
        TO_CHAR(dte.ny_calendar_dt, 'YYYY-MM-DD') AS ny_calendar_dt,
        TO_CHAR(dte.ny_year_start_dt, 'YYYY-MM-DD') AS ny_year_start_dt,
        TO_CHAR(dte.ny_year_end_dt, 'YYYY-MM-DD') AS ny_year_end_dt,
        TO_CHAR(dte.ny_period_start_dt, 'YYYY-MM-DD') AS ny_period_start_dt,
        TO_CHAR(dte.ny_period_end_dt, 'YYYY-MM-DD') AS ny_period_end_dt,
        TO_CHAR(dte.ny_week_start_dt, 'YYYY-MM-DD') AS ny_week_start_dt,
        TO_CHAR(dte.ny_week_end_dt, 'YYYY-MM-DD') AS ny_week_end_dt,
        TO_CHAR(dte.ny_day_of_year_num, '000') AS ny_day_of_year_num,
        TO_CHAR(dte.ny_day_of_period_num, '00') AS ny_day_of_period_num,
        TO_CHAR(dte.ny_day_of_week_num, '0') AS ny_day_of_week_num,
        TO_CHAR(dte.ny_week_of_year_num, '00') AS ny_week_of_year_num,
        TO_CHAR(dte.ny_week_of_period_num, '00') AS ny_week_of_period_num,
        TO_CHAR(dte.ny_period_of_year_num, '00') AS ny_period_of_year_num,
        TO_CHAR(dte.ny_year_week, '000000') AS ny_year_week,
        TO_CHAR(dte.ny_year_period, '000000') AS ny_year_period,
        TO_CHAR(dte.ny_year_num, '0000') AS ny_year_num
    FROM DW{INSTANCE}A_ACC_FND.DW_FND_DATE_DIM AS dte
    WHERE
        dte.calendar_dt = date '{LDTK_DATE}'
)
SELECT '!CALENDAR_DT="' || TRIM(dte.calendar_dt) || '"' (VARCHAR(200)) "#" FROM dte UNION ALL
SELECT '!YEAR_START_DT="' || TRIM(dte.year_start_dt) || '"' FROM dte UNION ALL
SELECT '!YEAR_END_DT="' || TRIM(dte.year_end_dt) || '"' FROM dte UNION ALL
SELECT '!PERIOD_START_DT="' || TRIM(dte.period_start_dt) || '"' FROM dte UNION ALL
SELECT '!PERIOD_END_DT="' || TRIM(dte.period_end_dt) || '"' FROM dte UNION ALL
SELECT '!WEEK_START_DT="' || TRIM(dte.week_start_dt) || '"' FROM dte UNION ALL
SELECT '!WEEK_END_DT="' || TRIM(dte.week_end_dt) || '"' FROM dte UNION ALL
SELECT '!DAY_OF_YEAR_NUM="' || TRIM(dte.day_of_year_num) || '"' FROM dte UNION ALL
SELECT '!DAY_OF_PERIOD_NUM="' || TRIM(dte.day_of_period_num) || '"' FROM dte UNION ALL
SELECT '!DAY_OF_WEEK_NUM="' || TRIM(dte.day_of_week_num) || '"' FROM dte UNION ALL
SELECT '!WEEK_OF_YEAR_NUM="' || TRIM(dte.week_of_year_num) || '"' FROM dte UNION ALL
SELECT '!WEEK_OF_PERIOD_NUM="' || TRIM(dte.week_of_period_num) || '"' FROM dte UNION ALL
SELECT '!PERIOD_OF_YEAR_NUM="' || TRIM(dte.period_of_year_num) || '"' FROM dte UNION ALL
SELECT '!YEAR_WEEK="' || TRIM(dte.year_week) || '"' FROM dte UNION ALL
SELECT '!YEAR_PERIOD="' || TRIM(dte.year_period) || '"' FROM dte UNION ALL
SELECT '!YEAR_NUM="' || TRIM(dte.year_num) || '"' FROM dte UNION ALL
SELECT '!SEASON_CODE="' || TRIM(dte.season_code) || '"' FROM dte UNION ALL
SELECT '!SEASON_NAME="' || TRIM(dte.season_name) || '"' FROM dte UNION ALL
SELECT '!SEASON_DESCRIPTION="' || TRIM(dte.season_description) || '"' FROM dte UNION ALL
SELECT '!LY_CALENDAR_DT="' || TRIM(dte.ly_calendar_dt) || '"' FROM dte UNION ALL
SELECT '!LY_YEAR_START_DT="' || TRIM(dte.ly_year_start_dt) || '"' FROM dte UNION ALL
SELECT '!LY_YEAR_END_DT="' || TRIM(dte.ly_year_end_dt) || '"' FROM dte UNION ALL
SELECT '!LY_PERIOD_START_DT="' || TRIM(dte.ly_period_start_dt) || '"' FROM dte UNION ALL
SELECT '!LY_PERIOD_END_DT="' || TRIM(dte.ly_period_end_dt) || '"' FROM dte UNION ALL
SELECT '!LY_WEEK_START_DT="' || TRIM(dte.ly_week_start_dt) || '"' FROM dte UNION ALL
SELECT '!LY_WEEK_END_DT="' || TRIM(dte.ly_week_end_dt) || '"' FROM dte UNION ALL
SELECT '!LY_DAY_OF_YEAR_NUM="' || TRIM(dte.ly_day_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LY_DAY_OF_PERIOD_NUM="' || TRIM(dte.ly_day_of_period_num) || '"' FROM dte UNION ALL
SELECT '!LY_DAY_OF_WEEK_NUM="' || TRIM(dte.ly_day_of_week_num) || '"' FROM dte UNION ALL
SELECT '!LY_WEEK_OF_YEAR_NUM="' || TRIM(dte.ly_week_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LY_WEEK_OF_PERIOD_NUM="' || TRIM(dte.ly_week_of_period_num) || '"' FROM dte UNION ALL
SELECT '!LY_PERIOD_OF_YEAR_NUM="' || TRIM(dte.ly_period_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LY_YEAR_WEEK="' || TRIM(dte.ly_year_week) || '"' FROM dte UNION ALL
SELECT '!LY_YEAR_PERIOD="' || TRIM(dte.ly_year_period) || '"' FROM dte UNION ALL
SELECT '!LY_YEAR_NUM="' || TRIM(dte.ly_year_num) || '"' FROM dte UNION ALL
SELECT '!LLY_CALENDAR_DT="' || TRIM(dte.lly_calendar_dt) || '"' FROM dte UNION ALL
SELECT '!LLY_YEAR_START_DT="' || TRIM(dte.lly_year_start_dt) || '"' FROM dte UNION ALL
SELECT '!LLY_YEAR_END_DT="' || TRIM(dte.lly_year_end_dt) || '"' FROM dte UNION ALL
SELECT '!LLY_PERIOD_START_DT="' || TRIM(dte.lly_period_start_dt) || '"' FROM dte UNION ALL
SELECT '!LLY_PERIOD_END_DT="' || TRIM(dte.lly_period_end_dt) || '"' FROM dte UNION ALL
SELECT '!LLY_WEEK_START_DT="' || TRIM(dte.lly_week_start_dt) || '"' FROM dte UNION ALL
SELECT '!LLY_WEEK_END_DT="' || TRIM(dte.lly_week_end_dt) || '"' FROM dte UNION ALL
SELECT '!LLY_DAY_OF_YEAR_NUM="' || TRIM(dte.lly_day_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LLY_DAY_OF_PERIOD_NUM="' || TRIM(dte.lly_day_of_period_num) || '"' FROM dte UNION ALL
SELECT '!LLY_DAY_OF_WEEK_NUM="' || TRIM(dte.lly_day_of_week_num) || '"' FROM dte UNION ALL
SELECT '!LLY_WEEK_OF_YEAR_NUM="' || TRIM(dte.lly_week_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LLY_WEEK_OF_PERIOD_NUM="' || TRIM(dte.lly_week_of_period_num) || '"' FROM dte UNION ALL
SELECT '!LLY_PERIOD_OF_YEAR_NUM="' || TRIM(dte.lly_period_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LLY_YEAR_WEEK="' || TRIM(dte.lly_year_week) || '"' FROM dte UNION ALL
SELECT '!LLY_YEAR_PERIOD="' || TRIM(dte.lly_year_period) || '"' FROM dte UNION ALL
SELECT '!LLY_YEAR_NUM="' || TRIM(dte.lly_year_num) || '"' FROM dte UNION ALL
SELECT '!LLLY_CALENDAR_DT="' || TRIM(dte.llly_calendar_dt) || '"' FROM dte UNION ALL
SELECT '!LLLY_YEAR_START_DT="' || TRIM(dte.llly_year_start_dt) || '"' FROM dte UNION ALL
SELECT '!LLLY_YEAR_END_DT="' || TRIM(dte.llly_year_end_dt) || '"' FROM dte UNION ALL
SELECT '!LLLY_PERIOD_START_DT="' || TRIM(dte.llly_period_start_dt) || '"' FROM dte UNION ALL
SELECT '!LLLY_PERIOD_END_DT="' || TRIM(dte.llly_period_end_dt) || '"' FROM dte UNION ALL
SELECT '!LLLY_WEEK_START_DT="' || TRIM(dte.llly_week_start_dt) || '"' FROM dte UNION ALL
SELECT '!LLLY_WEEK_END_DT="' || TRIM(dte.llly_week_end_dt) || '"' FROM dte UNION ALL
SELECT '!LLLY_DAY_OF_YEAR_NUM="' || TRIM(dte.llly_day_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LLLY_DAY_OF_PERIOD_NUM="' || TRIM(dte.llly_day_of_period_num) || '"' FROM dte UNION ALL
SELECT '!LLLY_DAY_OF_WEEK_NUM="' || TRIM(dte.llly_day_of_week_num) || '"' FROM dte UNION ALL
SELECT '!LLLY_WEEK_OF_YEAR_NUM="' || TRIM(dte.llly_week_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LLLY_WEEK_OF_PERIOD_NUM="' || TRIM(dte.llly_week_of_period_num) || '"' FROM dte UNION ALL
SELECT '!LLLY_PERIOD_OF_YEAR_NUM="' || TRIM(dte.llly_period_of_year_num) || '"' FROM dte UNION ALL
SELECT '!LLLY_YEAR_WEEK="' || TRIM(dte.llly_year_week) || '"' FROM dte UNION ALL
SELECT '!LLLY_YEAR_PERIOD="' || TRIM(dte.llly_year_period) || '"' FROM dte UNION ALL
SELECT '!LLLY_YEAR_NUM="' || TRIM(dte.llly_year_num) || '"' FROM dte UNION ALL
SELECT '!NY_CALENDAR_DT="' || TRIM(dte.ny_calendar_dt) || '"' FROM dte UNION ALL
SELECT '!NY_YEAR_START_DT="' || TRIM(dte.ny_year_start_dt) || '"' FROM dte UNION ALL
SELECT '!NY_YEAR_END_DT="' || TRIM(dte.ny_year_end_dt) || '"' FROM dte UNION ALL
SELECT '!NY_PERIOD_START_DT="' || TRIM(dte.ny_period_start_dt) || '"' FROM dte UNION ALL
SELECT '!NY_PERIOD_END_DT="' || TRIM(dte.ny_period_end_dt) || '"' FROM dte UNION ALL
SELECT '!NY_WEEK_START_DT="' || TRIM(dte.ny_week_start_dt) || '"' FROM dte UNION ALL
SELECT '!NY_WEEK_END_DT="' || TRIM(dte.ny_week_end_dt) || '"' FROM dte UNION ALL
SELECT '!NY_DAY_OF_YEAR_NUM="' || TRIM(dte.ny_day_of_year_num) || '"' FROM dte UNION ALL
SELECT '!NY_DAY_OF_PERIOD_NUM="' || TRIM(dte.ny_day_of_period_num) || '"' FROM dte UNION ALL
SELECT '!NY_DAY_OF_WEEK_NUM="' || TRIM(dte.ny_day_of_week_num) || '"' FROM dte UNION ALL
SELECT '!NY_WEEK_OF_YEAR_NUM="' || TRIM(dte.ny_week_of_year_num) || '"' FROM dte UNION ALL
SELECT '!NY_WEEK_OF_PERIOD_NUM="' || TRIM(dte.ny_week_of_period_num) || '"' FROM dte UNION ALL
SELECT '!NY_PERIOD_OF_YEAR_NUM="' || TRIM(dte.ny_period_of_year_num) || '"' FROM dte UNION ALL
SELECT '!NY_YEAR_WEEK="' || TRIM(dte.ny_year_week) || '"' FROM dte UNION ALL
SELECT '!NY_YEAR_PERIOD="' || TRIM(dte.ny_year_period) || '"' FROM dte UNION ALL
SELECT '!NY_YEAR_NUM="' || TRIM(dte.ny_year_num) || '"' FROM dte
    """
    with conn.cursor() as cursor:
        try:
            cursor.execute(sql)
            rows = cursor.fetchall()
            for row in rows:
                if row[0].startswith('!'):
                    key, value = row[0][1:].split('=', 1)
                    parameters[key] = value.strip('"')
            # print the parameters dictionary
            return parameters
        except Exception as e:
            print(f"Error executing SQL to get parameters: {e}")
            return parameters
    return parameters



def connect_to_teradata():
    """
    Connect to Teradata using connection info from ~/.tencents/connect.yml
    """
    global conn
    config_path = Path.home() / ".tencents" / "connect.yml"
    if not config_path.exists():
        print(f"Connection info file {config_path} does not exist. Please create it with your Teradata connection details.")
        sys.exit(1)
    with open(config_path, 'r') as f:
        conn_info = yaml.safe_load(f)
    if not conn_info or not isinstance(conn_info, dict):
        print(f"Connection info file {config_path} is empty or not in the expected format.")
        sys.exit(1)
    print("Connecting to Teradata...")
    try:
        conn = teradatasql.connect(
            host=conn_info["host"],
            user=conn_info["user"],
            password=conn_info["password"],
            tmode='TERA'
        )
        if not conn:
            print("Connection failed. Please check your connection info in ~/.tencents/connect.yml")
            sys.exit(1)
        print("Connected to Teradata.")
        print("Host:", conn_info["host"])   
    except Exception as e:
        print(f"Error connecting to Teradata: {e}")
        sys.exit(1)        
    return conn
        
def disconnect_from_teradata():
    """
    Disconnect from Teradata
    """
    global conn
    if conn:
        conn.close()
        print("Disconnected from Teradata.")
        conn = None
    else:
        print("No active connection to disconnect.")
connect_to_teradata()

def drop_using_file(filename,config):
    if 'config' in config:
        config = config['config']
    ddl_drop_filename = str(filename).replace('.ddl', '.drop')
    with open(ddl_drop_filename, 'r') as f:
        ddl_drop_content = f.read()
    # replace ${INSTANCE} with T04 in the DDL content
    # use template to generate DDL substitute INSTANCE with T04
    instance = config.get('instance', 'T04')

    ddl_drop_content = ddl_drop_content.replace('${INSTANCE}', instance)    
    #ddl_drop_content = ddl_drop_content.replace('T_TMP_ACC_FND','T_TMP_ACC_OLR')
    #ddl_drop_content = ddl_drop_content.replace('T_ACC_FND','T_ACC_OLR')
    #ddl_drop_content = ddl_drop_content.replace('A_ACC_FND','A_ACC_OLR')    
    #ddl_drop_content = ddl_drop_content.replace('C_ACC_FND','C_ACC_OLR')        
    #ddl_drop_content = ddl_drop_content.replace('V_ACC_FND','V_ACC_OLR')    
    print(ddl_drop_content)
    try:
        with conn.cursor() as cursor:
            cursor.execute(ddl_drop_content)
            print(f"Executed: {ddl_drop_filename}")
    except Exception as e:
        print(f"Error executing DDL for {ddl_drop_filename}: {e}")    

def create_using_file(filename,config):
    if 'config' in config:
        config = config['config']
    error_code = 0
    error_text = ''
    with open(filename, 'r') as f:
        ddl_content = f.read()
    # replace ${INSTANCE} with T04 in the DDL content
    # use template to generate DDL substitute INSTANCE with T04
    instance = config.get('instance', 'T04')
    ddl_content = ddl_content.replace('${INSTANCE}', instance)
    #filename = filename.replace('${INSTANCE}', instance)    
    print(f"Executing DDL for {filename} on Teradata...")
    #ddl_content = ddl_content.replace('T_TMP_ACC_FND','T_TMP_ACC_OLR')
    #ddl_content = ddl_content.replace('T_ACC_FND','T_ACC_OLR')
    #ddl_content = ddl_content.replace('A_ACC_FND','A_ACC_OLR')    
    #ddl_content = ddl_content.replace('C_ACC_FND','C_ACC_OLR')        
    #ddl_content = ddl_content.replace('V_ACC_FND','V_ACC_OLR')            

    ddl_statements = sqlparse.split(ddl_content)
    for statement in ddl_statements:
        statement = statement.strip()
        if not statement:
            continue
        try:
            with conn.cursor() as cursor:
                print(f"Executing statement: {statement}")
                cursor.execute(statement)
                print(f"Executed: {statement}")
        except Exception as e:
            print(f"Error executing statement: {statement}\nError: {e}")
            error_code = -1
            error_text = str(e)
            # log error and break / exit
            break
    print(f"DDL execution completed for {filename}.")
    return error_code, error_text


#-------------------------------------------------------------------------------------
# Run File
#-------------------------------------------------------------------------------------
def run_step_file(conn , filename, config,params=None,rundate=None):
    """
    Run a DDL file by dropping and creating the table using the provided config.
    """
    print(f"Processing DDL file: {filename}")
    yesterday = datetime.now() - timedelta(days=1)
    today = datetime.now()
    # split run results
    split_run_results = []
    # adjust yesterday and today based on rundate if provided
    if rundate:
        yesterday = datetime.strptime(rundate, '%Y-%m-%d')
        today = yesterday + timedelta(days=1)

    # if config in config then config = config['config']
    if 'config' in config:
        config = config['config']
    if params is None:
        params = {'INSTANCE': 'T04'}
    #  LDTK_DATE = yesterdays date
    
    # rundate is in the format YYYY-MM-DD
    params['LDTK_DATE'] = yesterday.strftime('%Y-%m-%d')

    params['EFF_FROM_DT'] = today.strftime('%Y-%m-%d')
    # RUN_ID = random number between 1 and 10000 
    import random
    params['RUNID'] = random.randint(1, 10000)
    params['STREAMID'] = 'TEST'
    # job id based on filename split on <JOBNAME>_....
    job = filename.split('_')[0]
    params['JOB'] = job
    get_parameters_for_step(conn, params, '',params['INSTANCE'], params['LDTK_DATE'])
    if 'EFF_TO_DATE' not in params:
        # if EFF_TO_DATE is not in params then set it to 9999-12-31
        params['EFF_TO_DATE'] = params['LDTK_DATE']

    #print(params)
    # get steps paths
    steps_path = config.get('steps_path', 'steps')
    if not steps_path:
        print("Steps path is not specified in the config file. Please check the config file.")
        return 0-1, '',split_run_results
    # now create tmp path
    tmp_path = config.get('tmp_path', 'tmp')
    # if path does not exist create
    # append steps to tmp path
    tmp_path = Path(tmp_path) / 'steps'
    if not tmp_path.exists():
        tmp_path.mkdir(parents=True, exist_ok=True)
    # now check if file exists in steps path
    sql_file = Path(steps_path) / filename
    if not sql_file.exists():
        print(f"File {sql_file} does not exist in steps path {steps_path}. Please check the config file.")
        return -1, '',split_run_results

    # now check if file exists in tmp path
    tmp_file = tmp_path / filename
    # add file for spliting
    tmp_split_path = tmp_path / 'split'
    if not tmp_split_path.exists():
        tmp_split_path.mkdir(parents=True, exist_ok=True)
    # delete all files in tmp_split_path
    for file in tmp_split_path.glob('*.sql'):
        file.unlink()
    # if tmp_file exists delete it
    # delete if tmp file exists
    if tmp_file.exists():
        tmp_file.unlink()
    # read sql file content
    with open(sql_file, 'r') as f:
        sql_content = f.read()
    # Using strings template module to substitute params in the sql_content
    from string import Template

    # substitute params in the sql_content ,substitute INSTANCE with T04
    # using regex replace line that starts with .   , replace the . with --
    import re
    sql_content = re.sub(r'^\.', r'\--.', sql_content)
    # try brute force substitution for tjc commands
    # replace BEGIN TRANSACTION with --BEGIN TRANSACTION
    sql_content = sql_content.replace('BEGIN TRANSACTION', '--BEGIN TRANSACTION')

    # replace END TRANSACTION with --END TRANSACTION
    sql_content = sql_content.replace('END TRANSACTION', '--END TRANSACTION')
    sql_content = sql_content.replace('.IF','--.IF')
    
    
    try:
        sql_template = Template(sql_content)
        sql_content = sql_template.substitute(params)
    except KeyError as e:
        print(f"Error substituting parameters in SQL content: {e}")
        return -1, f"Error substituting parameters in SQL content: {e}",split_run_results
    # write to tmp file

    with open(tmp_file, 'w') as f:
        f.write(sql_content)

    # now split each statement in the sql_content
    sql_statements = sqlparse.split(sql_content)
    if not sql_statements:
        print(f"No SQL statements found in {filename}.")
        return -1, '',split_run_results

    # now execute each statement and capture timing
    for split_index, statement in enumerate(sql_statements):
        split_result = {}
        split_run_results.append(split_result)
        statement = statement.strip()
        filename_without_ext = Path(filename).stem
        file_name_split = tmp_split_path / f"{filename_without_ext}.{split_index}.sql"
        # write each statement to a file
        fh = open(file_name_split, 'w')
        fh.write(statement)
        fh.flush()
        print("\n-------------------------------------------------------------------------------------\n", file=fh)
        if not statement:
            print("\n-- Skipping empty statement.\n",file=fh)
            fh.close()
            continue
        try:
            # file name is filename.<split index>.sql
            # populate split_result metadata
            split_result['split_index'] = split_index
            split_result['statement'] = statement
            split_result['file_name'] = str(file_name_split)
            import time
            start_time = time.time()
            with conn.cursor() as cursor:
                print(f"Executing statement: {statement}")
                cursor.execute(statement)
                print(f"Executed: {statement}")
                fh.write(f"-- EXECUTED SUCCESSFULLY\n")
                #get row count from cursor
                row_count = cursor.rowcount
                print(f"Row count: {row_count}")
                fh.write(f"-- ROW COUNT: {row_count}\n")
                split_result['row_count'] = row_count
                split_result['status'] = 'success'
                split_result['error'] = ''
                end_time = time.time()
                elapsed = end_time - start_time
                split_result['elapsed_seconds'] = round(elapsed, 4)
                fh.write(f"-- ELAPSED_SECONDS: {split_result['elapsed_seconds']}\n")
                fh.close()
        except teradatasql.DatabaseError as e:
            print(f"Database error executing statement: {statement}\nError: {e}")
            fh.write(f"-- ERROR: {e}\n")
            split_result['status'] = 'error'
            split_result['error'] = str(e)
            try:
                end_time = time.time()
                split_result['elapsed_seconds'] = round(end_time - start_time, 4)
                fh.write(f"-- ELAPSED_SECONDS: {split_result['elapsed_seconds']}\n")
            except Exception:
                pass
            fh.close()
            return -1, str(e),split_run_results
        except Exception as e:
            print(f"Error executing statement: {statement}\nError: {e}")
            fh.write(f"-- ERROR: {e}\n")
            split_result['status'] = 'error'
            split_result['error'] = str(e)
            try:
                end_time = time.time()
                split_result['elapsed_seconds'] = round(end_time - start_time, 4)
                fh.write(f"-- ELAPSED_SECONDS: {split_result['elapsed_seconds']}\n")
            except Exception:
                pass
            fh.close()
            return -1, str(e),split_run_results

    return 0, '',split_run_results

if __name__ == "__main__":

    # load config.yaml file into config variable
    config_path = Path(__file__).parent / "config.yaml"
    if not config_path.exists():
        print(f"Config file {config_path} does not exist. Please create it with your configuration details.") 
        sys.exit(1)

    # load into config variable
    with open(config_path, 'r') as f:
        config = yaml.safe_load(f)
    if not config or not isinstance(config, dict):
        print(f"Config file {config_path} is empty or not in the expected format.")
        sys.exit(1)
    if 'config' in config:
        config = config['config']
    else:
        print(f"Config file {config_path} does not contain 'config' key. Please check the file format.")
        sys.exit(1)
    print("Config loaded successfully.")
    #print("Config:", config)

    # get output directory from config
    output_dir = config.get('output_dir', 'output')
    if not output_dir:
        print("Output directory is not specified in the config file. Please check the config file.")
        sys.exit(1)

    # now glob all ddl files T_*.ddl in the output directory
    #ddl_files = list(Path(output_dir).glob('T_*.ddl'))
    #for ddl_file in ddl_files:
    #    print(f"Processing DDL file: {ddl_file}")
    #    # drop using file
    #    drop_using_file(ddl_file,config)
    #    # create using file
    #    create_using_file(ddl_file,config)
    run_step_file(conn , 'FND2105.300.TARGET.sql', config,params=None)




