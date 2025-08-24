/*
This MERGE statement updates the target pivot table (FND_SLS_FCT_PVT_STG)
from the source staging table (FND_SLS_FCT_01_FCT_STG).
Key Logic:
1. Records are matched on business_date, loc_wid, and item_wid.
2. WHEN MATCHED:
   - The fct_src_map is updated using a bitwise OR (BITOR).
   - This combines the bitmask from the target with the bitmask from the source,
     preserving a history of all data sources that have contributed to the record.
     For example, if T.fct_src_map is 1 (binary 0001) and S.fct_src_map is 2 (binary 0010),
     the result will be 3 (binary 0011).
3. WHEN NOT MATCHED:
   - A new record is inserted into the target table with the data from the source.
*/
MERGE INTO DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_PVT_STG AS T
USING DW${INSTANCE}T_TMP_ACC_FND.FND_SLS_FCT_01_FCT_STG AS S
   ON T.business_date = S.business_date
  AND T.loc_wid = S.loc_wid
  AND T.item_wid = S.item_wid
WHEN MATCHED THEN
   UPDATE SET
      fct_src_map = BITOR(T.fct_src_map, S.fct_src_map)
WHEN NOT MATCHED THEN
   INSERT (
      business_date,
      loc_wid,
      item_wid,
      fct_src_map
   )
   VALUES (
      S.business_date,
      S.loc_wid,
      S.item_wid,
      S.fct_src_map
   );