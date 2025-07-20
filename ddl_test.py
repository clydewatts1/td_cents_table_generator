import teradatasql
import os
import sys
import yaml
from pathlib import Path
import sqlparse
import logging

conn = None

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
def run_step_file(conn , filename, config,params=None):
    """
    Run a DDL file by dropping and creating the table using the provided config.
    """
    print(f"Processing DDL file: {filename}")
    # if config in config then config = config['config']
    if 'config' in config:
        config = config['config']
    if params is None:
        params = {'INSTANCE': 'T04'}
    #  LDTK_DATE = yesterdays date
    from datetime import datetime, timedelta
    yesterday = datetime.now() - timedelta(days=1)
    params['LDTK_DATE'] = yesterday.strftime('%Y-%m-%d')
    # EFF_TO_DATE = todays date
    today = datetime.now()
    params['EFF_TO_DATE'] = today.strftime('%Y-%m-%d')
    # RUN_ID = random number between 1 and 10000 
    import random
    params['RUNID'] = random.randint(1, 10000)
    # job id based on filename split on <JOBNAME>_....
    job = filename.split('_')[0]
    params['JOB'] = job


    #print(params)
    # get steps paths
    steps_path = config.get('steps_path', 'steps')
    if not steps_path:
        print("Steps path is not specified in the config file. Please check the config file.")
        return 0, ''
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
        return 0, ''

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
        return -1, f"Error substituting parameters in SQL content: {e}"
    # write to tmp file

    with open(tmp_file, 'w') as f:
        f.write(sql_content)

    # now split each statement in the sql_content
    sql_statements = sqlparse.split(sql_content)
    if not sql_statements:
        print(f"No SQL statements found in {filename}.")
        return 0, ''

    # now execute each statement
    for split_index, statement in enumerate(sql_statements):
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
            # remove file extension from filename

            with conn.cursor() as cursor:
                print(f"Executing statement: {statement}")
                cursor.execute(statement)
                print(f"Executed: {statement}")
                fh.write(f"-- EXECUTED SUCCESSFULLY\n")
                #get row count from cursor
                row_count = cursor.rowcount
                print(f"Row count: {row_count}")
                fh.write(f"-- ROW COUNT: {row_count}\n")
                fh.close()
        except Exception as e:
            print(f"Error executing statement: {statement}\nError: {e}")
            fh.write(f"-- ERROR: {e}\n")
            fh.close()
            return -1, str(e)

    return 0, ''

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
    run_step_file(conn , 'FND1012.300.TARGET.sql', config,params=None)




