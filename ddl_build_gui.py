import sys
import os
import logging
import yaml
from PyQt5 import QtWidgets, QtCore, QtGui
QApplication = QtWidgets.QApplication
QMainWindow = QtWidgets.QMainWindow
QWidget = QtWidgets.QWidget
QVBoxLayout = QtWidgets.QVBoxLayout
QHBoxLayout = QtWidgets.QHBoxLayout
QTextEdit = QtWidgets.QTextEdit
QStatusBar = QtWidgets.QStatusBar
QMenuBar = QtWidgets.QMenuBar
QAction = QtWidgets.QAction
QFileDialog = QtWidgets.QFileDialog
QListWidget = QtWidgets.QListWidget
QListWidgetItem = QtWidgets.QListWidgetItem
QPushButton = QtWidgets.QPushButton
QMessageBox = QtWidgets.QMessageBox
QLabel = QtWidgets.QLabel
QDialog = QtWidgets.QDialog
QLineEdit = QtWidgets.QLineEdit
Qt = QtCore.Qt

import excel_handler
import ddl_generator
import ddl_test

CONFIG_PATH = 'config.yaml'
CONFIG_BACKUP_PATH = 'config_backup.yaml'

# Load local config.yaml and assign to config["config"]
with open(CONFIG_PATH, 'r', encoding='utf-8') as config_main_fp:
    config = {"config": yaml.safe_load(config_main_fp)}


# Logging window for displaying log output
class QTextEditStream:
    def __init__(self, text_edit):
        self.text_edit = text_edit
    def write(self, msg):
        # Remove extra newlines from logging
        if msg.strip():
            self.text_edit.append(msg.rstrip())
    def flush(self):
        pass

class LoggingWindow(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle('Logging')
        self.resize(700, 400)
        layout = QVBoxLayout()
        self.text_edit = QTextEdit()
        self.text_edit.setReadOnly(True)
        layout.addWidget(self.text_edit)
        self.setLayout(layout)
    def append_log(self, msg):
        self.text_edit.append(msg)

# Custom logging handler to send logs to LoggingWindow
class QtLogHandler(logging.Handler):
    def __init__(self, log_window):
        super().__init__()
        self.log_window = log_window
    def emit(self, record):
        msg = self.format(record)
        self.log_window.append_log(msg)

class ExcelFileDialog(QDialog):
    def __init__(self, excel_dir, parent=None):
        super().__init__(parent)
        self.setWindowTitle('Process DDL Excel Files')
        self.selected_files = []
        self.excel_dir = excel_dir
        self.layout = QHBoxLayout()  # Main layout is now horizontal
        self.setLayout(self.layout)

        # Left side: Buttons (vertical)
        btn_vbox = QVBoxLayout()
        self.select_all_btn = QPushButton('Check All')
        self.clear_btn = QPushButton('Clear All')
        self.clear_yaml_btn = QPushButton('Delete YAML')
        self.clear_ddl_btn = QPushButton('Delete DDL')
        self.process_btn = QPushButton('Process Files')
        self.cancel_btn = QPushButton('Cancel')
        btn_vbox.addWidget(self.select_all_btn)
        btn_vbox.addWidget(self.clear_btn)
        btn_vbox.addWidget(self.clear_yaml_btn)
        btn_vbox.addWidget(self.clear_ddl_btn)
        btn_vbox.addWidget(self.process_btn)
        btn_vbox.addStretch(1)
        btn_vbox.addWidget(self.cancel_btn)  # Cancel is always last/bottom
        self.layout.addLayout(btn_vbox)

        # Right side: File controls (vertical)
        right_vbox = QVBoxLayout()
        # Directory label and change dir button
        dir_hbox = QHBoxLayout()
        self.dir_label = QLabel('Directory:')
        self.dir_value = QLabel(self.excel_dir)
        self.change_dir_btn = QPushButton('Select Directory')
        self.change_dir_btn.clicked.connect(self.change_directory)
        dir_hbox.addWidget(self.dir_label)
        dir_hbox.addWidget(self.dir_value)
        dir_hbox.addWidget(self.change_dir_btn)
        right_vbox.addLayout(dir_hbox)
        # Wildcard filter
        self.filter_edit = QLineEdit()
        self.filter_edit.setPlaceholderText('Enter wildcard (e.g. *_sheet.xlsx) to filter files')
        right_vbox.addWidget(self.filter_edit)
        # File list
        self.file_list = QListWidget()
        self.file_list.setSelectionMode(QListWidget.MultiSelection)
        right_vbox.addWidget(self.file_list)
        # Progress bar
        QProgressBar = QtWidgets.QProgressBar
        self.progress_bar = QProgressBar()
        self.progress_bar.setMinimum(0)
        self.progress_bar.setMaximum(1)
        self.progress_bar.setValue(0)
        self.progress_bar.setTextVisible(True)
        right_vbox.addWidget(self.progress_bar)
        self.layout.addLayout(right_vbox)

        # Button connections
        self.select_all_btn.clicked.connect(self.select_all)
        self.clear_btn.clicked.connect(self.clear_selection)
        self.process_btn.clicked.connect(self.process_selected)
        self.cancel_btn.clicked.connect(self.reject)
        self.clear_yaml_btn.clicked.connect(self.clear_yaml_files)
        self.clear_ddl_btn.clicked.connect(self.clear_ddl_files)

        self.all_excel_files = []
        if os.path.isdir(self.excel_dir):
            for root, _, files in os.walk(self.excel_dir):
                for fname in files:
                    if fname.lower().endswith('.xlsx'):
                        rel_path = os.path.relpath(os.path.join(root, fname), self.excel_dir)
                        self.all_excel_files.append(rel_path)
        self.filter_edit.textChanged.connect(self.populate_file_list)
        self.populate_file_list()

    def clear_yaml_files(self):
        import glob
        import shutil
        yaml_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'yaml')
        files = glob.glob(os.path.join(yaml_dir, '*.yaml'))
        count = 0
        for f in files:
            try:
                os.remove(f)
                count += 1
            except Exception as e:
                logging.error('Failed to delete YAML file %s: %s', f, e)
        QMessageBox.information(self, 'Delete YAML', f'Deleted {count} YAML files from yaml directory.')

    def clear_ddl_files(self):
        import glob
        import shutil
        # Try to get output_dir from config, fallback to ./output
        output_dir = None
        if hasattr(self.parent(), 'config') and isinstance(self.parent().config, dict):
            output_dir = self.parent().config.get('output_dir', None)
        if not output_dir:
            output_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'output')
        files = glob.glob(os.path.join(output_dir, '*.ddl'))
        count = 0
        for f in files:
            try:
                os.remove(f)
                count += 1
            except Exception as e:
                logging.error('Failed to delete DDL file %s: %s', f, e)
        QMessageBox.information(self, 'Delete DDL', f'Deleted {count} DDL files from output directory.')

    def change_directory(self):
        new_dir = QFileDialog.getExistingDirectory(self, 'Select Excel Directory', self.excel_dir)
        if new_dir:
            self.excel_dir = new_dir
            self.dir_value.setText(self.excel_dir)
            self.populate_file_list()
            # Update config.yaml with new directory
            try:
                config_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'config.yaml')
                with open(config_path, 'r', encoding='utf-8') as config_dialog_fp:
                    config_data = yaml.safe_load(config_dialog_fp)
                config_data['excel_path'] = new_dir
                with open(config_path, 'w', encoding='utf-8') as config_dialog_fp:
                    yaml.safe_dump(config_data, config_dialog_fp)
            except OSError as update_exc:
                logging.error('Failed to update config.yaml: %s', update_exc, exc_info=True)
                QMessageBox.warning(self, 'Config Update Error', f'Failed to update config.yaml: {update_exc}')

    def populate_file_list(self):
        import fnmatch
        self.file_list.clear()
        if not os.path.isdir(self.excel_dir):
            logging.error('Excel directory not found: %s', self.excel_dir)
            QMessageBox.warning(self, 'Directory Not Found', f'Excel directory not found: {self.excel_dir}')
            self.progress_bar.setMaximum(1)
            self.progress_bar.setValue(0)
            return
        pattern = self.filter_edit.text().strip()
        if not pattern:
            filtered = self.all_excel_files
        else:
            filtered = fnmatch.filter(self.all_excel_files, pattern)
        self.progress_bar.setMaximum(len(filtered) if filtered else 1)
        self.progress_bar.setValue(0)
        if not filtered:
            logging.info('No .xlsx files found in the selected directory.')
            QMessageBox.information(self, 'No Excel Files', 'No .xlsx files found in the selected directory.')
            return
        for idx, rel_path in enumerate(sorted(filtered), 1):
            item = QListWidgetItem(rel_path)
            item.setCheckState(Qt.Unchecked)
            self.file_list.addItem(item)
            self.progress_bar.setValue(idx)
        self.progress_bar.setValue(self.progress_bar.maximum())

    def select_all(self):
        for i in range(self.file_list.count()):
            self.file_list.item(i).setCheckState(Qt.Checked)

    def clear_selection(self):
        for i in range(self.file_list.count()):
            self.file_list.item(i).setCheckState(Qt.Unchecked)

    def process_selected(self):
        self.selected_files = []
        checked_items = [self.file_list.item(i) for i in range(self.file_list.count()) if self.file_list.item(i).checkState() == Qt.Checked]
        if not checked_items:
            QMessageBox.warning(self, 'No Files Selected', 'Please select at least one Excel file to process.')
            return
        self.progress_bar.setMaximum(len(checked_items))
        self.progress_bar.setValue(0)
        for idx, item in enumerate(checked_items, 1):
            self.selected_files.append(os.path.join(self.excel_dir, item.text()))
            self.progress_bar.setValue(idx)
            # Update main console with file processed
            if hasattr(self.parent(), 'console'):
                self.parent().console.append(f'Processing {item.text()}')
            elif hasattr(self.parent(), 'parent') and hasattr(self.parent().parent(), 'console'):
                self.parent().parent().console.append(f'Processing {item.text()}')
            # get file name without the directory
            excel_filename_without_path = os.path.basename(item.text())
            # Call excel_handler.read_excel_file to process each file
            try:
                if 'config' in config:
                    config_to_use = config['config']
                else:
                    config_to_use = config
                yaml_filename_and_path = excel_handler.read_excel_file(os.path.join(self.excel_dir, item.text()), config=config_to_use)
                # Generate DDL from YAML files if YAML was created
                if yaml_filename_and_path:
                    build_list = ddl_generator.generate_ddl_from_yaml_file(yaml_filename_and_path, configs=config_to_use)
                    # Only assign if the key exists
                    if excel_filename_without_path in config_to_use.get('process_sheets', {}):
                        config_to_use['process_sheets'][excel_filename_without_path]['build_list'] = build_list
                    else:
                        logging.warning('Key %s not found in process_sheets; skipping build_list assignment.', excel_filename_without_path)
                else:
                    logging.warning('No YAML generated for %s. Skipping DDL generation.', excel_filename_without_path)
            except (OSError, ValueError) as process_exc:
                logging.error('Error processing %s: %s', excel_filename_without_path, str(process_exc))
            QApplication.processEvents()  # keep UI responsive
        QMessageBox.information(self, 'Files Selected', f'Selected {len(self.selected_files)} Excel files. You may select more or close this dialog.')

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle('Primark SSBI Project DDL Builder')
        self.resize(900, 600)
        # Unwrap config if needed
        if isinstance(config, dict) and 'config' in config and isinstance(config['config'], dict):
            self.config = config['config']
        else:
            self.config = config
        self.console = QTextEdit()
        self.console.setReadOnly(True)
        self.logging_window = LoggingWindow(self)
        self.status_bar = QStatusBar()
        self.setStatusBar(self.status_bar)
        self.teradata_connected = False  # Track Teradata connection state
        # Traffic light indicator and label
        self.traffic_light = QLabel()
        self.traffic_light.setFixedSize(24, 24)
        self.traffic_light.setToolTip('Teradata Connection Status')
        self.teradata_label = QLabel('Teradata Connection')
        self.teradata_label.setAlignment(Qt.AlignLeft | Qt.AlignVCenter)
        self.menu_bar = QMenuBar(self)
        self.setMenuBar(self.menu_bar)
        self.update_traffic_light()
        self.init_ui()
        # Add traffic light and label to the status bar (right side)
        self.status_bar.addPermanentWidget(self.traffic_light)
        self.status_bar.addPermanentWidget(self.teradata_label)
        self.setup_logging()

    # load_config is no longer needed, config is loaded globally

    def setup_logging(self):
        logger = logging.getLogger()
        logger.setLevel(logging.DEBUG)
        # Console log handler (for top window)
        console_stream = QTextEditStream(self.console)
        console_handler = logging.StreamHandler(console_stream)
        console_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s [%(filename)s:%(lineno)d]'))
        # Logging window handler
        qt_handler = QtLogHandler(self.logging_window)
        qt_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s [%(filename)s:%(lineno)d]'))
        logger.handlers = [console_handler, qt_handler]
        self.logger = logger

    def init_ui(self):
        # Only add menus and actions, do not recreate the menu bar
        self.menu_bar.clear()  # Clear any existing menus to avoid duplicates
        # DDL Excels menu
        self.ddl_excels_menu = self.menu_bar.addMenu('DDL Excels')
        self.load_excels_action = QAction('Process DDL Excel Files', self)
        self.load_excels_action.triggered.connect(self.load_ddl_excels)
        self.ddl_excels_menu.addAction(self.load_excels_action)

        # Mapping Excel menu
        self.mapping_excel_menu = self.menu_bar.addMenu('Mapping Excel')
        self.process_mapping_action = QAction('Process Mapping Excel', self)
        self.process_mapping_action.triggered.connect(self.process_mapping_excel)
        self.mapping_excel_menu.addAction(self.process_mapping_action)

        # DDL Test menu
        self.ddl_test_menu = self.menu_bar.addMenu('DDL Test')
        self.connect_action = QAction('Connect to Teradata', self)
        self.connect_action.triggered.connect(self.connect_teradata)
        self.ddl_test_menu.addAction(self.connect_action)
        self.disconnect_action = QAction('Disconnect from Teradata', self)
        self.disconnect_action.triggered.connect(self.disconnect_teradata)
        self.ddl_test_menu.addAction(self.disconnect_action)
        self.run_test_action = QAction('Run DDL Test', self)
        self.run_test_action.triggered.connect(self.run_ddl_test_dialog)
        self.ddl_test_menu.addAction(self.run_test_action)

        # Run Job menu
        self.run_job_menu = self.menu_bar.addMenu('Run Job')
        self.run_job_action = QAction('Run Job', self)
        self.run_job_action.triggered.connect(self.run_job_dialog)
        self.run_job_menu.addAction(self.run_job_action)


    def run_job_dialog(self):
        import fnmatch
        job_dir = self.config['config'].get('job_path', 'job_path') if 'config' in self.config else self.config.get('job_path', 'job_path')
        steps_dir = self.config['config'].get('steps_path', 'steps_path') if 'config' in self.config else self.config.get('steps_path', 'steps_path')
        class RunJobDialog(QDialog):
            def __init__(self, job_dir, steps_dir, parent=None):
                super().__init__(parent)
                self.setWindowTitle('Run Job')
                self.resize(800, 500)
                self.job_dir = job_dir
                self.steps_dir = steps_dir
                self.selected_job = None
                self.layout = QHBoxLayout()
                self.setLayout(self.layout)
                # Left: Job list
                job_vbox = QVBoxLayout()
                job_vbox.addWidget(QLabel('Jobs:'))
                self.job_list = QListWidget()
                self.job_list.setSelectionMode(QListWidget.SingleSelection)
                job_vbox.addWidget(self.job_list)
                self.layout.addLayout(job_vbox)
                # Right: Step files list
                step_vbox = QVBoxLayout()
                step_vbox.addWidget(QLabel('Step SQL Files:'))
                self.step_list = QListWidget()
                self.step_list.setSelectionMode(QListWidget.SingleSelection)
                step_vbox.addWidget(self.step_list)
                self.layout.addLayout(step_vbox)
                # Populate job list
                self.all_jobs = []
                if os.path.isdir(self.job_dir):
                    for fname in os.listdir(self.job_dir):
                        if fname.lower().endswith('.job'):
                            self.all_jobs.append(fname)
                for fname in sorted(self.all_jobs):
                    item = QListWidgetItem(fname)
                    self.job_list.addItem(item)
                self.job_list.currentItemChanged.connect(self.update_step_list)
            def update_step_list(self, current, previous):
                self.step_list.clear()
                if not current:
                    return
                job_name = os.path.splitext(current.text())[0]
                if os.path.isdir(self.steps_dir):
                    pattern = f"{job_name}*.sql"
                    files = fnmatch.filter(os.listdir(self.steps_dir), pattern)
                    for fname in sorted(files):
                        item = QListWidgetItem(fname)
                        self.step_list.addItem(item)
        dialog = RunJobDialog(job_dir, steps_dir, self)
        dialog.exec_()

    def process_mapping_excel(self):

        import excel_mapping_to_yaml

        class MappingCompileDialog(QDialog):
            def __init__(self, file_path, config, parent=None):
                super().__init__(parent)
                self.setWindowTitle('Mapping Compile')
                self.resize(520, 360)
                self.file_path = file_path
                self.config = config
                layout = QVBoxLayout()
                # Excel File Name row
                file_hbox = QHBoxLayout()
                label = QLabel('Excel File Name:')
                label.setMinimumWidth(120)
                file_hbox.addWidget(label)
                file_name_label = QLabel(os.path.basename(file_path))
                file_hbox.addWidget(file_name_label)
                file_hbox.addStretch(1)
                layout.addLayout(file_hbox)

                # YAML File Name row
                yaml_hbox = QHBoxLayout()
                yaml_label = QLabel('YAML File Name:')
                yaml_label.setMinimumWidth(120)
                yaml_hbox.addWidget(yaml_label)
                base_filename = os.path.splitext(os.path.basename(file_path))[0]
                yaml_file_name = f"{base_filename}.yaml"
                self.yaml_file_label = QLabel(yaml_file_name)
                yaml_hbox.addWidget(self.yaml_file_label)
                # Check existence
                self.yaml_dir = config.get('mapping_yaml_path', 'mapping_yaml') if 'mapping_yaml_path' in config else 'mapping_yaml'
                self.yaml_file_path = os.path.join(self.yaml_dir, yaml_file_name)
                self.yaml_exists_label = QLabel()
                self.update_yaml_existence_label()
                yaml_hbox.addWidget(self.yaml_exists_label)
                yaml_hbox.addStretch(1)
                layout.addLayout(yaml_hbox)

                # Validation Return Code row with traffic signal
                val_hbox = QHBoxLayout()
                val_label = QLabel('Validation Return Code:')
                val_label.setMinimumWidth(120)
                self.val_code_value = QLabel('')
                val_hbox.addWidget(val_label)
                val_hbox.addWidget(self.val_code_value)
                # Traffic signal
                self.traffic_signal = QLabel()
                self.traffic_signal.setFixedSize(24, 24)
                self.set_traffic_signal('blue')
                val_hbox.addWidget(self.traffic_signal)
                val_hbox.addStretch(1)
                layout.addLayout(val_hbox)

                # Validation return text box
                self.val_text_box = QtWidgets.QTextEdit()
                self.val_text_box.setReadOnly(True)
                self.val_text_box.setMinimumHeight(60)
                layout.addWidget(self.val_text_box)

                # Buttons row
                btn_hbox = QHBoxLayout()
                self.validate_btn = QPushButton('Validate')
                self.convert_btn = QPushButton('Convert To YAML')
                self.build_job_btn = QPushButton('Build Job')
                self.cancel_btn = QPushButton('Cancel')
                self.review_job_btn = QPushButton('Review Job')
                self.update_review_job_btn_color()
                btn_hbox.addWidget(self.validate_btn)
                btn_hbox.addWidget(self.convert_btn)
                btn_hbox.addWidget(self.build_job_btn)
                btn_hbox.addWidget(self.cancel_btn)
                btn_hbox.addWidget(self.review_job_btn)
                btn_hbox.addStretch(1)
                layout.addLayout(btn_hbox)
                self.setLayout(layout)
                self.validate_btn.clicked.connect(self.validate_file)
                self.cancel_btn.clicked.connect(self.reject)
                self.convert_btn.clicked.connect(self.convert_to_yaml)
                self.build_job_btn.clicked.connect(self.build_job)
                self.review_job_btn.clicked.connect(self.review_job)

            def build_job(self):
                from excel_mapping_to_yaml import build_job
                file_name_only = os.path.basename(self.file_path)
                try:
                    code, text = build_job(file_name_only, self.config)
                    if code == 0:
                        QMessageBox.information(self, 'Build Job', f'Success: {text}')
                    else:
                        QMessageBox.warning(self, 'Build Job', f'Error: {text}')
                except Exception as e:
                    QMessageBox.critical(self, 'Build Job Error', str(e))
                self.update_review_job_btn_color()

            def set_traffic_signal(self, color):
                # color: 'red', 'green', 'blue'
                from PyQt5.QtGui import QPixmap, QPainter, QColor
                pixmap = QPixmap(24, 24)
                pixmap.fill(Qt.transparent)
                painter = QPainter(pixmap)
                if color == 'green':
                    qcolor = QColor('#006400')
                elif color == 'red':
                    qcolor = QColor('red')
                else:
                    qcolor = QColor('blue')
                painter.setBrush(qcolor)
                painter.setPen(Qt.black)
                painter.drawEllipse(2, 2, 20, 20)
                painter.end()
                self.traffic_signal.setPixmap(pixmap)

            def update_yaml_existence_label(self):
                if os.path.exists(self.yaml_file_path):
                    self.yaml_exists_label.setText('(Exists)')
                    self.yaml_exists_label.setStyleSheet('color: green')
                else:
                    self.yaml_exists_label.setText('(Does NOT exist)')
                    self.yaml_exists_label.setStyleSheet('color: red')

            def update_review_job_btn_color(self):
                job_dir = self.config['config'].get('job_path', 'job_path') if 'config' in self.config else 'job_path'
                if not os.path.isdir(job_dir):
                    QMessageBox.warning(self, 'Review Job', f'Job directory does not exist: {job_dir}')
                    return
                base_filename = os.path.splitext(os.path.basename(self.file_path))[0]
                job_file_name = f"{base_filename}.job".replace('_MAPPING', '')  # Ensure no spaces in job file name
                job_file_path = os.path.join(job_dir, job_file_name)
                if os.path.exists(job_file_path):
                    self.review_job_btn.setStyleSheet('background-color: green; color: white;')
                else:
                    self.review_job_btn.setStyleSheet('background-color: red; color: white;')

            def review_job(self):
                #job_dir = self.config.get('job_path', 'job_path') if 'job_path' in self.config else 'job_path'
                job_dir = self.config['config'].get('job_path', 'job_path') if 'config' in self.config else 'job_path'
                if not os.path.isdir(job_dir):
                    QMessageBox.warning(self, 'Review Job', f'Job directory does not exist: {job_dir}')
                    return
                base_filename = os.path.splitext(os.path.basename(self.file_path))[0]
                job_file_name = f"{base_filename}.job".replace('_MAPPING', '')  # Ensure no spaces in job file name
                job_file_path = os.path.join(job_dir, job_file_name)
                if not os.path.exists(job_file_path):
                    QMessageBox.warning(self, 'Review Job', f'Job file does not exist: {job_file_path}')
                    return
                # Open job file for viewing
                try:
                    with open(job_file_path, 'r', encoding='utf-8') as f:
                        job_content = f.read()
                    view_dialog = QDialog(self)
                    view_dialog.setWindowTitle(f'Review Job: {job_file_name}')
                    view_dialog.resize(700, 500)
                    vbox = QVBoxLayout()
                    text_edit = QTextEdit()
                    text_edit.setReadOnly(True)
                    text_edit.setPlainText(job_content)
                    vbox.addWidget(text_edit)
                    close_btn = QPushButton('Close')
                    close_btn.clicked.connect(view_dialog.accept)
                    vbox.addWidget(close_btn)
                    view_dialog.setLayout(vbox)
                    view_dialog.exec_()
                except Exception as e:
                    QMessageBox.critical(self, 'Review Job Error', str(e))

            def validate_file(self):
                # Call validate_mapping_sheet from excel_mapping_to_yaml
                file_name_only = os.path.basename(self.file_path)
                try:
                    code, text = excel_mapping_to_yaml.validate_mapping_sheet(file_name_only, self.config)
                    self.val_code_value.setText(str(code))
                    self.val_text_box.setPlainText(str(text))
                    if code == 0:
                        self.set_traffic_signal('green')
                        QMessageBox.information(self, 'Validation Successful', text)
                    else:
                        self.set_traffic_signal('red')
                        QMessageBox.warning(self, 'Validation Failed', text)
                except Exception as e:
                    self.val_code_value.setText('Error')
                    self.val_text_box.setPlainText(str(e))
                    self.set_traffic_signal('red')
                    QMessageBox.critical(self, 'Validation Error', str(e))

            def convert_to_yaml(self):
                # Call convert_excel_to_yaml from excel_mapping_to_yaml
                file_name_only = os.path.basename(self.file_path)
                try:
                    if hasattr(excel_mapping_to_yaml, 'convert_excel_to_yaml'):
                        result = excel_mapping_to_yaml.convert_excel_to_yaml(file_name_only, self.config)
                        QMessageBox.information(self, 'YAML Conversion', f'YAML conversion complete.\n{result}')
                        # Update YAML existence label color after conversion
                        self.update_yaml_existence_label()
                        self.update_review_job_btn_color()
                    else:
                        QMessageBox.warning(self, 'YAML Conversion', 'convert_excel_to_yaml function not found in excel_mapping_to_yaml.')
                except Exception as e:
                    QMessageBox.critical(self, 'YAML Conversion Error', str(e))

        class MappingExcelDialog(QDialog):
            def __init__(self, mapping_dir, parent=None):
                super().__init__(parent)
                self.setWindowTitle('Select Mapping Excel File')
                self.selected_file = None
                self.mapping_dir = mapping_dir
                self.layout = QVBoxLayout()
                self.setLayout(self.layout)

                # Directory label and change dir button
                dir_hbox = QHBoxLayout()
                dir_hbox.addWidget(QLabel('Directory:'))
                self.dir_value = QLabel(self.mapping_dir)
                dir_hbox.addWidget(self.dir_value)
                self.change_dir_btn = QPushButton('Select Directory')
                self.change_dir_btn.clicked.connect(self.change_directory)
                dir_hbox.addWidget(self.change_dir_btn)
                self.layout.addLayout(dir_hbox)

                # Wildcard filter
                self.filter_edit = QLineEdit()
                self.filter_edit.setPlaceholderText('Enter wildcard (e.g. MAPPING*.xlsx)')
                self.layout.addWidget(self.filter_edit)

                # File list
                self.file_list = QListWidget()
                self.file_list.setSelectionMode(QListWidget.SingleSelection)
                self.layout.addWidget(self.file_list)

                # Buttons
                btn_layout = QHBoxLayout()
                self.process_btn = QPushButton('Process')
                self.cancel_btn = QPushButton('Cancel')
                btn_layout.addWidget(self.process_btn)
                btn_layout.addWidget(self.cancel_btn)
                self.layout.addLayout(btn_layout)
                self.process_btn.clicked.connect(self.process_selected)
                self.cancel_btn.clicked.connect(self.reject)

                # Populate file list
                self.all_mapping_files = []
                if os.path.isdir(self.mapping_dir):
                    for fname in os.listdir(self.mapping_dir):
                        if fname.lower().endswith('mapping.xlsx'):
                            self.all_mapping_files.append(fname)
                self.filter_edit.textChanged.connect(self.populate_file_list)
                self.populate_file_list()

            def change_directory(self):
                new_dir = QFileDialog.getExistingDirectory(self, 'Select Mapping Directory', self.mapping_dir)
                if new_dir:
                    self.mapping_dir = new_dir
                    self.dir_value.setText(self.mapping_dir)
                    # repopulate file list
                    self.all_mapping_files = []
                    if os.path.isdir(self.mapping_dir):
                        for fname in os.listdir(self.mapping_dir):
                            if fname.lower().endswith('mapping.xlsx'):
                                self.all_mapping_files.append(fname)
                    self.populate_file_list()

            def populate_file_list(self):
                import fnmatch
                self.file_list.clear()
                pattern = self.filter_edit.text().strip()
                if not pattern:
                    filtered = self.all_mapping_files
                else:
                    filtered = fnmatch.filter(self.all_mapping_files, pattern)
                for fname in sorted(filtered):
                    item = QListWidgetItem(fname)
                    self.file_list.addItem(item)

            def process_selected(self):
                selected_items = self.file_list.selectedItems()
                if not selected_items:
                    QMessageBox.warning(self, 'No File Selected', 'Please select a Mapping Excel file to process.')
                    return
                self.selected_file = os.path.join(self.mapping_dir, selected_items[0].text())
                # Open Mapping Compile dialog
                compile_dialog = MappingCompileDialog(self.selected_file, self.parent().config if hasattr(self.parent(), 'config') else {}, self)
                result = compile_dialog.exec_()
                # Only close MappingExcelDialog if MappingCompileDialog was accepted (not just canceled)
                if result == QDialog.Accepted:
                    self.accept()

        mapping_dir = self.config['config'].get('excel_mapping_directory', '.')
        dialog = MappingExcelDialog(mapping_dir, self)
        dialog.exec_()

    def update_traffic_light(self):
        # Draw a colored circle: green if connected, red if not
        QPixmap = QtGui.QPixmap
        QPainter = QtGui.QPainter
        QColor = QtGui.QColor
        pixmap = QPixmap(24, 24)
        pixmap.fill(Qt.transparent)
        painter = QPainter(pixmap)
        color = QColor('#008000') if self.teradata_connected else QColor('red')
        painter.setBrush(color)
        painter.setPen(Qt.black)
        painter.drawEllipse(2, 2, 20, 20)
        painter.end()
        self.traffic_light.setPixmap(pixmap)

    def run_ddl_test_dialog(self):
        # Dialog to select DDL files and run test
        mainwindow_logger = self.logger
        mainwindow_status_bar = self.status_bar

        class DDLTestDialog(QDialog):
            def __init__(self, output_dir, config_local, parent=None):
                super().__init__(parent)
                self.setWindowTitle('Run DDL Test')
                self.resize(700, 500)
                self.selected_files = []
                self.output_dir = output_dir
                self.config = config_local
                self.layout = QVBoxLayout()
                self.setLayout(self.layout)
                self.layout.addWidget(QLabel(f"DDL Output Directory: {output_dir}"))

                self.filter_edit = QLineEdit()
                self.filter_edit.setPlaceholderText('Enter wildcard (e.g. *_table.ddl) to filter files')
                self.layout.addWidget(self.filter_edit)
                self.file_list = QListWidget()
                self.file_list.setSelectionMode(QListWidget.MultiSelection)
                self.all_ddl_files = []
                if os.path.isdir(output_dir):
                    for fname in os.listdir(output_dir):
                        if fname.lower().endswith('.ddl'):
                            self.all_ddl_files.append(fname)
                # Progress bar
                self.progress_bar = QtWidgets.QProgressBar()
                self.progress_bar.setMinimum(0)
                self.progress_bar.setMaximum(1)
                self.progress_bar.setValue(0)
                self.progress_bar.setTextVisible(True)

                # Buttons
                btn_layout = QHBoxLayout()
                self.check_all_btn = QPushButton('Check All')
                self.clear_all_btn = QPushButton('Clear All')
                self.test_btn = QPushButton('Run DDL Test')
                self.edit_btn = QPushButton('Edit')
                self.cancel_btn = QPushButton('Cancel')
                btn_layout.addWidget(self.check_all_btn)
                btn_layout.addWidget(self.clear_all_btn)
                btn_layout.addWidget(self.test_btn)
                btn_layout.addWidget(self.edit_btn)
                btn_layout.addWidget(self.cancel_btn)

                self.populate_file_list()
                self.layout.addWidget(self.file_list)
                self.layout.addWidget(self.progress_bar)
                self.layout.addLayout(btn_layout)

                self.filter_edit.textChanged.connect(self.populate_file_list)
                self.check_all_btn.clicked.connect(self.check_all)
                self.clear_all_btn.clicked.connect(self.clear_all)
                self.test_btn.clicked.connect(self.run_test)
                self.edit_btn.clicked.connect(self.edit_file)
                self.cancel_btn.clicked.connect(self.reject)

            def populate_file_list(self):
                import fnmatch
                self.file_list.clear()
                pattern = self.filter_edit.text().strip()
                if not pattern:
                    filtered = self.all_ddl_files
                else:
                    filtered = fnmatch.filter(self.all_ddl_files, pattern)
                for fname in sorted(filtered):
                    item = QListWidgetItem(fname)
                    item.setCheckState(Qt.Unchecked)
                    self.file_list.addItem(item)

            def check_all(self):
                for i in range(self.file_list.count()):
                    self.file_list.item(i).setCheckState(Qt.Checked)

            def clear_all(self):
                for i in range(self.file_list.count()):
                    self.file_list.item(i).setCheckState(Qt.Unchecked)
            def edit_file(self):
                # Only allow editing if exactly one file is highlighted (selected)
                selected_items = self.file_list.selectedItems()
                if len(selected_items) != 1:
                    QMessageBox.warning(self, 'Edit DDL', 'Please highlight (select) exactly one DDL file to edit.')
                    return
                fname = selected_items[0].text()
                file_path = os.path.join(self.output_dir, fname)
                if not os.path.exists(file_path):
                    QMessageBox.warning(self, 'Edit DDL', f'File does not exist: {file_path}')
                    return
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        ddl_content = f.read()
                    edit_dialog = QDialog(self)
                    edit_dialog.setWindowTitle(f'Edit DDL: {fname}')
                    edit_dialog.resize(700, 500)
                    vbox = QVBoxLayout()
                    text_edit = QTextEdit()
                    text_edit.setPlainText(ddl_content)
                    vbox.addWidget(text_edit)
                    save_btn = QPushButton('Save')
                    cancel_btn = QPushButton('Cancel')
                    btn_hbox = QHBoxLayout()
                    btn_hbox.addWidget(save_btn)
                    btn_hbox.addWidget(cancel_btn)
                    vbox.addLayout(btn_hbox)
                    edit_dialog.setLayout(vbox)
                    def save_changes():
                        try:
                            with open(file_path, 'w', encoding='utf-8') as f:
                                f.write(text_edit.toPlainText())
                            QMessageBox.information(edit_dialog, 'Save DDL', f'Saved changes to {fname}')
                            edit_dialog.accept()
                        except Exception as e:
                            QMessageBox.critical(edit_dialog, 'Save Error', str(e))
                    save_btn.clicked.connect(save_changes)
                    cancel_btn.clicked.connect(edit_dialog.reject)
                    edit_dialog.exec_()
                except Exception as e:
                    QMessageBox.critical(self, 'Edit DDL Error', str(e))

            def run_test(self):
                self.selected_files = [self.file_list.item(i).text() for i in range(self.file_list.count()) if self.file_list.item(i).checkState() == Qt.Checked]
                if not self.selected_files:
                    QMessageBox.warning(self, 'No Files Selected', 'Please select at least one DDL file to test.')
                    return
                try:
                    mainwindow_logger.info('Running DDL test on %d files.', len(self.selected_files))
                    mainwindow_status_bar.showMessage(f'Testing {len(self.selected_files)} DDL files...', 5000)
                    error_code = 0
                    error_text = ''
                    self.progress_bar.setMaximum(len(self.selected_files))
                    self.progress_bar.setValue(0)
                    # Refresh the file list for each file (showing DDL content)
                    for idx, fname in enumerate(self.selected_files, 1):
                        file_path = os.path.join(self.output_dir, fname)
                        ddl_test.drop_using_file(file_path, self.config)
                        ddl_failed = False
                        try:
                            (error_code, error_text) = ddl_test.create_using_file(file_path, self.config)
                            if error_code != 0:
                                mainwindow_logger.error('Error creating DDL from file %s: %s', fname, error_text)
                                mainwindow_status_bar.showMessage(f'Error creating DDL from file {fname}: {error_text}', 5000)
                                QMessageBox.critical(self, f'DDL Test Error - {fname}', f'Error creating DDL from file {fname}: {error_text}')
                                ddl_failed = True
                        except (OSError, ValueError) as create_exc:
                            mainwindow_logger.error('Error creating DDL from file %s: %s', fname, str(create_exc))
                            mainwindow_status_bar.showMessage(f'Error creating DDL from file {fname}: {create_exc}', 5000)
                            QMessageBox.critical(self, f'DDL Test Error - {fname}', f'Error creating DDL from file {fname}: {create_exc}')
                            ddl_failed = True
                        # Set color of file name in the list
                        for i in range(self.file_list.count()):
                            item = self.file_list.item(i)
                            if item.text() == fname:
                                # Scroll to the file being processed
                                self.file_list.scrollToItem(item)
                                if ddl_failed:
                                    item.setForeground(Qt.red)
                                else:
                                    from PyQt5.QtGui import QColor
                                    item.setForeground(QColor('#006400'))
                                # Show DDL content as tooltip
                                try:
                                    with open(file_path, 'r', encoding='utf-8') as ddl_fp_local:
                                        ddl_content = ddl_fp_local.read()
                                    item.setToolTip(ddl_content[:2000] if ddl_content else '(Empty DDL)')
                                except (OSError, ValueError) as tooltip_exc:
                                    item.setToolTip(f'Error reading DDL file: {tooltip_exc}')
                                break
                        if not ddl_failed:
                            mainwindow_logger.info('Successfully created DDL from file %s', fname)
                        # Update main console with file generated
                        if hasattr(self.parent(), 'console'):
                            self.parent().console.append(f'Generated DDL for {fname}')
                        elif hasattr(self.parent(), 'parent') and hasattr(self.parent().parent(), 'console'):
                            self.parent().parent().console.append(f'Generated DDL for {fname}')
                        # Update progress bar
                        self.progress_bar.setValue(idx)
                    mainwindow_logger.info('Tested %d DDL files.', len(self.selected_files))
                    QMessageBox.information(self, 'DDL Test', f'Tested {len(self.selected_files)} DDL files.\nHover over a file to see its DDL.')
                    # Do not close dialog so user can review DDLs
                    # self.accept()
                except (OSError, ValueError) as test_exc:
                    import traceback
                    tb = traceback.format_exc()
                    mainwindow_logger.error('Error running DDL test: %s\n%s', str(test_exc), tb)
                    mainwindow_status_bar.showMessage(f'Error running DDL test: {test_exc}', 5000)
                    QMessageBox.critical(self, 'DDL Test Error', f'{test_exc}\n{tb}')

        output_dir = config['config'].get('output_dir', 'output')
        dialog = DDLTestDialog(output_dir, self.config, self)
        dialog.exec_()

    def connect_teradata(self):
        if self.teradata_connected:
            self.status_bar.showMessage('Already connected to Teradata.', 5000)
            self.logger.info('Already connected to Teradata.')
            return
        try:
            ddl_test.connect_to_teradata()
            self.teradata_connected = True
            self.update_traffic_light()
            self.status_bar.showMessage('Connected to Teradata', 5000)
            self.logger.info('Connected to Teradata')
        except (OSError, ValueError) as connect_exc:
            self.status_bar.showMessage(f'Failed to connect to Teradata: {connect_exc}', 5000)
            self.logger.error('Failed to connect to Teradata: %s', str(connect_exc))

    def disconnect_teradata(self):
        if not self.teradata_connected:
            self.status_bar.showMessage('Not connected to Teradata.', 5000)
            self.logger.info('Not connected to Teradata.')
            return
        try:
            ddl_test.disconnect_from_teradata()
            self.teradata_connected = False
            self.update_traffic_light()
            self.status_bar.showMessage('Disconnected from Teradata', 5000)
            self.logger.info('Disconnected from Teradata')
        except (OSError, ValueError) as disconnect_exc:
            self.status_bar.showMessage(f'Error disconnecting: {disconnect_exc}', 5000)
            self.logger.error('Error disconnecting from Teradata: %s', str(disconnect_exc))

    def show_logging_window(self):
        self.logging_window.show()
        self.logging_window.raise_()
        self.logging_window.activateWindow()

    def confirm_quit(self):
        msg_box = QMessageBox(self)
        msg_box.setWindowTitle('Quit')
        msg_box.setText('Are you sure you want to exit?')
        msg_box.setIcon(QMessageBox.Question)
        quit_button = msg_box.addButton('Exit', QMessageBox.AcceptRole)
        cancel_button = msg_box.addButton('Cancel', QMessageBox.RejectRole)
        msg_box.setDefaultButton(cancel_button)
        msg_box.exec_()
        if msg_box.clickedButton() == quit_button:
            QApplication.quit()

    def load_ddl_excels(self):
        excel_path = self.config.get('excel_path', '.')
        dialog = ExcelFileDialog(excel_path, self)
        if dialog.exec_() == QDialog.Accepted:
            files_list = dialog.selected_files
            self.logger.info('Processing Excel files: %s', files_list)
            try:
                for file_path in files_list:
                    if 'config' in self.config:
                        config_to_use = self.config['config']
                    else:
                        config_to_use = self.config
                    excel_filename_without_path = os.path.basename(file_path)
                    # Call excel_handler.read_excel_file to process each file
                    yaml_filename_and_path = excel_handler.read_excel_file(file_path, config=config_to_use)
                    # get the file name without the directory
                    yaml_filename = os.path.basename(yaml_filename_and_path) if yaml_filename_and_path else None
                    # update message in status bar
                    self.status_bar.showMessage(f'Processed {os.path.basename(file_path)}', 5000)
                    # Generate DDL from YAML files if YAML was created
                    if yaml_filename_and_path:
                        build_list = ddl_generator.generate_ddl_from_yaml_file(yaml_filename_and_path, configs=config_to_use)
                        self.logger.info('Generated DDL for %s', yaml_filename)
                        config_to_use['process_sheets'][excel_filename_without_path]['build_list'] = build_list

                with open(CONFIG_BACKUP_PATH, 'w', encoding='utf-8') as config_backup_fp:
                    yaml.safe_dump(self.config, config_backup_fp)

                # After processing all files, show a message
                self.logger.info('Loaded %d Excel files.', len(files_list))

                self.status_bar.showMessage(f'Loaded {len(files_list)} Excel files.', 5000)

            except (OSError, ValueError) as load_exc:
                import traceback
                tb = traceback.format_exc()
                self.logger.error('Error loading Excel files: %s\n%s', str(load_exc), tb)
                self.status_bar.showMessage('Error loading Excel files.', 5000)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())

