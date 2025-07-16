
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}T_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_LOC_AGG_DAILY_ORDER_FCT = */
CREATE MULTISET TABLE DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT
    (
    location_id INTEGER NOT NULL ,
    item_id BIGINT NOT NULL ,
    pack_number VARCHAR(30) NOT NULL ,
    po_approved_date DATE  FORMAT 'YYYY-MM-DD',
    country_of_origin VARCHAR(30)  ,
    handover_date DATE  FORMAT 'YYYY-MM-DD',
    next_delivery_date DATE  FORMAT 'YYYY-MM-DD',
    planned_handover_date DATE  FORMAT 'YYYY-MM-DD',
    actual_handover_date DATE  FORMAT 'YYYY-MM-DD',
    purchase_order_number BIGINT NOT NULL ,
    purchase_order_status VARCHAR(30)  ,
    master_order_number BIGINT  ,
    supplier_name VARCHAR(300)  ,
    po_exit_port VARCHAR(30)  ,
    order_retail_amount DECIMAL(18,10)  ,
    order_units INTEGER  ,
    order_supplier_cost_amount DECIMAL(18,10)  ,
    order_pack_units INTEGER  ,
    cancelled_quantity_in_packs INTEGER  ,
    cancelled_quantity_in_units INTEGER  ,
    cancelled_supplier_cost_amount DECIMAL(18,10)  ,
    cancelled_retail_amount INTEGER  ,
    order_actual_in_transit_time INTEGER  ,
    order_est_intake_landed_cost_price DECIMAL(18,10)  ,
    order_est_intake_landed_cost_value DECIMAL(18,10)  ,
    order_est_gross_landed_cost_value DECIMAL(18,10)  ,
    order_est_freight_cost_value DECIMAL(18,10)  ,
    order_est_duty_cost_value DECIMAL(18,10)  ,
    order_est_ppq_cost_value DECIMAL(18,10)  ,
    order_est_insurance_cost_value DECIMAL(18,10)  ,
    order_est_distribution_cost_value DECIMAL(18,10)  ,
    order_est_handling_cost_value DECIMAL(18,10)  ,
    order_est_gsp_cost_value DECIMAL(18,10)  ,
    order_est_dtr_cost_value DECIMAL(18,10)  ,
    order_est_agentscommission_cost_value DECIMAL(18,10)  ,
    order_est_inspection_cost_value DECIMAL(18,10)  ,
    order_act_gross_landed_cost_price DECIMAL(18,10)  ,
    order_act_gross_landed_cost_value DECIMAL(18,10)  ,
    order_act_intake_landed_cost_price DECIMAL(18,10)  ,
    order_act_intake_landed_cost_value DECIMAL(18,10)  ,
    order_act_freight_cost_value DECIMAL(18,10)  ,
    order_act_duty_cost_value DECIMAL(18,10)  ,
    order_act_ppq_cost_value DECIMAL(18,10)  ,
    order_act_insurance_cost_value DECIMAL(18,10)  ,
    order_act_distribution_cost_value DECIMAL(18,10)  ,
    order_act_handling_cost_value DECIMAL(18,10)  ,
    order_act_gsp_cost_value DECIMAL(18,10)  ,
    order_act_dtr_cost_value DECIMAL(18,10)  ,
    order_act_agentscommission_cost_value DECIMAL(18,10)  ,
    order_act_inspection_cost_value DECIMAL(18,10)  ,
    order_act_others_cost_value DECIMAL(18,10)  ,
    order_est_others_cost_value DECIMAL(18,10)  ,
    lc_price_outstanding_value_gross DECIMAL(18,10)  ,
    lc_price_outstanding_value_intake DECIMAL(18,10)  ,
    intake_retail_value DECIMAL(18,10)  ,
    intake_units INTEGER  ,
    intake_supplier_cost_amount DECIMAL(18,10)  ,
    intake_pack_units INTEGER  ,
    on_order_units INTEGER  ,
    on_order_supplier_cost_amount DECIMAL(18,10)  ,
    on_order_retail_amount DECIMAL(18,10)  ,
    on_order_pack_units INTEGER  ,
    intake_cartons DECIMAL(18,10)  ,
    receipt_dt DATE  ,
    receipt_week VARCHAR(255)  ,
    received_qty_cum INTEGER  ,
    pre_receipt_retail_amount VARCHAR(255)  ,
    pre_receipt_cost_amount DECIMAL(18,10)  ,
    pre_receipts_pack_units INTEGER  ,
    pre_receipt_units INTEGER  ,
    shipped_qty INTEGER  ,
    supplier_cost_shipped DECIMAL(18,10)  ,
    retail_value_shipped DECIMAL(18,10)  ,
    expected_gross_margin DECIMAL(18,10)  ,
    expected_intake_margin DECIMAL(18,10)  ,
    actual_gross_margin DECIMAL(18,10)  ,
    actual_intake_margin DECIMAL(18,10)  ,
    non_merch_invoiced_amount DECIMAL(18,10)  ,
    cummilative_nonmerch_invoiced_amount DECIMAL(18,10)  ,
    freight_invoiced_amount DECIMAL(18,10)  ,
    gsp_invoiced_amount DECIMAL(18,10)  ,
    last_freight_invoiced_date DATE  FORMAT 'YYYY-MM-DD',
    duty_invoiced_amount DECIMAL(18,10)  ,
    last_duty_invoiced_date DATE  FORMAT 'YYYY-MM-DD',
    number_of_weeks_rolled_forward INTEGER  ,
    shipping_method VARCHAR(255)  ,
    total_shipping_unit INTEGER  ,
    merch_invoice_amount VARCHAR(255)  ,
    fir_intake_date DATE  FORMAT 'YYYY-MM-DD',
    fir_intake_retail_value DECIMAL(18,10)  ,
    fir_intake_units INTEGER  ,
    fir_intake_week VARCHAR(255)  ,
    cartons_sets VARCHAR(3)  ,
    commitment_date DATE  FORMAT 'YYYY-MM-DD',
    item_unit_retail_price DECIMAL(18,10)  ,
    item_unit_selling_price DECIMAL(18,10)  ,
    item_unit_supplier_cost DECIMAL(18,10)  ,
    item_vat_rate DECIMAL(18,10)  ,
    last_gsp_invoiced_date DATE  FORMAT 'YYYY-MM-DD',
    no_of_cartons INTEGER  ,
    no_of_cartons_sets INTEGER  ,
    no_of_sets INTEGER  ,
    order_next_delivery_week VARCHAR(30)  ,
    order_currency CHAR(3)  ,
    pack_item_unit_quantity INTEGER  ,
    supplier_country VARCHAR(30)  ,
    order_exchange_rate DECIMAL(18,10)  ,
    nonmerch_invc_dt DATE  ,
    merch_invc_dt DATE  ,
    plan_vs_act_handover_date DATE  FORMAT 'YYYY-MM-DD',
    last_pick_date DATE  FORMAT 'YYYY-MM-DD',
    last_recieved_date DATE  FORMAT 'YYYY-MM-DD',
    on_time_delivery CHAR(1)  ,
    fir_commitment_due_date DATE  FORMAT 'YYYY-MM-DD',
    fir_commitment_week VARCHAR(30)  ,
    booked_delivery_date DATE  FORMAT 'YYYY-MM-DD',
    estimated_arr_dt DATE  ,
    container_id VARCHAR(50)  ,
    num_of_container BIGINT  ,
    landed_cost_price_estimate_gross DECIMAL(18,10)  ,
    factory_name VARCHAR(255)  ,
    factory_id VARCHAR(30)  ,
    confirmed_intake_wk VARCHAR(30)  ,
    factory_country_cd VARCHAR(30)  ,
    factory_country_name VARCHAR(255)  ,
    shipping_term_desc VARCHAR(255)  ,
    exit_port_country_code VARCHAR(255)  ,
    exit_port_country_name VARCHAR(255)  ,
    vessel_name VARCHAR(30)  ,
    packing_method VARCHAR(255)  ,
    vendor_purchase_order_number VARCHAR(30)  ,
    dsd CHAR(1)  ,
    /* Control columns for auditing */
    eff_from_dt DATE NOT NULL,
    eff_to_dt DATE NOT NULL COMPRESS(DATE '3500-12-31'),
    del_ind BYTEINT NOT NULL COMPRESS(0),
    run_id INTEGER NOT NULL,
    update_run_id INTEGER COMPRESS(NULL) ,
    job_id VARCHAR(300) NOT NULL COMPRESS('JOBID'),
    update_job_id VARCHAR(30) COMPRESS(NULL)
    )
    PRIMARY INDEX ( location_id ,item_id )
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT AS 'This is the foundation date dimension'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.location_id AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_id AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pack_number AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.po_approved_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.country_of_origin AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.handover_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.next_delivery_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.planned_handover_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.actual_handover_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.purchase_order_number AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.purchase_order_status AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.master_order_number AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.supplier_name AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.po_exit_port AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_retail_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_supplier_cost_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_pack_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cancelled_quantity_in_packs AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cancelled_quantity_in_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cancelled_supplier_cost_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cancelled_retail_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_actual_in_transit_time AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_intake_landed_cost_price AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_intake_landed_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_gross_landed_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_freight_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_duty_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_ppq_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_insurance_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_distribution_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_handling_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_gsp_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_dtr_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_agentscommission_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_inspection_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_gross_landed_cost_price AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_gross_landed_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_intake_landed_cost_price AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_intake_landed_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_freight_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_duty_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_ppq_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_insurance_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_distribution_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_handling_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_gsp_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_dtr_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_agentscommission_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_inspection_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_others_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_others_cost_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.lc_price_outstanding_value_gross AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.lc_price_outstanding_value_intake AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_retail_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_supplier_cost_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_pack_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_order_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_order_supplier_cost_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_order_retail_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_order_pack_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_cartons AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.receipt_dt AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.receipt_week AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.received_qty_cum AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pre_receipt_retail_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pre_receipt_cost_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pre_receipts_pack_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pre_receipt_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.shipped_qty AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.supplier_cost_shipped AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.retail_value_shipped AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.expected_gross_margin AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.expected_intake_margin AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.actual_gross_margin AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.actual_intake_margin AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.non_merch_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cummilative_nonmerch_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.freight_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.gsp_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_freight_invoiced_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.duty_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_duty_invoiced_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.number_of_weeks_rolled_forward AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.shipping_method AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.total_shipping_unit AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.merch_invoice_amount AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_intake_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_intake_retail_value AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_intake_units AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_intake_week AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cartons_sets AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.commitment_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_unit_retail_price AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_unit_selling_price AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_unit_supplier_cost AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_vat_rate AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_gsp_invoiced_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.no_of_cartons AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.no_of_cartons_sets AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.no_of_sets AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_next_delivery_week AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_currency AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pack_item_unit_quantity AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.supplier_country AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_exchange_rate AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.nonmerch_invc_dt AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.merch_invc_dt AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.plan_vs_act_handover_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_pick_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_recieved_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_time_delivery AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_commitment_due_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_commitment_week AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.booked_delivery_date AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.estimated_arr_dt AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.container_id AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.num_of_container AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.landed_cost_price_estimate_gross AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.factory_name AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.factory_id AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.confirmed_intake_wk AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.factory_country_cd AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.factory_country_name AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.shipping_term_desc AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.exit_port_country_code AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.exit_port_country_name AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.vessel_name AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.packing_method AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.vendor_purchase_order_number AS 'NOT DEFINED'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.dsd AS 'NOT DEFINED'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF TABLE CREATION
*-------------------------------------------------------------------------------*/