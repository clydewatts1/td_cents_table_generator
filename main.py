import yaml
import os
import json
import re
import requests
import logging
import time
import random
import string
import base64
import pprint
import glob
import pandas as pd
import openpyxl
from excel_handler import read_excel_files_and_convert_to_yaml_files
from excel_handler import validate_ddl_excel_files
from ddl_generator import generate_ddl_from_yaml_files


# Set up logging configuration
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(filename)s:%(lineno)d - %(message)s'
)
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# Load configuration from YAML file
def load_config(file_path):
    with open(file_path, 'r') as file:
        return yaml.safe_load(file)
    
# Save configuration to YAML file
def save_config(file_path, config):
    with open(file_path, 'w') as file:
        yaml.safe_dump(config, file)


def main():
    # Load configuration
    config = load_config('config.yaml')
    if not config:
        logger.error("Failed to load configuration.")
        return
    if not isinstance(config, dict):
        logger.error("Configuration is not in the expected format.")
        return
    config = config.get('config', {})
    if not config:
        logger.error("Configuration is empty or not in the expected format.")
        return
    logger.info("Configuration loaded successfully.")
    logger.info("Config: %s", pprint.pformat(config))
    # validate excel files
    validate_ddl_excel_files(config)
    
    # Read Excel files and convert them to YAML files
    read_excel_files_and_convert_to_yaml_files(config)

    # Process the YAML files
    generate_ddl_from_yaml_files(config)

if __name__ == "__main__":
    main()