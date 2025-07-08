import logging
# DDL generation logic here

def generate_ddl_from_yaml_files(configs):
    # get yaml directory from configs
    yaml_dir = configs.get('yaml_dir', 'yaml_files')
    logging.info(f"Processing YAML files in directory: {yaml_dir}")
    # get all yaml files in the directory
