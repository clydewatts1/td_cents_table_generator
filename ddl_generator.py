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
def generate_ddl_from_yaml_files(configs, build_test_flg=True):
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
        generate_ddl_from_yaml_file(yaml_file, configs, build_test_flg=build_test_flg)
###################################################################### 
# Function: generate_ddl_from_yaml_file
# Description: Process a single YAML file and generate DDLs for all builds.
######################################################################
def generate_ddl_from_yaml_file(yaml_file, configs,build_test_flg=False):
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
    sample_dir = configs['sample_path']
    if not os.path.exists(template_dir):
        logging.error(
            "Template directory %s does not exist.",
            template_dir
        )
        return
    if not os.path.exists(output_dir):
        logging.error(
            "Output directory %s does not exist.",
            output_dir
        )
        return

    if not os.path.exists(sample_dir):
        logging.error(
            "Sample directory %s does not exist.",
            sample_dir
        )
        return
    # now add dll to sample directory
    if not os.path.exists(os.path.join(sample_dir, 'ddl')):
        os.makedirs(os.path.join(sample_dir, 'ddl'))
        logging.info(
            "Created sample directory for DDLs: %s",
            os.path.join(sample_dir, 'ddl')
        )
    sample_dir = os.path.join(sample_dir, 'ddl')
    logging.info(
        "Processing YAML file: %s",
        yaml_file
    )

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
            build_ddl_file(build, table_config, template_dir, output_dir, configs, yaml_file,sample_dir)
            if build_test_flg:
                build_ddl_test_file(build, table_config, template_dir, output_dir, configs, yaml_file,sample_dir)
    except (OSError, yaml.YAMLError) as exc:
        logging.error(
            "Error processing YAML file %s: %s",
            yaml_file,
            exc
        )
    return build_list

######################################################################
# Function: build_ddl_file
# Description: Helper function to build a test CSV file for use
######################################################################
def build_ddl_robot_files(configs):
    """
    Build DDL and drop files for a single build entry using Jinja templates.

    Args:
        template_dir (str): Path to the Jinja template directory.
        configs (dict): Configuration dictionary.

    Returns:
        List of csv files processed
    """
    #
    list_of_tests = []
    # get robot_path 
    robot_path = configs.get('robot_path', '')
    # append data/objects to robot_path
    # Get template path from config
    template_dir = configs.get('template_path', '')
    if not os.path.exists(template_dir):
        logging.error(
            "Template directory %s does not exist.",
            template_dir
        )
        return
    # Print template directory
    logging.info(
        "Template directory: %s",
        template_dir
    )
    if not os.path.exists(robot_path):
        logging.warning(
            "Robot path %s does not exist. Skipping test file generation.",
            robot_path
        )
        # create the robot path if it does not exist
        os.makedirs(robot_path, exist_ok=True)
        logging.info(
            "Created robot path: %s",
            robot_path
        )
    # append data/objects to robot_path
    robot_data_path = os.path.join(robot_path, 'data', 'objects')
    logging.info(
        "Robot path for test files: %s",
        robot_data_path
    )
    if not os.path.exists(robot_data_path):
        # exit
        logging.error(
            "Robot path %s does not exist. Exiting.",
            robot_data_path
        )
        return list_of_tests
    # from config get ddl_robot_tests
    ddl_robot_tests = configs.get('ddl_robot_tests', [])
    if not ddl_robot_tests or not isinstance(ddl_robot_tests, list):
        logging.error(
            "Configuration does not contain a valid ddl_robot_tests list."
        )
        return list_of_tests
    logging.info(
        "Found %d ddl_robot_tests entries in configuration.",
        len(ddl_robot_tests)
    )
    # now look for all files in the form *.csv in robot_data_path
    csv_files = glob.glob(os.path.join(robot_data_path, '*.csv'))
    if not csv_files:
        logging.warning(
            "No CSV files found in robot data directory: %s",
            robot_data_path
        )
        return list_of_tests
    logging.info(
        "Found %d CSV files to process in robot data directory: %s",
        len(csv_files),
        robot_data_path
    )
    for csv_file in csv_files:
        logging.info(
            "Processing CSV file: %s",
            csv_file
        )
        list_of_tests.append(os.path.basename(csv_file))
        # get file name 
        file_name = os.path.basename(csv_file)
        # remove .csv from file name
        file_name_no_ext = os.path.splitext(file_name)[0]
        # Split into database and table name T_TMP_ACC_FND.FND_MERC_HIERARCHY_DIM split name on .
        (database_name, table_name) = file_name_no_ext.split('.', 1 if '.' in file_name_no_ext else (file_name_no_ext, ''))
        logging.info(
            "Database name: %s",
            database_name
        )
        logging.info(
            "Table name: %s",
            table_name
        
        )
        column_csv_list=[]
        # load csv file and get header row using csv module
        # csv into column_csv_list , each row is a dictionary of the column names as key , and value as value in column
        # the first row of the csv file is the column headers , not it has quotes around the column names
        test_config={}
        test_config['databasename']=database_name
        test_config['tablename']=table_name
        test_config['project_name']=configs.get('project_name', 'Default Project')
        test_config['robot_path']=robot_path
        test_config['template_path']=template_dir
        test_config['output_path']=robot_data_path
        test_config['sample_path']=configs.get('sample_path', '')
        test_config['csv_file']=csv_file
        test_config['csv_file_name']=file_name
        test_config['csv_file_name_no_ext']=file_name_no_ext
        test_config['config']=configs
        test_config['columns']=column_csv_list
        import csv
        try:
            with open(csv_file, 'r', encoding='utf-8') as csv_f:
                reader = csv.DictReader(csv_f)
                for row in reader:
                    column_csv_list.append(row)
            if not column_csv_list:
                logging.warning(
                    "CSV file %s is empty.",
                    csv_file
                )
                continue
            logging.info(
                "Found %d rows in CSV file: %s",
                len(column_csv_list),
                csv_file
            )
        except Exception as exc:
            logging.error(
                "Error reading CSV file %s: %s",
                csv_file,
                exc
            )
            continue

        # now loop through ddl_robot_tests
        for test in ddl_robot_tests:
            logging.info(
                "Processing test: %s",
                test
            )
            if not isinstance(test, dict):
                logging.error(
                    "Invalid test entry in configuration: %s",
                    test
                )
                continue
            # get key of test
            test_name = list(test.keys())[0]
            # get path, filename_template, template
            test_config = test[test_name]
            if not isinstance(test_config, dict):
                logging.error(
                    "Invalid test configuration for test %s: %s",
                    test_name,
                    test_config
                )
                continue
            test_path = test_config.get('path', '')
            filename_template = test_config.get('filename_template', '')
            template = test_config.get('template', '')
            # check if filename template exists
            filename_template_path = os.path.join(template_dir, filename_template)
            if not os.path.exists(filename_template_path):
                logging.error(
                    "Filename template %s does not exist for test %s.",
                    filename_template_path,
                    test_name
                )
                exit(99)
                continue
            logging.info(
                "Using filename template: %s for test: %s",
                filename_template_path,
                test_name
            )
            # append robot_path and test_path
            test_output_path = os.path.join(robot_path, test_path)
            if not os.path.exists(test_output_path):
                os.makedirs(test_output_path, exist_ok=True)
                logging.info(
                    "Created test output path: %s",
                    test_output_path
                )
            # check if template exists
            template_path = os.path.join(template_dir, template)
            if not os.path.exists(template_path):
                logging.error(
                    "Template %s does not exist for test %s.",
                    template_path,
                    test_name
                )
                exit(99)
                continue
            logging.info(
                "Using template: %s for test: %s",
                template_path,
                test_name
            )
            test_config['databasename']=database_name
            test_config['tablename']=table_name
            test_config['project_name']=configs.get('project_name', 'Default Project')
            test_config['robot_path']=robot_path
            test_config['template_path']=template_dir
            test_config['output_path']=robot_data_path
            test_config['sample_path']=configs.get('sample_path', '')
            # now render template file name
            try:
                env = Environment(loader=FileSystemLoader(template_dir))
                template_obj = env.get_template(filename_template)
                rendered_filename = template_obj.render(test_config,test_config=test_config, build=test_config, config=configs)
                logging.info(
                    "Rendered filename: %s",
                    rendered_filename
                )
                rendered_filename = rendered_filename.strip()
                test_config['filename'] = rendered_filename
                logging.info(
                    "Using rendered filename: %s for test: %s",
                    rendered_filename,
                    test_name
                )
            except Exception as exc:
                logging.error("Oops")
            # now render template
            try:
                template_obj = env.get_template(template)
                rendered_test = template_obj.render(test_config,test_config=test_config, build=test_config, config=configs)
                logging.info(
                    "Rendered test: %s",
                    rendered_test
                )
                output_file = os.path.join(test_output_path, rendered_filename)
                with open(output_file, 'w', encoding='utf-8') as out_f:
                    out_f.write(rendered_test)
                logging.info(
                    "Test written to file: %s",
                    output_file
                )
            except Exception as exc:
                logging.error("template: %s", template)
                logging.error(
                    "Error rendering template %s for test %s: %s",
                    template,
                    test_name,
                    exc
                )
                exit(99)
                continue    
            # write files
            try:
                output_file = os.path.join(test_output_path, rendered_filename)
                with open(output_file, 'w', encoding='utf-8') as out_f:
                    out_f.write(rendered_test)
                logging.info(
                    "Test written to file: %s",
                    output_file
                )
            except Exception as exc:
                logging.error("template: %s", template)
                logging.error(
                    "Error writing test file %s for test %s: %s",
                    output_file,
                    test_name,
                    exc
                )
                exit(99)
                continue    
            # add to list of tests
            list_of_tests.append(test_name)

                
            

        
            
    return list_of_tests
    
######################################################################
# Function: build_ddl_file
# Description: Helper function to build a test CSV file for use
######################################################################
def build_ddl_test_file(build, table_config, template_dir, output_dir, configs, yaml_file,sample_dir):
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
    # get robot_path 
    robot_path = configs.get('robot_path', '')
    # append data/objects to robot_path
    robot_path = os.path.join(robot_path, 'data', 'objects')
    logging.info(
        "Robot path for test files: %s",
        robot_path
    )
    if not os.path.exists(robot_path):
        logging.warning(
            "Robot path %s does not exist. Skipping test file generation.",
            robot_path
        )
        # create the robot path if it does not exist
        os.makedirs(robot_path, exist_ok=True)
        logging.info(
            "Created robot path: %s",
            robot_path
        )

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
    file_template = f"{template_dir}/TEST.{pattern}.filename.j2"
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
    build['project_name'] = configs.get('project_name', 'Default Project')
    ddl_template_filename = f"TEST.{pattern}.csv.j2"
    ddl_template_path = os.path.join(template_dir, ddl_template_filename)
    logging.info(
        "Using template file: %s for pattern: %s",
        ddl_template_path,
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
    logging.info(
        "Using template file: %s for pattern: %s",
        ddl_template_filename,
        pattern
    )

    try:
        env = Environment(loader=FileSystemLoader(template_dir))
        template = env.get_template(f"test.{pattern}.filename.j2")
        rendered_filename = template.render(table_config, build=build, config=configs)
        logging.info(
            "Rendered filename: %s",
            rendered_filename
        )
        rendered_filename = rendered_filename.strip()
        build['filename'] = rendered_filename
        logging.info(
            "Using rendered filename: %s for pattern: %s",
            rendered_filename,
            pattern
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
        ddl_template = env.get_template(ddl_template_filename)
        rendered_ddl = ddl_template.render(table_config, build=build, config=configs)
        logging.info(
            "Rendered DDL: %s",
            rendered_ddl
        )
        output_file = os.path.join(robot_path, rendered_filename)
        with open(output_file, 'w', encoding='utf-8') as out_f:
            out_f.write(rendered_ddl)
        logging.info(
            "DDL written to file: %s",
            output_file
        )
        # Write the rendered DDL to the sample directory
        #sample_output_file = os.path.join(sample_dir, rendered_filename)
        #with open(sample_output_file, 'w', encoding='utf-8') as sample_out_f:
        #    sample_out_f.write(rendered_ddl)
        #logging.info(
        #    "Sample DDL written to file: %s",
        #    sample_output_file
        #)
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
######################################################################
# Function: build_ddl_file
# Description: Helper function to process a single build entry and generate DDL/drop files.
######################################################################
def build_ddl_file(build, table_config, template_dir, output_dir, configs, yaml_file,sample_dir):
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
    build['project_name'] = configs.get('project_name', 'Default Project')
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
        rendered_filename = rendered_filename.strip()
        build['filename'] = rendered_filename
        logging.info(
            "Using rendered filename: %s for pattern: %s",
            rendered_filename,
            pattern
        )
        drop_template_filename = drop_template_filename.strip()
        build['drop_filename'] = rendered_filename.replace('.sql', '.drop.sql')
        logging.info(
            "Using rendered drop filename: %s for pattern: %s",
            build['drop_filename'],
            pattern
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
        # Write the rendered DDL to the sample directory
        sample_output_file = os.path.join(sample_dir, rendered_filename)
        with open(sample_output_file, 'w', encoding='utf-8') as sample_out_f:
            sample_out_f.write(rendered_ddl)
        logging.info(
            "Sample DDL written to file: %s",
            sample_output_file
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
            # Write the rendered drop DDL to the sample directory
        sample_drop_output_file = os.path.join(sample_dir, rendered_drop_filename)
        with open(sample_drop_output_file, 'w', encoding='utf-8') as sample_drop_out_f:
            sample_drop_out_f.write(rendered_drop_ddl)
        logging.info(
            "Sample drop DDL written to file: %s",
            sample_drop_output_file
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
    #generate_ddl_from_yaml_files(example_configs,build_test_flg=True)
    logging.info("DDL generation completed.")
    build_ddl_robot_files(example_configs)