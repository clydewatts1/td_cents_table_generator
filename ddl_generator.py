"""DDL Generator module for processing YAML files and generating DDL statements."""

import logging
import os
import glob
import sys
import yaml
from jinja2 import Environment, FileSystemLoader
import re


######################################################################
# Function: generate_ddl_from_yaml_files
# Description: Main function to process YAML files and generate DDLs.
######################################################################
def generate_ddl_from_yaml_files(configs):
    """
    Generate DDL statements from all YAML files in a specified directory.

    Args:
        configs (dict): Configuration dictionary containing keys:
            - 'template_path': Path to Jinja template directory (str)
            - 'output_dir': Path to output directory (str)
            - 'yaml_path': Path to YAML files directory (str, optional, default 'yaml')
    Returns:
        None
    """
    # get template directory from config which contains jinja templates
    if not isinstance(configs, dict):
        logging.error(
            "Invalid configuration format. Expected a dictionary, got %s.",
            type(configs).__name__
        )
        return



    yaml_dir = configs.get('yaml_path', 'yaml')
    logging.info(
        "Processing YAML files in directory: %s",
        yaml_dir
    )
    if not os.path.exists(yaml_dir):
        logging.error(
            "YAML directory %s does not exist.",
            yaml_dir
        )
        return
    yaml_files = glob.glob(os.path.join(yaml_dir, '*.yaml'))
    if not yaml_files:
        logging.warning(
            "No YAML files found in directory: %s",
            yaml_dir
        )
        return
    logging.info(
        "Found %d YAML files to process.",
        len(yaml_files)
    )
    for yaml_file in yaml_files:
        logging.info(
            "Processing YAML file: %s",
            yaml_file
        )
        generate_ddl_from_yaml_file(yaml_file, configs)
######################################################################
# Function: generate_ddl_from_yaml_file
# Description: Process a single YAML file and generate DDLs for all builds.
######################################################################
def generate_ddl_from_yaml_file(yaml_file, configs):
    """
    Process a single YAML file and generate DDLs for all builds defined within.

    Args:
        yaml_file (str): Path to the YAML file.
        template_dir (str): Path to the Jinja template directory.
        output_dir (str): Path to the output directory.
        configs (dict): Configuration dictionary.
    Returns:
        None
    """
    if 'config' in configs:
        configs = configs['config']

    template_dir = configs['template_path']
    output_dir = configs['output_dir']
    try:
        with open(yaml_file, 'r', encoding='utf-8') as yaml_f:
            table_config = yaml.safe_load(yaml_f)
        if not table_config or not isinstance(table_config, dict):
            logging.error(
                "YAML file %s is empty or not in the expected format.",
                yaml_file
            )
            return
        # get list of BUILD in the config
        build_list = table_config.get('BUILD', [])
        if not build_list or not isinstance(build_list, list):
            logging.error(
                "YAML file %s does not contain a valid BUILD list.",
                yaml_file
            )
            return
        logging.info(
            "Found %d BUILD entries in YAML file: %s",
            len(build_list),
            yaml_file
        )
        for build in build_list:
            build_ddl_file(build, table_config, template_dir, output_dir, configs, yaml_file)
    except (OSError, yaml.YAMLError) as exc:
        logging.error(
            "Error processing YAML file %s: %s",
            yaml_file,
            exc
        )
    return build_list

######################################################################
# Function: build_ddl_file
# Description: Helper function to process a single build entry and generate DDL/drop files.
######################################################################
def build_ddl_file(build, table_config, template_dir, output_dir, configs, yaml_file):
    """
    Build DDL and drop files for a single build entry using Jinja templates.

    Args:
        build (dict): The build entry from the YAML file.
        table_config (dict): The full table configuration from the YAML file.
        template_dir (str): Path to the Jinja template directory.
        output_dir (str): Path to the output directory.
        configs (dict): Configuration dictionary.
        yaml_file (str): Path to the YAML file (for logging).
    Returns:
        None
    """
    if not isinstance(build, dict):
        logging.error(
            "Invalid BUILD entry in YAML file %s: %s",
            yaml_file,
            build
        )
        return
    build = {k: v.strip() if isinstance(v, str) else v for k, v in build.items()}
    if 'databasename' in build:
        db_name = build['databasename']
        if isinstance(db_name, str):
            db_name = re.sub(r'DW[A-Z][0-9]{2,2}', '', db_name)
            build['databasename'] = db_name.strip()
        else:
            logging.error(
                "Invalid databasename in BUILD entry: %s",
                build
            )
            return
    if 'table_name' not in build:
        build['table_name'] = table_config.get('tablename', '')
    logging.info(
        "Processing BUILD entry: %s",
        build
    )
    pattern = build.get('pattern', '')
    if not pattern:
        logging.error(
            "BUILD entry in YAML file %s does not contain a valid pattern.",
            yaml_file
        )
        return
    file_template = f"{template_dir}/{pattern}.filename.j2"
    if not os.path.exists(file_template):
        logging.error(
            "Template file %s does not exist for pattern %s.",
            file_template,
            pattern
        )
        exit(99)
        return
    logging.info(
        "Using template file: %s for pattern: %s",
        file_template,
        pattern
    )
    ddl_template_filename = f"{pattern}.sql.j2"
    ddl_template_path = os.path.join(template_dir, ddl_template_filename)
    logging.info(
        "Using template file: %s for pattern: %s",
        ddl_template_path,
        pattern
    )
    drop_template_filename = f"{pattern}.filename.drop.j2"
    logging.info(
        "Using drop template file: %s for pattern: %s",
        drop_template_filename,
        pattern
    )
    if not os.path.exists(os.path.join(template_dir, ddl_template_filename)):
        logging.error(
            "DDL template file %s does not exist for pattern %s. Exiting.",
            ddl_template_filename,
            pattern
        )
        exit(99)
        return
    if not os.path.exists(os.path.join(template_dir, drop_template_filename)):
        logging.error(
            "Drop template file %s does not exist for pattern %s. Exiting.",
            drop_template_filename,
            pattern
        )
        exit(99)
        return
    logging.info(
        "Using drop template file: %s for pattern: %s",
        drop_template_filename,
        pattern
    )
    drop_ddl_template_filename = f"{pattern}.sql.drop.j2"
    try:
        env = Environment(loader=FileSystemLoader(template_dir))
        template = env.get_template(f"{pattern}.filename.j2")
        rendered_filename = template.render(table_config, build=build, config=configs)
        logging.info(
            "Rendered filename: %s",
            rendered_filename
        )
    except Exception as exc:
        logging.error(
            "Error rendering template for pattern %s in YAML file %s: %s",
            pattern,
            yaml_file,
            exc
        )
        return
    try:
        drop_template = env.get_template(drop_template_filename)
        rendered_drop_filename = drop_template.render(table_config, build=build, config=configs)
        logging.info(
            "Rendered drop filename: %s",
            rendered_drop_filename
        )
        drop_output_file = os.path.join(output_dir, rendered_drop_filename)
    except Exception as exc:
        logging.error(
            "Error rendering drop template for pattern %s in YAML file %s: %s",
            pattern,
            yaml_file,
            exc
        )
        exit(99)
        return
    try:
        ddl_template = env.get_template(ddl_template_filename)
        rendered_ddl = ddl_template.render(table_config, build=build, config=configs)
        logging.info(
            "Rendered DDL: %s",
            rendered_ddl
        )
        output_file = os.path.join(output_dir, rendered_filename)
        with open(output_file, 'w', encoding='utf-8') as out_f:
            out_f.write(rendered_ddl)
        logging.info(
            "DDL written to file: %s",
            output_file
        )
    except Exception as exc:
        logging.error("file_template: %s", file_template)
        logging.error("ddl_template: %s", ddl_template_filename)
        logging.error(
            "Error rendering DDL template for pattern %s in YAML file %s: %s",
            pattern,
            yaml_file,
            exc
        )
        exit(99)
        return
    try:
        drop_ddl_template = env.get_template(drop_ddl_template_filename)
        rendered_drop_ddl = drop_ddl_template.render(table_config, build=build, config=configs)
        logging.info(
            "Rendered drop DDL: %s",
            rendered_drop_ddl
        )
        with open(drop_output_file, 'w', encoding='utf-8') as drop_out_f:
            drop_out_f.write(rendered_drop_ddl)
            logging.info(
                "Drop DDL written to file: %s",
                drop_output_file
            )
    except Exception as exc:
        logging.error(
            "Error rendering drop DDL template for pattern %s in YAML file %s: %s",
            pattern,
            yaml_file,
            exc
        )
        exit(99)
        return

if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(filename)s:%(lineno)d - %(message)s'
    )
    # load config from a file config.yaml
    CONFIG_FILE = 'config.yaml'
    if not os.path.exists(CONFIG_FILE):
        logging.error(
            "Configuration file %s does not exist.",
            CONFIG_FILE
        )
        sys.exit(1)

    with open(CONFIG_FILE, 'r', encoding='utf-8') as config_f:
        example_configs = yaml.safe_load(config_f)
        if not example_configs or not isinstance(example_configs, dict):
            logging.error(
                "Configuration file %s is empty or not in the expected format.",
                CONFIG_FILE
            )
            sys.exit(1)
        example_configs = example_configs.get('config', {})
        if not example_configs:
            logging.error(
                "Configuration is empty or not in the expected format."
            )
            sys.exit(1)
    logging.info("Configuration loaded successfully.")
    generate_ddl_from_yaml_files(example_configs)
    logging.info("DDL generation completed.")