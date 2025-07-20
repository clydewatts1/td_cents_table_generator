import pandas as pd
import glob
import os
import re
import openpyxl
import yaml
import logging
import pprint
import jinja2
from datetime import datetime

def read_excel_to_dataframe_sql_steps(filename, config_dict,df_steps,steps_data):
    #loop through steps looking for file name then search for File Name in sheet
    return_code = 0
    return_text = "Read successful."
    # Get list of sheets in execel
    if config_dict is None:
        logging.error("Configuration dictionary is None. Cannot proceed with reading the Excel file.")
        return -1, "Configuration dictionary is None.", None
    if 'config' in config_dict:
        config_local = config_dict['config']
    else:
        config_local = config_dict

    if not isinstance(config_local, dict):
        logging.error("Configuration is not in the expected format. Expected a dictionary.")
        return -1, "Configuration is not in the expected format.", None
    excel_mapping_dir = config_local.get('excel_mapping_directory', 'excel_mappings')
    if not os.path.isdir(excel_mapping_dir):
        logging.error(
            "excel_mapping_directory %s does not exist. Please check your configuration.",
            excel_mapping_dir,
        )
        return -1, "excel_mapping_directory does not exist.", None
    filename_path = os.path.join(excel_mapping_dir, filename)
    if not os.path.exists(filename_path):
        logging.error(
            "File %s does not exist. Please check the file path.",
            filename_path,
        )
        return -1, "File %s does not exist." % filename_path, None
    try:
        wb = openpyxl.load_workbook(filename_path)
        sheet_names = wb.sheetnames
        logging.info(
            "Sheet names in %s: %s",
            filename_path,
            sheet_names,
        )
    except (OSError, ValueError) as e:
        logging.error(
            "Error loading Excel file %s: %s",
            filename_path,
            str(e),
        )
        return -1, str(e), None   
    # get sql path from config
    sql_path = config_local.get('sql_path', 'sql_files') 
    dict_sql_steps = {}
    if df_steps is None:
        logging.error("DataFrame df_steps is None. Cannot proceed with reading the Excel file.")
        return -1, "DataFrame df_steps is None.", None
    # 
    # loop the steps getting index , and data
    if not isinstance(steps_data, list):
        logging.error("Steps data is not in the expected format. Expected a list.")
        return -1, "Steps data is not in the expected format.", None
    if not steps_data:
        logging.error("Steps data is empty. Cannot proceed with reading the Excel file.")
        return -1, "Steps data is empty.", None
    logging.info("Processing %d steps from df_steps.", len(steps_data))
    # loop through steps_data
    for index, step in enumerate(steps_data):
        # add step file present indicator to step
        steps_data[index]['file_present'] = False
        steps_data[index]['sql_statement'] = "/* ERROR : no steps found for this step */"
        # print step:
        print(f"Step: {step}")
        # get file name from step['file_name']
        file_name = step.get('file_name', None)
        print(f"File Name: {file_name}")
        
        # if file_name is None:
        if file_name is None or not isinstance(file_name, str):
            logging.error(
                "File name in step %s is None or not a string. Skipping this step.",
                step,
            )
            continue
        file_name = file_name.strip()
        # if file name like nan
        if re.match(r'^\s*nan\s*$', file_name, re.IGNORECASE):
            logging.error(
                "File name in step %s is 'nan'. Skipping this step.",
                step,
            )
            continue
        # remove file extension from file_name
        file_name = os.path.splitext(file_name)[0]
        # check if file_name is in sheet_names
        if file_name not in sheet_names:
            logging.error(
                "File name %s not found in sheet names %s. Skipping this step.",
                file_name,
                sheet_names,
            )
            continue
        # sheet name found in sheet_names , now load the sheet into a DataFrame
        try:
            # make sure 1st row is not header
            # if the first row is not a header, we can set header=None
            df_sheet = pd.read_excel(
                filename_path,
                sheet_name=file_name,
                header=None,  # Load without header
            )
            logging.info(
                "Loaded sheet %s into df_sheet with shape: %s",
                file_name,
                str(df_sheet.shape),
            )
        except (OSError, ValueError) as e:
            logging.error(
                "Error processing file %s: %s",
                filename_path,
                str(e),
            )
            return -1, str(e), None
        # keep only first column
        df_sheet = df_sheet.iloc[:, 0]
        # convert sheet into a single sql statement a new line per row
        sql_statement = df_sheet.dropna().astype(str).str.cat(sep='\n')
        dict_sql_steps[file_name] = sql_statement
        logging.info(
            "SQL statement for file %s: %s",
            file_name,
            sql_statement,
        )
        steps_data[index]['file_present'] = True  # Mark the file as present in the step data
        steps_data[index]['sql_statement'] = sql_statement  # Add SQL statement to step data
        # write sql_statement to a file in sql_path
        if not os.path.exists(sql_path):
            os.makedirs(sql_path)
        sql_file_path = os.path.join(sql_path, f"{file_name}.sql")
        with open(sql_file_path, 'w', encoding='utf-8') as sql_file:
            sql_file.write(sql_statement)
        logging.info(
            "SQL statement written to file %s",
            sql_file_path,
        )

    
    return return_code, return_text, dict_sql_steps


def read_excel_to_dataframe_mapping(filename, config_dict):
    """Read the 'MAPPING' sheet from an Excel file into a pandas DataFrame.
    Args:
        filename (str): The name of the Excel file to read.
        config_dict (dict): Configuration dictionary containing at least the
            'excel_mapping_directory' key, or a nested 'config' key with this information.
    Returns:
        return_code (int): 0 if the operation is successful, -1 otherwise.
        return_text (str): Description of the operation result or error encountered.
        pd.DataFrame: DataFrame containing the data from the 'MAPPING' sheet.
    """
    df_mapping = None
    if config_dict is None:
        logging.error("Configuration dictionary is None. Cannot proceed with reading the Excel file.")
        return -1, "Configuration dictionary is None.", df_mapping
    if 'config' in config_dict:
        config_local = config_dict['config']
    else:
        config_local = config_dict
    if not isinstance(config_local, dict):
        logging.error("Configuration is not in the expected format. Expected a dictionary.")
        return -1, "Configuration is not in the expected format.", df_mapping
    excel_mapping_dir = config_local.get('excel_mapping_directory', 'excel_mappings')
    if not os.path.isdir(excel_mapping_dir):
        logging.error(
            "excel_mapping_directory %s does not exist. Please check your configuration.",
            excel_mapping_dir,
        )
        return -1, "excel_mapping_directory does not exist.", None
    filename_path = os.path.join(excel_mapping_dir, filename)
    if not os.path.exists(filename_path):
        logging.error(
            "File %s does not exist. Please check the file path.",
            filename_path,
        )
        return -1, "File %s does not exist." % filename_path, df_mapping
    try:
        df_mapping = pd.read_excel(
            filename_path,
            sheet_name=0,  # Load the first sheet
        )
        logging.info(
            "Loaded first sheet into df_mapping with shape: %s",
            str(df_mapping.shape),
        )
    except (OSError, ValueError) as e:
        logging.error(
            "Error processing file %s: %s",
            filename_path,
            str(e),
        )
        return -1, str(e), df_mapping  




    return_code = 0
    return_text = "Read successful."
    return return_code, return_text, df_mapping  

def read_excel_to_dataframe_steps(filename, config_dict):
    """    Read the 'Steps' sheet from an Excel file into a pandas DataFrame.
    Args:
        filename (str): The name of the Excel file to read.
        config_dict (dict): Configuration dictionary containing at least the
            'excel_mapping_directory' key, or a nested 'config' key with this information.
    Returns:
        return_code (int): 0 if the operation is successful, -1 otherwise.
        return_text (str): Description of the operation result or error encountered.
        pd.DataFrame: DataFrame containing the data from the 'Steps' sheet.
    """
    df_steps = None
    if config_dict is None:
        logging.error("Configuration dictionary is None. Cannot proceed with reading the Excel file.")
        return -1, "Configuration dictionary is None.", df_steps
    if 'config' in config_dict:
        config_local = config_dict['config']
    else:
        config_local = config_dict
    
    if not isinstance(config_local, dict):
        logging.error("Configuration is not in the expected format. Expected a dictionary.")
        return -1, "Configuration is not in the expected format.", df_steps
    excel_mapping_dir = config_local.get('excel_mapping_directory', 'excel_mappings')
    if not os.path.isdir(excel_mapping_dir):
        logging.error(
            "excel_mapping_directory %s does not exist. Please check your configuration.",
            excel_mapping_dir,
        )
        return -1, "excel_mapping_directory does not exist.", df_steps
    filename_path = os.path.join(excel_mapping_dir, filename)
    if not os.path.exists(filename_path):
        logging.error(
            "File %s does not exist. Please check the file path.",
            filename_path,
        )
        return -1, "File %s does not exist." % filename_path, df_steps
    try:
        df_steps = pd.read_excel(
            filename_path,
            sheet_name='Steps',
        )
        logging.info(
            "Loaded 'Steps' sheet into df_steps with shape: %s",
            str(df_steps.shape),
        )
    except (OSError, ValueError) as e:
        logging.error(
            "Error processing file %s: %s",
            filename_path,
            str(e),
        )
        return -1, str(e), df_steps
    # now covert all column names to lowercase
    df_steps.columns = [col.lower() for col in df_steps.columns]
    # remove trailing and leading whitespace from column names
    df_steps.columns = df_steps.columns.str.strip()
    # change spaces to underscores in column names
    df_steps.columns = df_steps.columns.str.replace(' ', '_', regex=False)
    logging.info(
        "Steps: Columns %s",
        str(df_steps.columns)
    )
    # Remove empty rows from df_steps
    df_steps = df_steps.dropna(how='all')
    logging.info(
        "After dropping empty rows, df_steps shape: %s",
        str(df_steps.shape),
    )
    # confert all columns to string type
    df_steps = df_steps.astype(str)
    # convert NaN values to empty strings
    df_steps = df_steps.fillna('')
    # if string column = 'nan' then replace with empty string
    df_steps = df_steps.replace(r'^\s*nan\s*$', '', regex=True)

    # add sequence_no column which is is the sequence of steps starting from 1
    df_steps['sequence_no'] = range(1, len(df_steps) + 1)
    # now add the reverse sequence_no column
    df_steps['reverse_sequence_no'] = df_steps['sequence_no'].max() - df_steps['sequence_no'] + 1
    # if column 'stats' does not exist add it
    if 'stats' not in df_steps.columns:
        logging.warning(
            "Column 'stats' is missing in the 'Steps' sheet. Adding it with default value ''."
        )
        df_steps['stats'] = ''

    # post_sql does not exist then add it
    if 'post_sql' not in df_steps.columns:
        logging.warning(
            "Column 'post_sql' is missing in the 'Steps' sheet. Adding it with default value ''."
        )
        df_steps['post_sql'] = ''
    # pre_sql does not exist then add it
    if 'pre_sql' not in df_steps.columns:
        logging.warning(
            "Column 'pre_sql' is missing in the 'Steps' sheet. Adding it with default value ''."
        )
        df_steps['pre_sql'] = ''

    return 0, "Read successful.", df_steps


def validate_mapping_sheet(filename, config_dict):
    """
    Validate the structure and contents of an Excel mapping sheet file.

    Checks for the existence of the specified Excel file, verifies that it contains
    the required sheets ('MAPPING' and 'Steps'), and ensures that these sheets are not empty.
    Also checks that the 'MAPPING' sheet contains all required columns:
    'Job Name', 'Database Name', 'Table Name', and 'Pattern'.
    Detailed logging is performed throughout the validation process.

    Args:
        filename (str): The name of the Excel file to validate.
        config_dict (dict): Configuration dictionary containing at least the
            'excel_mapping_directory' key, or a nested 'config' key with this information.

    Returns:
        tuple: (return_code, return_text)
            return_code (int): 0 if validation is successful, -1 otherwise.
            return_text (str): Description of the validation result or error encountered.
    """
    return_code = 0
    return_text = ''
    mapping_sheet_name = None

    # Load Excel and get all sheet names
    config_local = config_dict.get('config', config_dict)
    filename_path = (
        config_local.get('excel_mapping_directory', 'excel_mappings')
        + '/'
        + filename
    )
    if not os.path.exists(filename_path):
        logging.error(
            "File %s does not exist. Please check the file path.",
            filename_path,
        )
        return -1, "File %s does not exist." % filename_path

    try:
        excel_file = pd.ExcelFile(filename_path)
        sheet_names = excel_file.sheet_names
        logging.info(
            "Sheet names in %s: %s",
            filename_path,
            sheet_names,
        )
        if 'Steps' not in sheet_names:
            logging.error(
                "'Steps' sheet not found in %s. Please ensure the sheet exists.",
                filename_path,
            )
            return -1, "'Steps' sheet not found."
    except (OSError, ValueError) as e:
        logging.error(
            "Error loading Excel file %s: %s",
            filename_path,
            str(e),
        )
        return -1, str(e)

    if 'MAPPING' not in sheet_names:
        logging.error(
            "'MAPPING' sheet not found in %s. Please ensure the sheet exists.",
            filename_path,
        )
        return -1, "'MAPPING' sheet not found."

    try:
        df_mapping_local = pd.read_excel(
            filename_path,
            sheet_name=0,
        )
        mapping_sheet_name = sheet_names[0]
        logging.info(
            "Loaded first sheet into df_mapping with shape: %s",
            str(df_mapping_local.shape),
        )
        # Load 'Steps' sheet into df_steps
        df_steps_local = pd.read_excel(
            filename_path,
            sheet_name='Steps',
        )
        logging.info(
            "Loaded 'Steps' sheet into df_steps with shape: %s",
            str(df_steps_local.shape),
        )
    except (OSError, ValueError) as e:
        logging.error(
            "Error processing file %s: %s",
            filename_path,
            str(e),
        )
        return -1, str(e)

    # Check if df_steps_local is None
    if df_steps_local is None:
        logging.error(
            "'Steps' sheet in %s is empty or could not be loaded. Please check the file.",
            filename_path,
        )
        return -1, "'Steps' sheet is empty or could not be loaded."
    # Remove empty rows from df_steps_local
    df_steps_local = df_steps_local.dropna(how='all')  
    logging.info(
        "After dropping empty rows, df_steps shape: %s",
        str(df_steps_local.shape),
    )
    # check if df_steps_local has required columns
    required_steps_columns = ['Job Name', 'Database Name', 'Table Name', 'Pattern']
    logging.info("Steps: Columns %s",
    str(df_steps_local.columns)
    )


    # Validate the mapping sheet
    if df_mapping_local.empty:
        logging.error(
            "Mapping sheet %s in %s is empty. Please check the file.",
            mapping_sheet_name,
            filename_path,
        )
        return -1, "Mapping sheet is empty."
    if df_steps_local.empty:
        logging.error(
            "'Steps' sheet in %s is empty. Please check the file.",
            filename_path,
        )
        return -1, "'Steps' sheet is empty."



    logging.info(
        "Validation successful for %s.",
        filename_path,
    )
    return 0, "Validation successful."

def convert_excel_to_yaml(filename, config_dict):
    """
    Convert an Excel mapping sheet to a YAML file.

    Args:
        filename (str): The name of the Excel file to convert.
        config_dict (dict): Configuration dictionary containing at least the
            'excel_mapping_directory' key, or a nested 'config' key with this information.

    Returns:
        str: Path to the generated YAML file.
    """
    yaml_dict = {}
    return_code = 0
    return_text = ''
    if config_dict is None:
        logging.error("Configuration dictionary is None. Cannot proceed with conversion.")
        retcode = -1
        return_code = "Configuration dictionary is None."
        return return_code, return_text
    if 'config' in config_dict:
        config_local = config_dict['config']
    else:
        config_local = config_dict
    
    if not isinstance(config_local, dict):
        logging.error("Configuration is not in the expected format. Expected a dictionary.")
        return -1, "Configuration is not in the expected format."
    excel_mapping_dir = config_local.get('excel_mapping_directory', 'excel_mappings')
    if not os.path.isdir(excel_mapping_dir):
        logging.error(
            "excel_mapping_directory %s does not exist. Please check your configuration.",
            excel_mapping_dir,
        )
        return -1, "excel_mapping_directory does not exist."

    # load the Excel file
    return_code, return_text ,df_steps = read_excel_to_dataframe_steps(filename, config_dict)
    if return_code != 0:
        logging.error(
            "Error reading Excel file %s: %s",
            filename,
            return_text,
        )
        return -1, return_text

    # load the mapping sheet
    return_code, return_text, df_mapping = read_excel_to_dataframe_mapping(filename, config_dict)
    if return_code != 0:
        logging.error(
            "Error reading mapping sheet from %s: %s",
            filename,
            return_text,
        )
        return -1, return_text
    if df_mapping is None:
        logging.error(
            "Mapping sheet could not be loaded from %s. Please check the file.",
            filename,
        )
        return -1, "Mapping sheet could not be loaded from %s." % filename
    # check if mapping sheet has required columns



 

    # Get job id from name , it is the characters before the first underscore
    job_name_from_file = filename.split('_')[0]
    if not job_name_from_file:
        logging.error(
            "Could not extract job name from filename %s. Please check the file name format.",
            filename,
        )
        return -1, "Could not extract job name from filename."
    # get job from mapping spreadsheet B3
    job_name_from_mapping = df_mapping.iloc[1, 1] if len(df_mapping) > 2 else None
    if not job_name_from_mapping:
        logging.error(
            "Could not extract job name from mapping sheet %s in %s. Please check the file.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Could not extract job name from mapping sheet."
    # Target Database Name B4
    target_database_name = df_mapping.iloc[2, 1] if len(df_mapping) > 3 else None
    if not target_database_name:
        logging.error(
            "Could not extract target database name from mapping sheet %s in %s. Please check the file.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Could not extract target database name from mapping sheet."
    # Target Table Name B5
    target_table_name = df_mapping.iloc[3, 1] if len(df_mapping) > 4 else None
    if not target_table_name:
        logging.error(
            "Could not extract target table name from mapping sheet %s in %s. Please check the file.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Could not extract target table name from mapping sheet."
    # Pattern B6
    pattern = df_mapping.iloc[4, 1] if len(df_mapping) > 5 else None
    if not pattern:
        logging.error(
            "Could not extract pattern from mapping sheet %s in %s. Please check the file.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Could not extract pattern from mapping sheet."
    # Control Columns B10
    control_columns = df_mapping.iloc[9, 1] if len(df_mapping) > 9 else None
    if not control_columns:
        logging.error(
            "Could not extract control columns from mapping sheet %s in %s. Please check the file.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Could not extract control columns from mapping sheet."
    # Primary Key D3
    primary_key = df_mapping.iloc[1, 3] if len(df_mapping) > 2 else None
    # primary must be a string with comma separated values
    if not primary_key:
        logging.error(
            "Could not extract primary key from mapping sheet %s in %s. Please check the file.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Could not extract primary key from mapping sheet."
    # Check if primary key is a string with comma separated values
    if not isinstance(primary_key, str):
        logging.error(
            "Primary key in mapping sheet %s in %s is not a string. Please check the file. Value: %s",
            mapping_sheet_name,
            filename,
            str(primary_key),
        )
        return -1, "Primary key is not a string."
    # Convert Primay Key to string and strip whitespace
    primary_key = primary_key.strip()
    # Convert Primary Key to a list
    primary_key_list = [pk.strip() for pk in primary_key.split(',')] if primary_key else []
    if not primary_key_list:
        logging.error(
            "Primary key is empty or not in the expected format in mapping sheet %s in %s.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Primary key is empty or not in the expected format."

    # Transformation Key D4
    transformation_key = df_mapping.iloc[2, 3] if len(df_mapping) > 3 else None
    print(f"Mapping Head: \n{df_mapping.head(4)}")
    print(f"Transformation Key: {transformation_key}")
    if not transformation_key:
        logging.error(
            "Could not extract transformation key from mapping sheet %s in %s. Please check the file.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Could not extract transformation key from mapping sheet."
    # convert transformation key to string and strip whitespace
    transformation_key = str(transformation_key).strip()


    mapping_sheet_name = "MAPPING"  # Default mapping sheet name
    # convert df_steps to a list of dictionaries
    steps_data = df_steps.to_dict(orient='records') if df_steps is not None else []
    # get a subset df_mapping 
    df_mapping_detail = df_mapping.iloc[12:, :4] if len(df_mapping) > 12 else df_mapping
    print(f"Mapping Detail: \n{df_mapping_detail.head(4)}")
    # Check if df_mapping_detail[0,0] = 'Column Order' if not return error
    if df_mapping_detail.empty or df_mapping_detail.iloc[0, 0] != 'Column Order':
        logging.error(
            "Mapping sheet %s in %s does not have the expected structure. "
            "The first cell should contain 'Column Order'.",
            mapping_sheet_name,
            filename,
        )
    
    # convert row 0 to column names
    df_mapping_detail.columns = df_mapping_detail.iloc[0]
    # make column names lowercase , trim and change whitespace to underscore
    df_mapping_detail.columns = df_mapping_detail.columns.str.lower().str.strip().str.replace(' ', '_', regex=False)
    # remove row 0
    df_mapping_detail = df_mapping_detail[1:]
    # reset index
    df_mapping_detail.reset_index(drop=True, inplace=True)
    # remove empty rows
    df_mapping_detail = df_mapping_detail.dropna(how='all')
    # convert all columns to string type
    df_mapping_detail = df_mapping_detail.astype(str)
    # convert NaN values to empty strings
    df_mapping_detail = df_mapping_detail.fillna('')
    # convert to list of dictionaries

    # if column column_action is missing then add it
    if 'column_action' not in df_mapping_detail.columns:
        logging.warning(
            "Column 'column_action' is missing in the mapping detail. "
            "Adding it with default value ''."
        )
        df_mapping_detail['column_action'] = ''
    # convert to column column_action to values to lower case
    df_mapping_detail['column_action'] = df_mapping_detail['column_action'].str.lower()
    # set nan values in columns to empty string
    df_mapping_detail = df_mapping_detail.fillna('')
    # add column sequence to the mapping detail and populate with column_sequence starting from 1
    if 'column_sequence' not in df_mapping_detail.columns:
        logging.warning(
            "Column 'column_sequence' is missing in the mapping detail. "
            "Adding it with default value ''."
        )
        df_mapping_detail['column_sequence'] = ''
    # set column_sequence to the index + 1
    df_mapping_detail['column_sequence'] = df_mapping_detail.index + 1
    # now create a reverse order sequence for column_sequence_reverse
    df_mapping_detail['column_sequence_reverse'] = df_mapping_detail['column_sequence'].max() - df_mapping_detail['column_sequence'] + 1

    data_mapping_detail = df_mapping_detail.to_dict(orient='records')
    # delete any row in column_action = mapping
    data_mapping_detail = [row for row in data_mapping_detail if row['column_action'] != 'mapping']

    print(f"Mapping Detail: \n{df_mapping_detail.head(4)}")
    
    return_code, return_text,dict_steps_sql = read_excel_to_dataframe_sql_steps(filename, config_dict,df_steps,steps_data)
    if return_code != 0:
        logging.error(
            "Error reading SQL steps from %s: %s",
            filename,
            return_text,
        )
        return -1, return_text
        
    # Convert Transformation Key to a list
    transformation_key_list = [tk.strip() for tk in transformation_key.split(',')] if transformation_key else []
    try:
        yaml_dict['mapping_sheet_name'] = mapping_sheet_name
        yaml_dict['job_name_from_file'] = job_name_from_file
        yaml_dict['job_name_from_mapping'] = job_name_from_mapping
        yaml_dict['target_database_name'] = target_database_name
        yaml_dict['target_table_name'] = target_table_name
        yaml_dict['pattern'] = pattern
        yaml_dict['control_columns'] = control_columns
        yaml_dict['primary_key'] = primary_key_list
        yaml_dict['transformation_key'] = transformation_key_list
        yaml_dict['mapping_columns'] = data_mapping_detail
        yaml_dict['mapping_columns_count'] = len(data_mapping_detail)
        yaml_dict['sql_steps'] = dict_steps_sql
 
        #yaml_dict['mapping_data'] = df_mapping.to_dict(orient='records')
        yaml_dict['steps'] = steps_data
        yaml_path = config_local.get('mapping_yaml_path', 'mapping_yaml')
        # yaml file name is the same as excel file name but with .yaml extension
        # get the base name of the file without extension
        base_filename = os.path.splitext(filename)[0]
        yaml_file_path = os.path.join(yaml_path, f"{base_filename}.yaml")
        with open(yaml_file_path, 'w', encoding='utf-8') as yaml_file:
            yaml.dump(yaml_dict, yaml_file, default_flow_style=False)
        logging.info("Converted %s to %s", filename, yaml_file_path)
    except (OSError, yaml.YAMLError) as e:
        logging.error("Error writing YAML file %s: %s", yaml_file_path, str(e))
        return -1, str(e)

    return 0, f"Converted successfully to YAML file: {yaml_file_path}"

###############################################################################################
# Function to validate and convert Excel mapping sheets to YAML files
def build_job(filename, config_dict):
    """
    Validate and convert an Excel mapping sheet to a YAML file.

    Args:
        filename (str): The name of the Excel file to validate and convert.
        config_dict (dict): Configuration dictionary containing at least the
            'excel_mapping_directory' key, or a nested 'config' key with this information.

    Returns:
        tuple: (return_code, return_text)
            return_code (int): 0 if validation and conversion are successful, -1 otherwise.
            return_text (str): Description of the operation result or error encountered.
    """
    # this is a place holder to build a job
    logging.info("Starting to process file: %s", filename)
    # get job directory from config
    config_local = config_dict 
    if config_dict is None:
        logging.error("Configuration dictionary is None. Cannot proceed with processing the file.")
        return -1, "Configuration dictionary is None."
    if 'config' in config_local:
        config_local = config_dict['config']
    else:
        config_local = config_dict
    if not isinstance(config_local, dict):
        logging.error("Configuration is not in the expected format. Expected a dictionary.")
        return -1, "Configuration is not in the expected format."
    # job_path = config_local.get('job_path', 'jobs')
    job_path = config_local.get('job_path', 'job_path')
    # mapping yaml_path = config_local.get('mapping_yaml_path', 'mapping_yaml')
    mapping_yaml_path = config_local.get('mapping_yaml_path', 'mapping_yaml')
    if not os.path.isdir(job_path):
        logging.error(
            "Job path %s does not exist. Please check your configuration.",
            job_path,
        )
        return -1, "Job path does not exist."
    if not os.path.isdir(mapping_yaml_path):
        logging.error(
            "Mapping YAML path %s does not exist. Please check your configuration.",
            mapping_yaml_path,
        )
        return -1, "Mapping YAML path does not exist."
    # convert the Excel file name to a YAML file name
    yaml_file_name = os.path.splitext(filename)[0] + '.yaml'
    yaml_file_path = os.path.join(mapping_yaml_path, yaml_file_name)
    # Check if the YAML file exists
    if not os.path.exists(yaml_file_path):
        logging.error(
            "YAML file %s does not exist. Please check the file path.",
            yaml_file_path,
        )
        return -1, "YAML file does not exist."
    # check that job_path is a directory
    if not os.path.isdir(job_path):
        logging.error(
            "Job path %s is not a directory. Please check your configuration.",
            job_path,
        )
        return -1, "Job path is not a directory."
    # Convert yaml file to job 
    # load the YAML file
    try:
        with open(yaml_file_path, 'r', encoding='utf-8') as yaml_file:
            yaml_dict = yaml.safe_load(yaml_file)
        if yaml_dict is None:
            logging.error(
                "YAML file %s is empty or could not be loaded. Please check the file.",
                yaml_file_path,
            )
            return -1, "YAML file is empty or could not be loaded."
        logging.info("Loaded YAML file %s successfully.", yaml_file_path)
    except (OSError, yaml.YAMLError) as e:
        logging.error(
            "Error loading YAML file %s: %s",
            yaml_file_path,
            str(e),
        )
        return -1, str(e)
    # job_dict is yaml_dict with additional fields
    job_dict = {
        'job_name': yaml_dict.get('job_name_from_mapping', 'OOPS101'),
        'job_description': yaml_dict.get('job_name_from_file', 'OOPS101'),
        'yaml_file_path': yaml_file_path,
    }
    # create a job file name
    job_file_name = f"{job_dict['job_name']}.job"
    job_file_path = os.path.join(job_path, job_file_name)
    # A job consists of multiple templates used in sequence
    # 1. Job header template 
    # 2. Job steps template - each step has a template
    # 3. Job footer template
    # Load the Jinja2 templates
    template_dir = config_local.get('template_directory', 'templates')
    if not os.path.isdir(template_dir):
        logging.error(
            "Template directory %s does not exist. Please check your configuration.",
            template_dir,
        )
        return -1, "Template directory does not exist."
    # Load the Jinja2 environment
    try:
        env = jinja2.Environment(loader=jinja2.FileSystemLoader(template_dir))
    except jinja2.exceptions.TemplateNotFound as e:
        logging.error(
            "Error loading Jinja2 templates from %s: %s",
            template_dir,
            str(e),
        )
        return -1, str(e)
    # Load the job header template
    try:
        job_header_template = env.get_template('job_header.j2')
    except jinja2.exceptions.TemplateNotFound as e:
        logging.error(
            "Job header template not found in %s: %s",
            template_dir,
            str(e),
        )
        return -1, str(e)
    # Job header template rendering
    try:
        job_header_rendered = job_header_template.render(yaml_dict,job_dict=job_dict,config=config_local)
    except jinja2.exceptions.TemplateError as e:
        logging.error(
            "Error rendering job header template: %s",
            str(e),
        )
        return -1, str(e)
    

    steps_rendered = []

    # Load the job steps template:$
    for step in yaml_dict.get('steps', []):
        step_pattern = step.get('step_pattern', 'default_step.j2')
        if not step_pattern.endswith('.j2'):
            step_pattern += '.j2'
        step_template_name = 'JOB_' + step_pattern
        try:
            step_template = env.get_template(step_template_name)
        except jinja2.exceptions.TemplateNotFound as e:
            logging.error(
                "Step template %s not found in %s: %s",
                step_template_name,
                template_dir,
                str(e),
            )
            return -1, str(e)
        # Render the step template
        try:
            step_rendered = step_template.render(step=step, mapping=yaml_dict, job_dict=job_dict, config=config_local)
            # Append the rendered step to the job header
            job_header_rendered += step_rendered
        except jinja2.exceptions.TemplateError as e:
            logging.error(
                "Error rendering step template %s: %s",
                step_template_name,
                str(e),
            )
            return -1, str(e)
    # Load the job footer template
    try:
        job_footer_template = env.get_template('job_footer.j2')
    except jinja2.exceptions.TemplateNotFound as e:
        logging.error(
            "Job footer template not found in %s: %s",
            template_dir,
            str(e),
        )
        return -1, str(e)
    # Job footer template rendering
    try:
        job_footer_rendered = job_footer_template.render(yaml_dict, job_dict=job_dict
, config=config_local)
    except jinja2.exceptions.TemplateError as e:
        logging.error(
            "Error rendering job footer template: %s",
            str(e),
        )
        return -1, str(e)
    # temporary write job file
    try:
        with open(job_file_path, 'w', encoding='utf-8') as job_file:
            # Write the job header
            job_file.write(job_header_rendered)
            # Write the job steps
            for step in steps_rendered:
                job_file.write(step)
            # Write the job footer
            job_file.write(job_footer_rendered)

        logging.info("Created job file %s successfully.", job_file_path)
    except (OSError, yaml.YAMLError) as e:
        logging.error(
            "Error writing job file %s: %s",
            job_file_path,
            str(e),
        )
        return -1, str(e)
    # Now build the steps in the job file
    # This is a placeholder for building the job steps
    for step in yaml_dict.get('steps', []):
        step_name = step.get('step_name', 'default_step')
        step_pattern = step.get('step_pattern', 'default_step.j2')
        if step_pattern == 'STANDARD_START':
            logging.info("Skipping step: %s (STANDARD_START)", step_name)
            continue
        if step_pattern == 'STANDARD_END':
            logging.info("Skipping step: %s (STANDARD_END)", step_name)  
            continue
        # step template file name
        if not step_pattern.endswith('.j2'):
            step_pattern += '.j2'
        step_template_name = 'STEP_' + step_pattern
        try:
            step_template = env.get_template(step_template_name)
            # Render the step template
            step['build_date'] = datetime.now().strftime('%Y-%m-%d')
            step['build_time'] = datetime.now().strftime('%H:%M:%S')
            step_rendered = step_template.render(step=step, mapping=yaml_dict, job_dict=job_dict, config=config_local)
        except jinja2.exceptions.TemplateNotFound as e:
            logging.error(
                "Step template %s not found in %s: %s",
                step_template_name,
                template_dir,
                str(e),
            )
            return -1, str(e)

        print("Processing step: %s with pattern: %s", step_name, step_pattern   )
        logging.info("Processing step: %s", step_name)
        # Here you would implement the logic to build each step
        # For now, we just log the step details
        # Get step directory from config
        step_directory = config_local.get('steps_path', 'steps')
        if not os.path.isdir(step_directory):
            logging.error(
                "Step directory %s does not exist. Please check your configuration.",
                step_directory,
            )
            return -1, "Step directory does not exist."
        step_file_path = os.path.join(step_directory, step['file_name'])
        # Write the step to a file
        try:
            with open(step_file_path, 'w', encoding='utf-8') as step_file:
                step_file.write(step_rendered)
        except (OSError, yaml.YAMLError) as e:
            logging.error(
                "Error writing step file %s: %s",
                step_file_path,
                str(e),
            )
            return -1, str(e)
        logging.info("Step details: %s", pprint.pformat(step))
    logging.info("Successfully processed %s", filename)
    return 0, "Successfully processed."

###########################################################################################
# Main function to validate and convert Excel mapping sheets to YAML files
###########################################################################################
if __name__ == "__main__":
    # Set up logging configuration
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(filename)s:%(lineno)d - %(message)s'
    )
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)

    # Load configuration from YAML file
    config_path = 'config.yaml'
    if not os.path.exists(config_path):
        logger.error("Config file %s does not exist. Please create it with your configuration details.", config_path)
        exit(1)

    with open(config_path, 'r') as file:
        config = yaml.safe_load(file)
    
    if not config or not isinstance(config, dict):
        logger.error("Config file %s is empty or not in the expected format.", config_path)
        exit(1)
    
    if 'config' in config:
        config = config['config']
    else:
        logger.error("Config file %s does not contain 'config' key. Please check the file format.", config_path)
        exit(1)

    logger.info("Configuration loaded successfully.")
    logger.info("Config: %s", pprint.pformat(config))

    # Process the Excel files and convert them to YAML files
    # (This part of the code would be implemented here)
    excel_mapping_directory = config.get('excel_mapping_directory', 'excel_mappings')
    if not os.path.isdir(excel_mapping_directory):
        logger.error("excel_mapping_directory %s does not exist. Please check your configuration.", excel_mapping_directory)
        exit(1)
    mapping_files = glob.glob(os.path.join(excel_mapping_directory, '*MAPPING.xlsx'))
    if not mapping_files:
        logger.error("No mapping files found in %s. Please check your configuration.", excel_mapping_directory)
        exit(1)
    logger.info("Found mapping files: %s", mapping_files)
    #for mapping_file in mapping_files:
    #    logger.info("Processing mapping file: %s", mapping_file)
    #    try:
    #        df_mapping = pd.read_excel(mapping_file, sheet_name=0)
    #        mapping_sheet_name = pd.ExcelFile(mapping_file).sheet_names[0]
    #        logger.info("Mapping sheet name: %s", mapping_sheet_name)
    #        logger.info("Loaded first sheet into df_mapping with shape: %s", df_mapping.shape)

            # Load 'Steps' sheet into df_steps
    #        df_steps = pd.read_excel(mapping_file, sheet_name='Steps')
    #        logger.info("Loaded 'Steps' sheet into df_steps with shape: %s", df_steps.shape)

    #    except Exception as e:
    #        logger.error("Error processing file %s: %s", mapping_file, e)
    job_name = 'FND1010'  # Example job name
    logger.info("Starting conversion and job building for %s", job_name)
    excel_name = f"{job_name}_MAPPING.xlsx"
    ret_code, ret_text = convert_excel_to_yaml(excel_name, config)
    if ret_code != 0:
        logger.error("Failed to convert Excel to YAML: %s", ret_text)
        exit(1)
    ret_code, ret_text = build_job(excel_name, config)
    if ret_code != 0:
        logger.error("Failed to build job: %s", ret_text)
        exit(1)
    print(f"Conversion and job {job_name} building completed successfully.")



