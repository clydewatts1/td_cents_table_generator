import os
import yaml
from pathlib import Path
import sys
import glob
import pandas as pd

list_of_mapping_sheets_summary = []

def validate_mapping_sheet(filename,mapping_sheet_name,df,df_steps=None):
    """
    Validate the mapping sheet DataFrame.
    This function checks for required columns and basic data integrity.
    """
    global list_of_mapping_sheets_summary
    # 4B into databasename
    df = df.rename(columns=lambda x: x.strip())  # Strip whitespace from column names
    #print(df.head(4))
    job_name = df.iloc[1,1]
    database_name = df.iloc[2,1 ]
    table_name = df.iloc[3, 1]
    pattern = df.iloc[4, 1]
    # remove path from filename
    filename = os.path.basename(filename)  # Get just the file name without the path
    # get job name from filename , that is <jobname>_MAPPING.xlsx
    job_name_filename = filename.split('_')[0] if '_' in filename else filename.split('.')[0]  # Get job name from filename
    if job_name_filename != job_name:
        job_name_status = 'BAD'
    else:
        job_name_status = ''
    if mapping_sheet_name != 'MAPPING' and mapping_sheet_name != job_name_filename :
        mapping_sheet_status = 'BAD'
    else:
        mapping_sheet_status = ''
    # Start validating steps
    steps_job_name_status = ''
    for index, row in df_steps.iterrows():
        print(f"Validating step {index + 1}: {row.to_dict()}")
        if job_name_filename != row['Job Name']:
            steps_job_name_status = 'BAD'
            print(f"Step {index + 1} Job Name does not match: {row['Job Name']} != {job_name_filename}")
    print(f"File Name: {filename} Mapping Sheet : {mapping_sheet_name} Job Name: {job_name}, Database Name: {database_name}, Table Name: {table_name}, Pattern: {pattern} Job Name Status: {job_name_status}, Mapping Sheet Status: {mapping_sheet_status}")
    list_of_mapping_sheets_summary.append([filename,job_name_filename, mapping_sheet_name, job_name, database_name, table_name, pattern,job_name_status,mapping_sheet_status,steps_job_name_status])

#------------------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------------------
# Load config.yaml from the script directory (local directory)
config_path = Path(__file__).parent / "config.yaml"
if not config_path.exists():
    print(f"Config file {config_path} does not exist. Please create it with your configuration details.")
    sys.exit(1)
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


# Assign excel_mapping_directory from config
excel_mapping_directory = config['excel_mapping_directory']
# Check if the directory exists
if not os.path.isdir(excel_mapping_directory):
    print(f"excel_mapping_directory {excel_mapping_directory} does not exist. Please check your configuration.")
    sys.exit(1)

# Loop through all mapping*.xlsx files in excel_mapping_directory

mapping_files = glob.glob(os.path.join(excel_mapping_directory, '*MAPPING.xlsx'))
for mapping_file in mapping_files:
    print(f"Found mapping file: {mapping_file}")
    # Load first sheet into df_mapping
    df_mapping = pd.read_excel(mapping_file, sheet_name=0)
    # get a list of sheets from excel file
    mapping_sheet_name = pd.ExcelFile(mapping_file).sheet_names[0]
    print(f"Mapping sheet name: {mapping_sheet_name}")
    print(f"Loaded first sheet into df_mapping with shape: {df_mapping.shape}")
    # Load 'Steps' sheet into df_steps
    try:
        df_steps = pd.read_excel(mapping_file, sheet_name='Steps')
        print(f"Loaded 'Steps' sheet into df_steps with shape: {df_steps.shape}")
    except Exception as e:
        print(f"Could not load 'Steps' sheet from {mapping_file}: {e}")
    # df_steps remove empty rows
    if df_steps is not None:
        df_steps = df_steps.dropna(how='all')
        print(f"After dropping empty rows, df_steps shape: {df_steps.shape}")
    validate_mapping_sheet(mapping_file, mapping_sheet_name, df_mapping, df_steps)
# write the summary to excel  file
# Update columns to match the 7 values appended
summary_df = pd.DataFrame(
    list_of_mapping_sheets_summary,
    columns=[
        'File Name',
        'Job Name (from Filename)',
        'Mapping Sheet',
        'Job Name',
        'Database Name',
        'Table Name',
        'Pattern',
        'Job Name Status',
        'Mapping Sheet Status',
        'Steps Job Name Status'
    ]
)
# save the summary to an Excel file
output_summary_file = os.path.join(excel_mapping_directory, 'mapping_sheets_summary.xlsx')
summary_df.to_excel(output_summary_file, index=False)
print(f"Summary written to {output_summary_file}")