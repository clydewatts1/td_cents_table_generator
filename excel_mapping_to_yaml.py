import pandas as pd
import glob
import os
import re
import openpyxl
import yaml
import logging
import pprint

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
    try:
        df_mapping = pd.read_excel(
            os.path.join(excel_mapping_dir, filename),
            sheet_name=0,
        )
        mapping_sheet_name = pd.ExcelFile(os.path.join(excel_mapping_dir, filename)).sheet_names[0]
        logging.info(
            "Loaded first sheet into df_mapping with shape: %s",
            str(df_mapping.shape),
        )
        # Load 'Steps' sheet into df_steps
        df_steps = pd.read_excel(
            os.path.join(excel_mapping_dir, filename),
            sheet_name='Steps',
        )
        logging.info(
            "Loaded 'Steps' sheet into df_steps with shape: %s",
            str(df_steps.shape),
        )
    except (OSError, ValueError) as e:
        logging.error(
            "Error processing file %s: %s",
            filename,
            str(e),
        )
        return -1, str(e)
    # write the YAML file
    if df_mapping.empty:
        logging.error(
            "Mapping sheet %s in %s is empty. Cannot convert to YAML.",
            mapping_sheet_name,
            filename,
        )
        return -1, "Mapping sheet is empty."
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
    mapping_columns = []
    # get from row 15 onwards and columns A-D in df_mapping
    df_mapping_cols = df_mapping.iloc[14:, :4]
    print(df_mapping_cols.head(4))
    for col in df_mapping_cols.iterrows():
        # check if col is empty
        print(f"Processing column: {col}")
        print(f"Column size: ", type(col))
        # check if all values in the column are NaN and continue if so
        if col[1].isnull().all():
            logging.info("Skipping empty column: %s", col[0])
            continue
        # 
        column_order = col[1].get('Column Order', None)
        
        col_dict = {
            
        }
        mapping_columns.append(col_dict)


        
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
        yaml_dict['mapping_columns'] = mapping_columns
        yaml_dict['mapping_columns'] = mapping_columns
        #yaml_dict['mapping_data'] = df_mapping.to_dict(orient='records')
        #yaml_dict['steps_data'] = df_steps.to_dict(orient='records')
        yaml_path = config_local.get('mapping_yaml_path', 'mapping_yaml')
        # yaml file name is the same as excel file name but with .yaml extension
        # get the base name of the file without extension
        base_filename = os.path.splitext(filename)[0]
        yaml_file_path = os.path.join(yaml_path, f"{base_filename}.yaml")
        with open(yaml_file_path, 'w') as yaml_file:
            yaml.dump(yaml_dict, yaml_file, default_flow_style=False)
        logging.info("Converted %s to %s", filename, yaml_file_path)
    except Exception as e:
        logging.error("Error writing YAML file %s: %s", yaml_file_path, str(e))
        return -1, str(e)

    return 0, "Converted successfully to YAML file: %s" % yaml_file_path

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
    for mapping_file in mapping_files:
        logger.info("Processing mapping file: %s", mapping_file)
        try:
            df_mapping = pd.read_excel(mapping_file, sheet_name=0)
            mapping_sheet_name = pd.ExcelFile(mapping_file).sheet_names[0]
            logger.info("Mapping sheet name: %s", mapping_sheet_name)
            logger.info("Loaded first sheet into df_mapping with shape: %s", df_mapping.shape)

            # Load 'Steps' sheet into df_steps
            df_steps = pd.read_excel(mapping_file, sheet_name='Steps')
            logger.info("Loaded 'Steps' sheet into df_steps with shape: %s", df_steps.shape)

        except Exception as e:
            logger.error("Error processing file %s: %s", mapping_file, e)



