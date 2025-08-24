    SELECT
        stl.styl_wid,
        stl.item_sbclas_wid
    FROM DW${INSTANCE}A_IDW.STYL AS stl
    WHERE 
        -- eff to must be greater than eff from 
        -- this is needed because of incorret data in table
        stl.eff_to_dttm >  stl.eff_from_dttm
        -- load token date needs to be moved up by 1 so that the EOD position is caught
        -- CONTAINS is used to handle the Period data type
        AND  PERIOD(stl.eff_from_dttm, stl.eff_to_dttm) CONTAINS ((date '${LDTK_DATE}' + 1)(TIMESTAMP(0)))
        -- this is to handle incorrectly implemented soft deletes
        AND (
             --- if end date high and cur_flg=Y and del_flg=Y -- this is to hand the case where the eff_to is high and cur_flg=N , simulating a soft delete
             ( stl.eff_to_dttm = timestamp '3500-12-01 00:00:00' AND CUR_FLG = 'Y' AND DEL_FLG='N')
             -- this is standard need it to handle the exception above
             OR ( stl.eff_to_dttm <> timestamp '3500-12-01 00:00:00'  AND DEL_FLG='N')
            )