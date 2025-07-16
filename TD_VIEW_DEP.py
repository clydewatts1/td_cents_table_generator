#------------------------------------------------------------------------------------------
# File : td_view_dept.py
# Description : This populates a table with view and table dependencies based on SHOW IN XML command
# Author : Clyde Watts
# Date   : 2018-08-30
# Changes
#----------------------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------------------
import teradatasql
import subprocess
import getpass
import logging
import os
import re
#--------------------------------------------------------------------------------------------
# Main
#--------------------------------------------------------------------------------------------

# Set up logging configuration to console and to file
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(filename)s:%(lineno)d - %(message)s',
    handlers=[
        logging.FileHandler("td_view_dep.log"),
        logging.StreamHandler()
    ]
)

CONFIG = {}

CONFIG["ENV"] = 'DWP01'

conn = teradatasql.connect(
    host='teradw',
    tmode='TERA',
    logmech='BROWSER'
)
session = conn.cursor()


# Get the database
# Setup Database variables if not defined
if "MET_T" not in CONFIG:
    CONFIG["MET_T"] = "DWB01T_SANDBOX"
if "MET_V" not in CONFIG:
    CONFIG["MET_V"] = "DWB01V_SANDBOX"
if "MET_A" not in CONFIG:
    CONFIG["MET_A"] = "DWB01A_SANDBOX"

#session.execute("""DROP TABLE DWB01T_SANDBOX.OBJECT_DEPENDENCY""",ignoreErrors=[3807])

session.execute("""CREATE TABLE DWB01T_SANDBOX.OBJECT_DEPENDENCY
(
DatabaseName VARCHAR(128),
TableName VARCHAR(128),
TableType VARCHAR(128),
Dep_DatabaseName VARCHAR(128),
Dep_TableName VARCHAR(128),
Dep_TableKind VARCHAR(128),
ErrorCode INTEGER,
ErrorDescription VARCHAR(1000),
LogDate DATE DEFAULT CURRENT_DATE,
UpdateDt TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP
) PRIMARY INDEX(DatabaseName,TableName)
""",ignoreErrors=[3803])

logging.info("Created table DWB01T_SANDBOX.OBJECT_DEPENDENCY")

session.execute("""REPLACE VIEW DWB01V_SANDBOX.OBJECT_DEPENDENCY AS
  SELECT
   DatabaseName
    ,TableName
    ,TableType
    ,Dep_DatabaseName
    ,Dep_TableName
    ,Dep_TableKind
    ,ErrorCode
    ,ErrorDescription
    ,LogDate
    ,UpdateDt
  FROM  DWB01T_SANDBOX.OBJECT_DEPENDENCY
""",ignoreErrors=[3804])

logging.info("Created view DWB01V_SANDBOX.OBJECT_DEPENDENCY")

session.execute("""REPLACE VIEW DWB01A_SANDBOX.OBJECT_DEPENDENCY AS
  LOCKING ROW FOR ACCESS
  SELECT
   DatabaseName
    ,TableName
    ,TableType
    ,Dep_DatabaseName
    ,Dep_TableName
    ,Dep_TableKind
    ,ErrorCode
    ,ErrorDescription
    ,LogDate
    ,UpdateDt
  FROM  DWB01T_SANDBOX.OBJECT_DEPENDENCY
""",ignoreErrors=[3804])

logging.info("Created view DWB01A_SANDBOX.OBJECT_DEPENDENCY")

# Delete all non-existing objects
session.execute("""DELETE FROM DWB01V_SANDBOX.OBJECT_DEPENDENCY A
WHERE  NOT EXISTS (SELECT 1 FROM DBC.tablesv x where x.databasename=a.databasename and x.tablename = a.tablename)
""")

logging.info("Deleted non-existing objects from DWB01V_SANDBOX.OBJECT_DEPENDENCY")
csr = conn.cursor()
csr1 = conn.cursor()

sql_select = f"""

SELECT TRIM(T.databasename) databasename,trim(T.tablename) tablename,trim(T.tablekind) tablekind
      FROM DBC.tablesv T
          LEFT OUTER JOIN DWB01V_SANDBOX.OBJECT_DEPENDENCY A
          ON T.DATABASENAME = A.DATABASENAME
          AND T.TABLENAME = A.TABLENAME
          where
           (trim(T.databasename) LIKE '{CONFIG['ENV']}%' or ( 'ALL' = '{CONFIG['ENV']}' and trim(T.databasename) like 'DW%'))
           and T.tablekind in ('V','T','O')
           AND (
           A.DATABASENAME IS NULL
           OR
           COALESCE(T.LastAlterTimeStamp,T.CreateTimeStamp) > A.UPDATEDT
           )
         ORDER BY 1 desc,2
"""
# Log the SQL statement being executed
logging.info("Executing SQL: %s", sql_select)
# Loop through all objects that are new or have changed
for row in csr.execute(sql_select):
    print(row)
    CONFIG["DATABASE"] = row[0]
    CONFIG["TABLE"] = row[1]
    if row[2] == 'V':
        CONFIG["TYPE"] = 'VIEW'
    elif row[2] == 'T':
        CONFIG["TYPE"] = 'TABLE'
    elif row[2] == 'O':
        CONFIG["TYPE"] = 'TABLE'
    else:
        # log error if invalid type and continue
        logging.error("Invalid type {} {} {}".format(row[0],row[1],row[2]))
        continue

    vSQL_Code = 0
    vSQL_State = ""
    vError_Text = ""
    row_count = 0
    CONFIG["DEP_DATABASE"] = 'Unknown'
    CONFIG["DEP_TABLE"] = 'Unknown'
    CONFIG["DEP_TYPE"] = 'Unknown'
    CONFIG["ERRORCODE"] = vSQL_Code
    CONFIG["ERRORTEXT"] = vSQL_State

    try:
        strShow = ""
        found = False
        re_found = False
        # Do show of object , currently only works for tables / views / join and hash indexs
        try:
            for row in csr1.execute(f"""SHOW IN XML {CONFIG['TYPE']} "{CONFIG['DATABASE']}"."{CONFIG['TABLE']}" """,ignoreErrors=[3803,3707]):
                found = True
                strShow = strShow + "\n" + str(row[0])
        except Exception as ex:
            logging.error("SHOW ERROR {}".format(ex))
            continue

        # if the is a xml show , then look for dependencies
        if found is True:
            # Delete all rows so it can be inserted fresh
            session.execute("""DELETE FROM DWB01V_SANDBOX.OBJECT_DEPENDENCY A
            WHERE DatabaseName=? and Tablename=?
            """,(CONFIG["DATABASE"],CONFIG["TABLE"]))
            # loop thru xml to find all re that are matching
            for item in re.finditer(r"<Ref dbName=\"(?P<db>[A-Za-z_0-9]+)\"\s+name=\"(?P<tbl>[A-Za-z_0-9\s\.\$\%\#\@]+)\" type=\"(?P<tbl_type>[A-Za-z]+)\"\/>", strShow):
                #<Ref dbName="DWP01A_ACC_REF" name="PRIMARK_CALENDAR" type="View"/>
                re_found = True
                print("item",item.group("db"),item.group("tbl"),item.group("tbl_type"),item.group(0))
                CONFIG["DEP_DATABASE"] = item.group("db").replace("'","''")
                CONFIG["DEP_TABLE"] = item.group("tbl").replace("'","''")
                CONFIG["DEP_TYPE"] = item.group("tbl_type").upper()
                #CONFIG["ERRORTEXT"] = item.group(0)
                logging.info("DEPENDENCY {} {} {} {} {} {} ".format(
                CONFIG["DATABASE"],CONFIG["TABLE"],CONFIG["TYPE"],CONFIG["DEP_DATABASE"],CONFIG["DEP_TABLE"],CONFIG["DEP_TYPE"]))
                # Insert into dependency table
                session.execute(f"""INSERT INTO DWB01V_SANDBOX.OBJECT_DEPENDENCY
                    (DatabaseName,TableName,TableType,Dep_DatabaseName,Dep_TableName,Dep_TableKind,ErrorCode,ErrorDescription)
                VALUES
                    ('{CONFIG['DATABASE']}','{CONFIG['TABLE']}','{CONFIG['TYPE']}','{CONFIG['DEP_DATABASE']}','{CONFIG['DEP_TABLE']}','{CONFIG['DEP_TYPE']}','{CONFIG['ERRORCODE']}','{CONFIG['ERRORTEXT']}')
                    """, ignoreErrors=[3803])
            if re_found is False and CONFIG["TYPE"]=="VIEW":
                CONFIG["ERRORCODE"] = -1
                CONFIG["ERRORTEXT"] = "RE not found in XML check pything script"

                # write out funny xml
                # sometimes the xml has odd characters , so fails to write
                try:
                    fh=open("td_view_dep.xml","w")
                    fh.write(strShow)
                    fh.close()
                except:
                    logging.info("Error in opening file td_view_dep.xml ")
                session.execute("""INSERT INTO DWB01V_SANDBOX.OBJECT_DEPENDENCY
                    (DatabaseName,TableName,TableType,Dep_DatabaseName,Dep_TableName,Dep_TableKind,ErrorCode,ErrorDescription)
                VALUES
                    ('{CONFIG['DATABASE']}','{CONFIG['TABLE']}','{CONFIG['TYPE']}','{CONFIG['DEP_DATABASE']}','{CONFIG['DEP_TABLE']}','{CONFIG['DEP_TYPE']}','{CONFIG['ERRORCODE']}','{CONFIG['ERRORTEXT']}')
                    """, ignoreErrors=[3803])
    # Handle database exceptions
    except teradatasql.DatabaseError as e:
        vSQL_Code = str(e)
        #vSQL_State = e.sqlState
        #vError_Text = e.msg
        CONFIG["ERRORCODE"] = vSQL_Code
        CONFIG["ERRORTEXT"] = vError_Text.replace("'","''")
        # Insert error
        session.execute("""INSERT INTO DWB01V_SANDBOX.OBJECT_DEPENDENCY
            (DatabaseName,TableName,TableType,Dep_DatabaseName,Dep_TableName,Dep_TableKind,ErrorCode,ErrorDescription)
        VALUES
            ('{CONFIG['DATABASE']}','{CONFIG['TABLE']}','{CONFIG['TYPE']}','{CONFIG['DEP_DATABASE']}','{CONFIG['DEP_TABLE']}','{CONFIG['DEP_TYPE']}','{CONFIG['ERRORCODE']}','{CONFIG['ERRORTEXT']}')
            """,ignoreErrors=[3803,3707])
logging.info("Completed")
#--------------------------------------------------------------------------------------------------------------
# End
#--------------------------------------------------------------------------------------------------------------
