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
    ddl_drop_content = ddl_drop_content.replace('T_TMP_ACC_FND','T_TMP_ACC_OLR')
    ddl_drop_content = ddl_drop_content.replace('T_ACC_FND','T_ACC_OLR')
    ddl_drop_content = ddl_drop_content.replace('A_ACC_FND','A_ACC_OLR')    
    ddl_drop_content = ddl_drop_content.replace('C_ACC_FND','C_ACC_OLR')        
    ddl_drop_content = ddl_drop_content.replace('V_ACC_FND','V_ACC_OLR')    
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
    ddl_content = ddl_content.replace('T_TMP_ACC_FND','T_TMP_ACC_OLR')
    ddl_content = ddl_content.replace('T_ACC_FND','T_ACC_OLR')
    ddl_content = ddl_content.replace('A_ACC_FND','A_ACC_OLR')    
    ddl_content = ddl_content.replace('C_ACC_FND','C_ACC_OLR')        
    ddl_content = ddl_content.replace('V_ACC_FND','V_ACC_OLR')            

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
    print(f"DDL execution completed for {filename}.")
    return error_code, error_text


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
    ddl_files = list(Path(output_dir).glob('T_*.ddl'))
    for ddl_file in ddl_files:
        print(f"Processing DDL file: {ddl_file}")
        # drop using file
        drop_using_file(ddl_file,config)
        # create using file
        create_using_file(ddl_file,config)



