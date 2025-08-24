/*
# ===============================================================================
#                      PRIMARK
#
# ===============================================================================
# ===============================================================================
# File Name           : FND1041.190.TRANS.sql
# Pattern             : 
# Purpose             : Insertion in TRANS table
# Author              : TERADATA
# File Type           : SQL
# Creation Date       : 2025-08-19
# -------------------------------------------------------------------------------
# Change History :
# Ver  | Date        |  Modified By           |  Change Description
# -------------------------------------------------------------------------------
# 1.0  | 2025-08-19 |  Mr Primark                |  INITIAL CODE
*/

/* Set query band */
SET QUERY_BAND = 'ApplicationName=TJC;Group=FND_BASE;JobId=${JOB};JobSeq=190;Instance=${INSTANCE};RUNID=${RUNID};STREAMID=${STREAMID};' UPDATE FOR SESSION
;
.IF ERRORCODE <> 0 THEN .QUIT 101





DELETE FROM DW${INSTANCE}T_TMP_ACC_FND.FND_MERC_HIERARCHY_DIM
;

.IF ERRORCODE <> 0 THEN .QUIT 101

INSERT INTO DW${INSTANCE}T_TMP_ACC_FND.FND_MERC_HIERARCHY_DIM
(
    merch_hiery_wid,
    company_cd,
    pmk_co_wid,
    company_name,
    company_version_num,
    pmk_co_vers_reclass_evnt_ind,
    pmk_co_stl_in_count,
    pmk_co_stl_out_count,
    pmk_co_stl_cmn_count,
    pmk_co_stl_del_count,
    pmk_co_stl_new_count,
    pmk_co_stl_not_common_cmn_count,
    pmk_co_seq_no,
    division_cd,
    dvisn_wid,
    division_name,
    division_version_num,
    dvisn_vers_reclass_evnt_ind,
    dvisn_stl_in_count,
    dvisn_stl_out_count,
    dvisn_stl_cmn_count,
    dvisn_stl_del_count,
    dvisn_stl_new_count,
    dvisn_stl_not_common_cmn_count,
    dvisn_seq_no,
    department_cd,
    dept_wid,
    department_name,
    department_version_num,
    dept_reclass_evnt_ind,
    dept_stl_in_count,
    dept_stl_out_count,
    dept_stl_cmn_count,
    dept_stl_del_count,
    dept_stl_new_count,
    dept_stl_not_common_cmn_count,
    dept_seq_no,
    class_cd,
    item_clas_wid,
    class_name,
    class_version_num,
    clas_evnt_ind,
    item_clas_stl_in_count,
    item_clas_stl_out_count,
    item_clas_stl_cmn_count,
    item_clas_stl_del_count,
    item_clas_stl_new_count,
    item_clas_stl_not_common_cmn_count,
    item_clas_seq_no,
    subclass_group_cd,
    subclass_group_name,
    subclass_group_version_num,
    pmk_item_sbclas_grp_vers_reclass_evnt_ind,
    pmk_item_sbclas_grp_stl_in_count,
    pmk_item_sbclas_grp_stl_out_count,
    pmk_item_sbclas_grp_stl_cmn_count,
    pmk_item_sbclas_grp_stl_del_count,
    pmk_item_sbclas_grp_stl_new_count,
    pmk_item_sbclas_grp_stl_not_common_cmn_count,
    pmk_item_sbclas_grp_seq_no,
    subclass_cd,
    subclass_name,
    subclass_version_num,
    subclass_vers_reclass_evnt_ind,
    item_sbclas_stl_in_count,
    item_sbclas_stl_out_count,
    item_sbclas_stl_cmn_count,
    item_sbclas_stl_del_count,
    item_sbclas_stl_new_count,
    item_sbclas_stl_not_common_cmn_count,
    item_sbclas_seq_no,
    buyer_cd,
    buyer_name
)
-- This query calculates the correct version number for different levels of the product hierarchy (company, division, department, class, subclass group, subclass).
-- It identifies changes in style assignments within these hierarchy levels to determine when a new version is needed.
-- The core logic compares two sets of data:
--  Set A: The historical or previously existing style assignments for each hierarchy level.
--  Set B: The current style assignments based on the latest data.
--
-- By analyzing the differences between these sets, the query can flag when a version number needs to be incremented.
--
--                           +-------------------------------------------------------------+
--                           |        The Union of A and B (A U B)                         |
--                           | (All styles involved with a specific hierarchy level)       |
--                           |                                                             |
--                           |      Set A (Historical)        Set B (Current)              |
--                           |   +---------------------+   +---------------------+         |
--                           |   | Styles previously   |   | Styles currentlyhr    |         |
--                           |   | in this hierarchy   |   | in this hierarchy   |         |
--                           |   |                     +---+                     |         |
--                           |   | (Represents styles  | S | (Represents styles |         |
--                           |   | that might have     | t | that might have     |         |
--                           |   | been moved out)     | y | been moved in)      |         |
--                           |   |                     | l |                     |         |
--                           |   +---------------------+ e +---------------------+         |
--                           |                         | s |                               |
--                           |                         |   |                               |
--                           |                         | i |                               |
--                           |                         | n |                               |
--                           |                         |   |                               |
--                           |                         | b |                               |
--                           |                         | o |                               |
--                           |                         | t |                               |
--                           |                         | h |                               |
--                           |                         |   |                               |
--                           |                         |(Same/Unchanged Styles)|           |
--                           |                         +-----------------------+           |
--                           |                                                             |
--                           +-------------------------------------------------------------+
WITH
mhr AS (
    -- CTE 1: mhr (Merchant Hierarchy)
    -- This CTE builds the foundational merchant hierarchy by joining various dimension tables.
    -- It gathers information from company (co), division (dvn), department (dpt), class (cls), and subclass (scls).
    -- The result is a flattened view of the hierarchy.
    SELECT
        scls.item_sbclas_wid,
        TO_NUMBER(co.pmk_co_cd) (SMALLINT) AS pmk_co_cd ,
        co.pmk_co_wid,
        co.pmk_co_name,
        TO_NUMBER(dvn.dvisn_cd) (SMALLINT) AS dvisn_cd,
        dvn.dvisn_wid,
        dvn.dvisn_name,
        TO_NUMBER(dpt.dept_cd) (SMALLINT) AS dept_cd,
        dpt.dept_wid,
        dpt.dept_name,
        TO_NUMBER(cls.item_clas_cd) (SMALLINT) AS item_clas_cd,
        cls.item_clas_wid,
        cls.item_clas_name,
        TO_NUMBER(scls.pmk_item_sbclas_grp_cd) (SMALLINT) AS pmk_item_sbclas_grp_cd,
        scls.pmk_item_sbclas_grp_name,
        TO_NUMBER(scls.item_sbclas_cd) (SMALLINT) AS item_sbclas_cd,
        scls.item_sbclas_name,
        byr.pmk_tctcl_buyr_cd AS buyer_cd,
        byr.pmk_tctcl_buyr_name AS buyer_name
    FROM dwp01a_idw.item_sbclas AS scls
    INNER JOIN dwp01a_idw.item_clas AS cls
        ON cls.item_clas_wid = scls.item_clas_wid
    INNER JOIN dwp01a_idw.dept AS dpt
        ON dpt.dept_wid = cls.dept_wid
    INNER JOIN dwp01a_idw.dvisn AS dvn
        ON dvn.dvisn_wid = dpt.dvisn_wid
    INNER JOIN dwp01a_idw.pmk_co AS co
        ON co.pmk_co_wid = dvn.pmk_co_wid
    LEFT OUTER JOIN dwp01a_idw.pmk_tctcl_buyr AS byr
        ON dpt.pmk_tctcl_buyr_wid = byr.pmk_tctcl_buyr_wid AND byr.cur_flg = 'Y'
    WHERE
        scls.cur_flg = 'Y'
        AND co.cur_flg = 'Y'
        AND dpt.cur_flg = 'Y'
        AND cls.cur_flg = 'Y'
        AND dvn.cur_flg = 'Y'
),
mhrs AS (
    -- CTE 2: mhrs (Merchant Hierarchy with Styles)
    -- This CTE adds style information (styl_wid) to the merchant hierarchy created in mhr.
    -- It links styles to their respective subclasses.
    SELECT
        stl.styl_wid,
        mhr.*
    FROM mhr
    INNER JOIN (SELECT styl_wid,item_sbclas_wid,eff_from_dt,eff_to_dt FROM DWT04A_ACC_FND.DW_FND_STYL_SBCLASS_XREF WHERE eff_to_dt >  eff_from_dt)  AS stl
        ON mhr.item_sbclas_wid = stl.item_sbclas_wid 
        WHERE   -- get the "current rows based load token date 
                -- this allows catchups
            PERIOD(stl.eff_from_dt, stl.eff_to_dt) CONTAINS (CURRENT_DATE - 1)
),
mhr_prev AS (
    SELECT
        mrd.merch_hiery_wid AS item_sbclas_wid,
        mrd.company_cd AS pmk_co_cd,
        mrd.company_version_num AS pmk_co_vers_num,
        mrd.division_cd AS dvisn_cd,
        mrd.division_version_num AS dvisn_vers_num,
        mrd.department_cd AS dept_cd,
        mrd.department_version_num AS dept_vers_num,
        mrd.class_cd AS item_clas_cd,
        mrd.class_version_num AS item_clas_vers_num,
        mrd.subclass_group_cd AS pmk_item_sbclas_grp_cd,
        mrd.subclass_group_version_num AS pmk_item_sbclas_grp_vers_num,
        mrd.subclass_cd AS item_sbclas_cd,
        mrd.subclass_version_num AS item_sbclas_vers_num,
        mrd.company_name,
        mrd.division_name,
        mrd.department_name,
        mrd.class_name,
        mrd.subclass_group_name,
        mrd.subclass_name,
        mrd.buyer_cd,
        mrd.buyer_name,
        mrd.pmk_co_wid,
        mrd.dvisn_wid,
        mrd.dept_wid,
        mrd.item_clas_wid,
        mrd.merch_hiery_wid,
        mrd.eff_to_dt
    FROM dwt04a_acc_fnd.dw_fnd_merc_hierarchy_hist_dim AS mrd
    WHERE mrd.eff_to_dt = DATE '3500-12-31'
),
mhrs_prev AS (
    SELECT
        stl.styl_wid,
        mrd.merch_hiery_wid,
        mrd.company_cd AS pmk_co_cd,
        mrd.company_version_num AS pmk_co_vers_num,
        mrd.division_cd AS dvisn_cd,
        mrd.division_version_num AS dvisn_vers_num,
        mrd.department_cd AS dept_cd,
        mrd.department_version_num AS dept_vers_num,
        mrd.class_cd AS item_clas_cd,
        mrd.class_version_num AS item_clas_vers_num,
        mrd.subclass_group_cd AS pmk_item_sbclas_grp_cd,
        mrd.subclass_group_version_num AS pmk_item_sbclas_grp_vers_num,
        mrd.subclass_cd AS item_sbclas_cd,
        mrd.subclass_version_num AS item_sbclas_vers_num,
        mrd.company_name,
        mrd.division_name,
        mrd.department_name,
        mrd.class_name,
        mrd.subclass_group_name,
        mrd.subclass_name,
        mrd.buyer_cd,
        mrd.buyer_name,
        mrd.pmk_co_wid,
        mrd.dvisn_wid,
        mrd.dept_wid,
        mrd.item_clas_wid,
        mrd.merch_hiery_wid AS item_sbclas_wid,
        mrd.eff_to_dt
    FROM dwt04a_acc_fnd.dw_fnd_merc_hierarchy_hist_dim AS mrd
    INNER JOIN (SELECT styl_wid,item_sbclas_wid,eff_from_dt,eff_to_dt FROM DWT04A_ACC_FND.DW_FND_STYL_SBCLASS_XREF WHERE eff_to_dt >  eff_from_dt)  AS stl
        ON mrd.merch_hiery_wid = stl.item_sbclas_wid 
        WHERE   -- get the previous run position
                 -- this allows catchups
            PERIOD(stl.eff_from_dt, stl.eff_to_dt) CONTAINS (CURRENT_DATE - 1 - 1)
),
-- CTEs 3-8: maxv (Maximum Version) Series
-- These CTEs find the latest version number for each level of the hierarchy.
-- This gives us the starting point for versioning. If no version exists, it defaults to 1.
pmk_co_maxv AS (
    SELECT
        bse.pmk_co_wid,
        COALESCE(crt.pmk_co_vers_num, 1) AS pmk_co_vers_num
    FROM (SELECT DISTINCT pmk_co_wid FROM dwp01a_idw.pmk_co WHERE cur_flg = 'Y') AS bse
    LEFT OUTER JOIN (
        SELECT
            pmk_co_wid,
            MAX(pmk_co_vers_num) AS pmk_co_vers_num
        FROM mhrs_prev
        WHERE eff_to_dt = DATE '3500-12-31'
        GROUP BY 1
    ) AS crt
        ON bse.pmk_co_wid = crt.pmk_co_wid
),
dvisn_maxv AS (
    SELECT
        bse.dvisn_wid,
        COALESCE(crt.dvisn_vers_num, 1) AS dvisn_vers_num
    FROM (SELECT DISTINCT dvisn_wid FROM dwp01a_idw.dvisn WHERE cur_flg = 'Y') AS bse
    LEFT OUTER JOIN (
        SELECT
            dvisn_wid,
            MAX(dvisn_vers_num) AS dvisn_vers_num
        FROM mhrs_prev
        WHERE eff_to_dt = DATE '3500-12-31'
        GROUP BY 1
    ) AS crt
        ON bse.dvisn_wid = crt.dvisn_wid
),
dept_maxv AS (
    SELECT
        bse.dept_wid,
        COALESCE(crt.dept_vers_num, 1) AS dept_vers_num
    FROM (SELECT DISTINCT dept_wid FROM dwp01a_idw.dept WHERE cur_flg = 'Y') AS bse
    LEFT OUTER JOIN (
        SELECT
            dept_wid,
            MAX(dept_vers_num) AS dept_vers_num
        FROM mhrs_prev
        WHERE eff_to_dt = DATE '3500-12-31'
        GROUP BY 1
    ) AS crt
        ON bse.dept_wid = crt.dept_wid
),
item_clas_maxv AS (
    SELECT
        bse.item_clas_wid,
        COALESCE(crt.item_clas_vers_num, 1) AS item_clas_vers_num
    FROM (SELECT DISTINCT item_clas_wid FROM dwp01a_idw.item_clas WHERE cur_flg = 'Y') AS bse
    LEFT OUTER JOIN (
        SELECT
            item_clas_wid,
            MAX(item_clas_vers_num) AS item_clas_vers_num
        FROM mhrs_prev
        WHERE eff_to_dt = DATE '3500-12-31'
        GROUP BY 1
    ) AS crt
        ON bse.item_clas_wid = crt.item_clas_wid
),
pmk_item_sbclas_grp_maxv AS (
    SELECT
        bse.pmk_item_sbclas_grp_cd,
        COALESCE(crt.pmk_item_sbclas_grp_vers_num, 1) AS pmk_item_sbclas_grp_vers_num
    FROM (SELECT DISTINCT pmk_item_sbclas_grp_cd FROM dwp01a_idw.item_sbclas WHERE cur_flg = 'Y') AS bse
    LEFT OUTER JOIN (
        SELECT
            pmk_item_sbclas_grp_cd,
            MAX(pmk_item_sbclas_grp_vers_num) AS pmk_item_sbclas_grp_vers_num
        FROM mhrs_prev
        WHERE eff_to_dt = DATE '3500-12-31'
        GROUP BY 1
    ) AS crt
        ON bse.pmk_item_sbclas_grp_cd = crt.pmk_item_sbclas_grp_cd
),
item_sbclas_maxv AS (
    SELECT
        bse.item_sbclas_wid,
        COALESCE(crt.item_sbclas_vers_num, 1) AS item_sbclas_vers_num
    FROM (SELECT DISTINCT item_sbclas_wid FROM dwp01a_idw.item_sbclas WHERE cur_flg = 'Y') AS bse
    LEFT OUTER JOIN (
        SELECT
            item_sbclas_wid,
            MAX(item_sbclas_vers_num) AS item_sbclas_vers_num
        FROM mhrs_prev
        WHERE eff_to_dt = DATE '3500-12-31'
        GROUP BY 1
    ) AS crt
        ON bse.item_sbclas_wid = crt.item_sbclas_wid
),
-- CTEs for Set A (Historical Data)
-- These CTEs define "Set A" by selecting the current, active records from the version cross-reference table.
-- This represents the "before" state of style assignments.
pmk_co_a AS (
    SELECT
        pmk_co_wid,
        styl_wid,
        pmk_co_vers_num
    FROM mhrs_prev
),
dvisn_a AS (
    SELECT
        dvisn_wid,
        styl_wid,
        dvisn_vers_num
    FROM mhrs_prev
),
dept_a AS (
    SELECT
        dept_wid,
        styl_wid,
        dvisn_vers_num
    FROM mhrs_prev
),
item_clas_a AS (
    SELECT
        item_clas_wid,
        styl_wid,
        item_clas_vers_num
    FROM mhrs_prev
),
pmk_item_sbclas_grp_a AS (
    SELECT
        pmk_item_sbclas_grp_cd,
        styl_wid,
        pmk_item_sbclas_grp_vers_num
    FROM mhrs_prev
),
item_sbclas_a AS (
    SELECT
        item_sbclas_wid,
        styl_wid,
        item_sbclas_vers_num
    FROM mhrs_prev
),
-- CTEs for Set B (Current Data)
-- These CTEs define "Set B" by selecting from the mhrs CTE.
-- This represents the "after" or current state of style assignments.
pmk_co_b AS (
    SELECT pmk_co_wid, styl_wid FROM mhrs
),
dvisn_b AS (
    SELECT dvisn_wid, styl_wid FROM mhrs
),
dept_b AS (
    SELECT dept_wid, styl_wid FROM mhrs
),
item_clas_b AS (
    SELECT item_clas_wid, styl_wid FROM mhrs
),
pmk_item_sbclas_grp_b AS (
    SELECT pmk_item_sbclas_grp_cd, styl_wid FROM mhrs
),
item_sbclas_b AS (
    SELECT item_sbclas_wid, styl_wid FROM mhrs
),
-- CTEs for AB Merge
-- These CTEs perform a FULL OUTER JOIN on Set A and Set B for each hierarchy level.
-- This allows us to see which styles are in A only (removed), in B only (added), or in both (unchanged).
pmk_co_ab AS (
    SELECT
        COALESCE(a.styl_wid, b.styl_wid) AS styl_wid,
        COALESCE(a.pmk_co_wid, b.pmk_co_wid) AS pmk_co_wid,
        CASE
            WHEN a.styl_wid = b.styl_wid THEN 'AB' -- In both A and B (unchanged)
            WHEN a.styl_wid IS NOT NULL AND b.styl_wid IS NULL THEN 'A' -- In A only (removed)
            WHEN b.styl_wid IS NOT NULL AND a.styl_wid IS NULL THEN 'B' -- In B only (added)
        END AS set_status,
        MAX(a.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS a_styl_wid,
        MAX(b.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS b_styl_wid,
        CASE WHEN a_styl_wid = b_styl_wid THEN 1 ELSE 0 END AS common_aub
    FROM pmk_co_a AS a
    FULL OUTER JOIN pmk_co_b AS b
        ON a.pmk_co_wid = b.pmk_co_wid AND a.styl_wid = b.styl_wid
),
dvisn_ab AS (
    SELECT
        COALESCE(a.styl_wid, b.styl_wid) AS styl_wid,
        COALESCE(a.dvisn_wid, b.dvisn_wid) AS dvisn_wid,
        CASE
            WHEN a.styl_wid = b.styl_wid THEN 'AB'
            WHEN a.styl_wid IS NOT NULL AND b.styl_wid IS NULL THEN 'A'
            WHEN b.styl_wid IS NOT NULL AND a.styl_wid IS NULL THEN 'B'
        END AS set_status,
        MAX(a.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS a_styl_wid,
        MAX(b.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS b_styl_wid,
        CASE WHEN a_styl_wid = b_styl_wid THEN 1 ELSE 0 END AS common_aub
    FROM dvisn_a AS a
    FULL OUTER JOIN dvisn_b AS b
        ON a.dvisn_wid = b.dvisn_wid AND a.styl_wid = b.styl_wid
),
dept_ab AS (
    SELECT
        COALESCE(a.styl_wid, b.styl_wid) AS styl_wid,
        COALESCE(a.dept_wid, b.dept_wid) AS dept_wid,
        CASE
            WHEN a.styl_wid = b.styl_wid THEN 'AB'
            WHEN a.styl_wid IS NOT NULL AND b.styl_wid IS NULL THEN 'A'
            WHEN b.styl_wid IS NOT NULL AND a.styl_wid IS NULL THEN 'B'
        END AS set_status,
        MAX(a.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS a_styl_wid,
        MAX(b.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS b_styl_wid,
        CASE WHEN a_styl_wid = b_styl_wid THEN 1 ELSE 0 END AS common_aub
    FROM dept_a AS a
    FULL OUTER JOIN dept_b AS b
        ON a.dept_wid = b.dept_wid AND a.styl_wid = b.styl_wid
),
item_clas_ab AS (
    SELECT
        COALESCE(a.styl_wid, b.styl_wid) AS styl_wid,
        COALESCE(a.item_clas_wid, b.item_clas_wid) AS item_clas_wid,
        CASE
            WHEN a.styl_wid = b.styl_wid THEN 'AB'
            WHEN a.styl_wid IS NOT NULL AND b.styl_wid IS NULL THEN 'A'
            WHEN b.styl_wid IS NOT NULL AND a.styl_wid IS NULL THEN 'B'
        END AS set_status,
        MAX(a.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS a_styl_wid,
        MAX(b.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS b_styl_wid,
        CASE WHEN a_styl_wid = b_styl_wid THEN 1 ELSE 0 END AS common_aub
    FROM item_clas_a AS a
    FULL OUTER JOIN item_clas_b AS b
        ON a.item_clas_wid = b.item_clas_wid AND a.styl_wid = b.styl_wid
),
pmk_item_sbclas_grp_ab AS (
    SELECT
        COALESCE(a.styl_wid, b.styl_wid) AS styl_wid,
        COALESCE(a.pmk_item_sbclas_grp_cd, b.pmk_item_sbclas_grp_cd) AS pmk_item_sbclas_grp_cd,
        CASE
            WHEN a.styl_wid = b.styl_wid THEN 'AB'
            WHEN a.styl_wid IS NOT NULL AND b.styl_wid IS NULL THEN 'A'
            WHEN b.styl_wid IS NOT NULL AND a.styl_wid IS NULL THEN 'B'
        END AS set_status,
        MAX(a.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS a_styl_wid,
        MAX(b.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS b_styl_wid,
        CASE WHEN a_styl_wid = b_styl_wid THEN 1 ELSE 0 END AS common_aub
    FROM pmk_item_sbclas_grp_a AS a
    FULL OUTER JOIN pmk_item_sbclas_grp_b AS b
        ON a.pmk_item_sbclas_grp_cd = b.pmk_item_sbclas_grp_cd AND a.styl_wid = b.styl_wid
),
item_sbclas_ab AS (
    SELECT
        COALESCE(a.styl_wid, b.styl_wid) AS styl_wid,
        COALESCE(a.item_sbclas_wid, b.item_sbclas_wid) AS item_sbclas_wid,
        CASE
            WHEN a.styl_wid = b.styl_wid THEN 'AB'
            WHEN a.styl_wid IS NOT NULL AND b.styl_wid IS NULL THEN 'A'
            WHEN b.styl_wid IS NOT NULL AND a.styl_wid IS NULL THEN 'B'
        END AS set_status,
        MAX(a.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS a_styl_wid,
        MAX(b.styl_wid) OVER (PARTITION BY COALESCE(a.styl_wid, b.styl_wid)) AS b_styl_wid,
        CASE WHEN a_styl_wid = b_styl_wid THEN 1 ELSE 0 END AS common_aub
    FROM item_sbclas_a AS a
    FULL OUTER JOIN item_sbclas_b AS b
        ON a.item_sbclas_wid = b.item_sbclas_wid AND a.styl_wid = b.styl_wid
),
-- CTEs for Cardinality Calculation
-- These CTEs calculate the counts of added, removed, and unchanged styles.
-- The 'version_inc' flag is set to 1 if there are any changes.
pmk_co_ab_card AS (
    SELECT
        pmk_co_wid,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_amb, -- A minus B
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_bma, -- B minus A
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_anb, -- A intersect B
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_unamb, -- not common A minus B
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_unbma, -- not common B minus A
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_unanb, -- not common A intersect B
        CASE WHEN card_amb > 0 OR card_bma > 0 THEN 1 ELSE 0 END AS version_inc
    FROM pmk_co_ab AS ab
    GROUP BY 1
),
dvisn_ab_card AS (
    SELECT
        dvisn_wid,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_amb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_bma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_anb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_unamb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_unbma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_unanb,
        CASE WHEN card_amb > 0 OR card_bma > 0 THEN 1 ELSE 0 END AS version_inc
    FROM dvisn_ab AS ab
    GROUP BY 1
),
dept_ab_card AS (
    SELECT
        dept_wid,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_amb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_bma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_anb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_unamb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_unbma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_unanb,
        CASE WHEN card_amb > 0 OR card_bma > 0 THEN 1 ELSE 0 END AS version_inc
    FROM dept_ab AS ab
    GROUP BY 1
),
item_clas_ab_card AS (
    SELECT
        item_clas_wid,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_amb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_bma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_anb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_unamb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_unbma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_unanb,
        CASE WHEN card_amb > 0 OR card_bma > 0 THEN 1 ELSE 0 END AS version_inc
    FROM item_clas_ab AS ab
    GROUP BY 1
),
pmk_item_sbclas_grp_ab_card AS (
    SELECT
        pmk_item_sbclas_grp_cd,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_amb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_bma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_anb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_unamb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_unbma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_unanb,
        CASE WHEN card_amb > 0 OR card_bma > 0 THEN 1 ELSE 0 END AS version_inc
    FROM pmk_item_sbclas_grp_ab AS ab
    GROUP BY 1
),
item_sbclas_ab_card AS (
    SELECT
        item_sbclas_wid,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_amb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_bma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 1 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_anb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'A' THEN 1 ELSE 0 END), 0) AS card_unamb,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'B' THEN 1 ELSE 0 END), 0) AS card_unbma,
        COALESCE(SUM(CASE WHEN ab.common_aub = 0 AND ab.set_status = 'AB' THEN 1 ELSE 0 END), 0) AS card_unanb,
        CASE WHEN card_amb > 0 OR card_bma > 0 THEN 1 ELSE 0 END AS version_inc
    FROM item_sbclas_ab AS ab
    GROUP BY 1
),
-- CTEs for Version Calculation
-- These CTEs determine the new version number by adding the 'version_inc' flag to the max version.
pmk_co_version AS (
    SELECT
        maxv.pmk_co_wid,
        NVL2(ab_card.version_inc, COALESCE(maxv.pmk_co_vers_num, 1) + ab_card.version_inc, 0) AS new_pmk_co_vers_num,
        card_amb,
        card_bma,
        card_anb,
        card_unamb,
        card_unbma,
        card_unanb
    FROM pmk_co_maxv AS maxv
    LEFT OUTER JOIN pmk_co_ab_card AS ab_card
        ON maxv.pmk_co_wid = ab_card.pmk_co_wid
),
dvisn_version AS (
    SELECT
        maxv.dvisn_wid,
        NVL2(ab_card.version_inc, COALESCE(maxv.dvisn_vers_num, 1) + ab_card.version_inc, 0) AS new_dvisn_vers_num,
        card_amb,
        card_bma,
        card_anb,
        card_unamb,
        card_unbma,
        card_unanb
    FROM dvisn_maxv AS maxv
    LEFT OUTER JOIN dvisn_ab_card AS ab_card
        ON maxv.dvisn_wid = ab_card.dvisn_wid
),
dept_version AS (
    SELECT
        maxv.dept_wid,
        NVL2(ab_card.version_inc, COALESCE(maxv.dept_vers_num, 1) + ab_card.version_inc, 0) AS new_dept_vers_num,
        card_amb,
        card_bma,
        card_anb,
        card_unamb,
        card_unbma,
        card_unanb
    FROM dept_maxv AS maxv
    LEFT OUTER JOIN dept_ab_card AS ab_card
        ON maxv.dept_wid = ab_card.dept_wid
),
item_clas_version AS (
    SELECT
        maxv.item_clas_wid,
        NVL2(ab_card.version_inc, COALESCE(maxv.item_clas_vers_num, 1) + ab_card.version_inc, 0) AS new_item_clas_vers_num,
        card_amb,
        card_bma,
        card_anb,
        card_unamb,
        card_unbma,
        card_unanb
    FROM item_clas_maxv AS maxv
    LEFT OUTER JOIN item_clas_ab_card AS ab_card
        ON maxv.item_clas_wid = ab_card.item_clas_wid
),
pmk_item_sbclas_grp_version AS (
    SELECT
        maxv.pmk_item_sbclas_grp_cd,
        NVL2(ab_card.version_inc, COALESCE(maxv.pmk_item_sbclas_grp_vers_num, 1) + ab_card.version_inc, 0) AS new_pmk_item_sbclas_grp_vers_num,
        card_amb,
        card_bma,
        card_anb,
        card_unamb,
        card_unbma,
        card_unanb
    FROM pmk_item_sbclas_grp_maxv AS maxv
    LEFT OUTER JOIN pmk_item_sbclas_grp_ab_card AS ab_card
        ON maxv.pmk_item_sbclas_grp_cd = ab_card.pmk_item_sbclas_grp_cd
),
item_sbclas_version AS (
    SELECT
        maxv.item_sbclas_wid,
        NVL2(ab_card.version_inc, COALESCE(maxv.item_sbclas_vers_num, 1) + ab_card.version_inc, 0) AS new_item_sbclas_vers_num,
        card_amb,
        card_bma,
        card_anb,
        card_unamb,
        card_unbma,
        card_unanb
    FROM item_sbclas_maxv AS maxv
    LEFT OUTER JOIN item_sbclas_ab_card AS ab_card
        ON maxv.item_sbclas_wid = ab_card.item_sbclas_wid
)
-- Final SELECT Statement
-- This joins the original merchant hierarchy (mhr) with the calculated version numbers for each level.
-- The result is the complete hierarchy with the correct, newly calculated version numbers.
SELECT
    mhr.item_sbclas_wid AS merch_hiery_wid,
    mhr.pmk_co_cd AS company_cd,
    mhr.pmk_co_wid,
    mhr.pmk_co_name AS company_name,
    pmk_co_version.new_pmk_co_vers_num AS company_version_num,
    CASE WHEN mhr_prev.pmk_co_vers_num = pmk_co_version.new_pmk_co_vers_num THEN 0 ELSE 1 END AS pmk_co_vers_reclass_evnt_ind,
    COALESCE(pmk_co_version.card_amb, 0) AS pmk_co_stl_in_count,
    COALESCE(pmk_co_version.card_bma, 0) AS pmk_co_stl_out_count,
    COALESCE(pmk_co_version.card_anb, 0) AS pmk_co_stl_cmn_count,
    COALESCE(pmk_co_version.card_unamb, 0) AS pmk_co_stl_del_count,
    COALESCE(pmk_co_version.card_unbma, 0) AS pmk_co_stl_new_count,
    COALESCE(pmk_co_version.card_unanb, 0) AS pmk_co_stl_not_common_cmn_count,
    ROW_NUMBER() OVER (PARTITION BY mhr.pmk_co_wid ORDER BY mhr.item_sbclas_wid) AS pmk_co_seq_no,
    mhr.dvisn_cd AS division_cd,
    mhr.dvisn_wid,
    mhr.dvisn_name AS division_name,
    dvisn_version.new_dvisn_vers_num AS division_version_num,
    CASE WHEN mhr_prev.dvisn_vers_num = dvisn_version.new_dvisn_vers_num THEN 0 ELSE 1 END AS dvisn_vers_reclass_evnt_ind,
    COALESCE(dvisn_version.card_amb, 0) AS dvisn_stl_in_count,
    COALESCE(dvisn_version.card_bma, 0) AS dvisn_stl_out_count,
    COALESCE(dvisn_version.card_anb, 0) AS dvisn_stl_cmn_count,
    COALESCE(dvisn_version.card_unamb, 0) AS dvisn_stl_del_count,
    COALESCE(dvisn_version.card_unbma, 0) AS dvisn_stl_new_count,
    COALESCE(dvisn_version.card_unanb, 0) AS dvisn_stl_not_common_cmn_count,
    ROW_NUMBER() OVER (PARTITION BY mhr.dvisn_wid ORDER BY mhr.item_sbclas_wid) AS dvisn_seq_no,
    mhr.dept_cd AS department_cd,
    mhr.dept_wid,
    mhr.dept_name AS department_name,
    dept_version.new_dept_vers_num AS department_version_num,
    CASE WHEN mhr_prev.dept_vers_num = dept_version.new_dept_vers_num THEN 0 ELSE 1 END AS dept_reclass_evnt_ind,
    COALESCE(dept_version.card_amb, 0) AS dept_stl_in_count,
    COALESCE(dept_version.card_bma, 0) AS dept_stl_out_count,
    COALESCE(dept_version.card_anb, 0) AS dept_stl_cmn_count,
    COALESCE(dept_version.card_unamb, 0) AS dept_stl_del_count,
    COALESCE(dept_version.card_unbma, 0) AS dept_stl_new_count,
    COALESCE(dept_version.card_unanb, 0) AS dept_stl_not_common_cmn_count,
    ROW_NUMBER() OVER (PARTITION BY mhr.dept_wid ORDER BY mhr.item_sbclas_wid) AS dept_seq_no,
    mhr.item_clas_cd AS class_cd,
    mhr.item_clas_wid,
    mhr.item_clas_name AS class_name,
    item_clas_version.new_item_clas_vers_num AS class_version_num,
    CASE WHEN mhr_prev.item_clas_vers_num = item_clas_version.new_item_clas_vers_num THEN 0 ELSE 1 END AS clas_evnt_ind,
    COALESCE(item_clas_version.card_amb, 0) AS item_clas_stl_in_count,
    COALESCE(item_clas_version.card_bma, 0) AS item_clas_stl_out_count,
    COALESCE(item_clas_version.card_anb, 0) AS item_clas_stl_cmn_count,
    COALESCE(item_clas_version.card_unamb, 0) AS item_clas_stl_del_count,
    COALESCE(item_clas_version.card_unbma, 0) AS item_clas_stl_new_count,
    COALESCE(item_clas_version.card_unanb, 0) AS item_clas_stl_not_common_cmn_count,
    ROW_NUMBER() OVER (PARTITION BY mhr.item_clas_wid ORDER BY mhr.item_sbclas_wid) AS item_clas_seq_no,    
    mhr.pmk_item_sbclas_grp_cd AS subclass_group_cd,
    mhr.pmk_item_sbclas_grp_name AS subclass_group_name,
    pmk_item_sbclas_grp_version.new_pmk_item_sbclas_grp_vers_num AS subclass_group_version_num,
    CASE WHEN mhr_prev.pmk_item_sbclas_grp_vers_num = pmk_item_sbclas_grp_version.new_pmk_item_sbclas_grp_vers_num THEN 0 ELSE 1 END AS pmk_item_sbclas_grp_vers_reclass_evnt_ind,
    COALESCE(pmk_item_sbclas_grp_version.card_amb, 0) AS pmk_item_sbclas_grp_stl_in_count,
    COALESCE(pmk_item_sbclas_grp_version.card_bma, 0) AS pmk_item_sbclas_grp_stl_out_count,
    COALESCE(pmk_item_sbclas_grp_version.card_anb, 0) AS pmk_item_sbclas_grp_stl_cmn_count,
    COALESCE(pmk_item_sbclas_grp_version.card_unamb, 0) AS pmk_item_sbclas_grp_stl_del_count,
    COALESCE(pmk_item_sbclas_grp_version.card_unbma, 0) AS pmk_item_sbclas_grp_stl_new_count,
    COALESCE(pmk_item_sbclas_grp_version.card_unanb, 0) AS pmk_item_sbclas_grp_stl_not_common_cmn_count,
    ROW_NUMBER() OVER (PARTITION BY mhr.pmk_item_sbclas_grp_cd ORDER BY mhr.item_sbclas_wid) AS pmk_item_sbclas_grp_seq_no, 
    mhr.item_sbclas_cd AS subclass_cd,
  --  mhr.item_sbclas_wid,
    mhr.item_sbclas_name AS subclass_name,
    item_sbclas_version.new_item_sbclas_vers_num AS subclass_version_num,
    CASE WHEN mhr_prev.item_sbclas_vers_num = item_sbclas_version.new_item_sbclas_vers_num THEN 0 ELSE 1 END AS subclass_vers_reclass_evnt_ind,
    COALESCE(item_sbclas_version.card_amb, 0) AS item_sbclas_stl_in_count,
    COALESCE(item_sbclas_version.card_bma, 0) AS item_sbclas_stl_out_count,
    COALESCE(item_sbclas_version.card_anb, 0) AS item_sbclas_stl_cmn_count,
    COALESCE(item_sbclas_version.card_unamb, 0) AS item_sbclas_stl_del_count,
    COALESCE(item_sbclas_version.card_unbma, 0) AS item_sbclas_stl_new_count,
    COALESCE(item_sbclas_version.card_unanb, 0) AS item_sbclas_stl_not_common_cmn_count,
    ROW_NUMBER() OVER (PARTITION BY mhr.pmk_item_sbclas_grp_cd ORDER BY mhr.item_sbclas_wid) AS item_sbclas_seq_no, 
    mhr.buyer_cd,
    mhr.buyer_name
FROM mhr
LEFT OUTER JOIN pmk_co_version
    ON mhr.pmk_co_wid = pmk_co_version.pmk_co_wid
LEFT OUTER JOIN dvisn_version
    ON mhr.dvisn_wid = dvisn_version.dvisn_wid
LEFT OUTER JOIN dept_version
    ON mhr.dept_wid = dept_version.dept_wid
LEFT OUTER JOIN item_clas_version
    ON mhr.item_clas_wid = item_clas_version.item_clas_wid
LEFT OUTER JOIN pmk_item_sbclas_grp_version
    ON mhr.pmk_item_sbclas_grp_cd = pmk_item_sbclas_grp_version.pmk_item_sbclas_grp_cd
LEFT OUTER JOIN item_sbclas_version
    ON mhr.item_sbclas_wid = item_sbclas_version.item_sbclas_wid
LEFT OUTER JOIN mhr_prev
    ON mhr.item_sbclas_wid = mhr_prev.merch_hiery_wid
;
.IF ERRORCODE <> 0 THEN .QUIT 101



/* Collect statistics for the table */
COLLECT STATISTICS COLUMN(merch_hiery_wid) ON DW${INSTANCE}T_TMP_ACC_FND.FND_MERC_HIERARCHY_DIM
;
.IF ERRORCODE <> 0 THEN .QUIT 101


/* End of step */