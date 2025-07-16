
/*----------------------------------------------------------------------
* FileName: 
* Project: 
* Database: DW${INSTANCE}A_ACC_FND
* Schema: 
* Author: Mr Primark
* Created: 2025-01-01 
-----------------------------------------------------------------------*/
/* Create table for DW_FND_LOC_AGG_DAILY_ORDER_FCT */
REPLACE VIEW DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT
    AS LOCKING ROW FOR ACCESS

SELECT
    location_id ,
    item_id ,
    pack_number ,
    po_approved_date ,
    country_of_origin ,
    handover_date ,
    next_delivery_date ,
    planned_handover_date ,
    actual_handover_date ,
    purchase_order_number ,
    purchase_order_status ,
    master_order_number ,
    supplier_name ,
    po_exit_port ,
    order_retail_amount ,
    order_units ,
    order_supplier_cost_amount ,
    order_pack_units ,
    cancelled_quantity_in_packs ,
    cancelled_quantity_in_units ,
    cancelled_supplier_cost_amount ,
    cancelled_retail_amount ,
    order_actual_in_transit_time ,
    order_est_intake_landed_cost_price ,
    order_est_intake_landed_cost_value ,
    order_est_gross_landed_cost_value ,
    order_est_freight_cost_value ,
    order_est_duty_cost_value ,
    order_est_ppq_cost_value ,
    order_est_insurance_cost_value ,
    order_est_distribution_cost_value ,
    order_est_handling_cost_value ,
    order_est_gsp_cost_value ,
    order_est_dtr_cost_value ,
    order_est_agentscommission_cost_value ,
    order_est_inspection_cost_value ,
    order_act_gross_landed_cost_price ,
    order_act_gross_landed_cost_value ,
    order_act_intake_landed_cost_price ,
    order_act_intake_landed_cost_value ,
    order_act_freight_cost_value ,
    order_act_duty_cost_value ,
    order_act_ppq_cost_value ,
    order_act_insurance_cost_value ,
    order_act_distribution_cost_value ,
    order_act_handling_cost_value ,
    order_act_gsp_cost_value ,
    order_act_dtr_cost_value ,
    order_act_agentscommission_cost_value ,
    order_act_inspection_cost_value ,
    order_act_others_cost_value ,
    order_est_others_cost_value ,
    lc_price_outstanding_value_gross ,
    lc_price_outstanding_value_intake ,
    intake_retail_value ,
    intake_units ,
    intake_supplier_cost_amount ,
    intake_pack_units ,
    on_order_units ,
    on_order_supplier_cost_amount ,
    on_order_retail_amount ,
    on_order_pack_units ,
    intake_cartons ,
    receipt_dt ,
    receipt_week ,
    received_qty_cum ,
    pre_receipt_retail_amount ,
    pre_receipt_cost_amount ,
    pre_receipts_pack_units ,
    pre_receipt_units ,
    shipped_qty ,
    supplier_cost_shipped ,
    retail_value_shipped ,
    expected_gross_margin ,
    expected_intake_margin ,
    actual_gross_margin ,
    actual_intake_margin ,
    non_merch_invoiced_amount ,
    cummilative_nonmerch_invoiced_amount ,
    freight_invoiced_amount ,
    gsp_invoiced_amount ,
    last_freight_invoiced_date ,
    duty_invoiced_amount ,
    last_duty_invoiced_date ,
    number_of_weeks_rolled_forward ,
    shipping_method ,
    total_shipping_unit ,
    merch_invoice_amount ,
    fir_intake_date ,
    fir_intake_retail_value ,
    fir_intake_units ,
    fir_intake_week ,
    cartons_sets ,
    commitment_date ,
    item_unit_retail_price ,
    item_unit_selling_price ,
    item_unit_supplier_cost ,
    item_vat_rate ,
    last_gsp_invoiced_date ,
    no_of_cartons ,
    no_of_cartons_sets ,
    no_of_sets ,
    order_next_delivery_week ,
    order_currency ,
    pack_item_unit_quantity ,
    supplier_country ,
    order_exchange_rate ,
    nonmerch_invc_dt ,
    merch_invc_dt ,
    plan_vs_act_handover_date ,
    last_pick_date ,
    last_recieved_date ,
    on_time_delivery ,
    fir_commitment_due_date ,
    fir_commitment_week ,
    booked_delivery_date ,
    estimated_arr_dt ,
    container_id ,
    num_of_container ,
    landed_cost_price_estimate_gross ,
    factory_name ,
    factory_id ,
    confirmed_intake_wk ,
    factory_country_cd ,
    factory_country_name ,
    shipping_term_desc ,
    exit_port_country_code ,
    exit_port_country_name ,
    vessel_name ,
    packing_method ,
    vendor_purchase_order_number ,
    dsd ,
    /* Control columns for auditing */
    eff_from_dt,
    eff_to_dt,
    del_ind,
    run_id,
    update_run_id,
    job_id,
    update_job_id
FROM  DW${INSTANCE}T_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT
;

/*-----------------------------------------------------------------------------
* Comments for tables and columns
*-------------------------------------------------------------------------------*/

COMMENT ON VIEW DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT AS ''
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.location_id AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_id AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pack_number AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.po_approved_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.country_of_origin AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.handover_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.next_delivery_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.planned_handover_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.actual_handover_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.purchase_order_number AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.purchase_order_status AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.master_order_number AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.supplier_name AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.po_exit_port AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_retail_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_supplier_cost_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_pack_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cancelled_quantity_in_packs AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cancelled_quantity_in_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cancelled_supplier_cost_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cancelled_retail_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_actual_in_transit_time AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_intake_landed_cost_price AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_intake_landed_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_gross_landed_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_freight_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_duty_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_ppq_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_insurance_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_distribution_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_handling_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_gsp_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_dtr_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_agentscommission_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_inspection_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_gross_landed_cost_price AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_gross_landed_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_intake_landed_cost_price AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_intake_landed_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_freight_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_duty_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_ppq_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_insurance_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_distribution_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_handling_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_gsp_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_dtr_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_agentscommission_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_inspection_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_act_others_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_est_others_cost_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.lc_price_outstanding_value_gross AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.lc_price_outstanding_value_intake AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_retail_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_supplier_cost_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_pack_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_order_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_order_supplier_cost_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_order_retail_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_order_pack_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.intake_cartons AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.receipt_dt AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.receipt_week AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.received_qty_cum AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pre_receipt_retail_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pre_receipt_cost_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pre_receipts_pack_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pre_receipt_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.shipped_qty AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.supplier_cost_shipped AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.retail_value_shipped AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.expected_gross_margin AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.expected_intake_margin AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.actual_gross_margin AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.actual_intake_margin AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.non_merch_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cummilative_nonmerch_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.freight_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.gsp_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_freight_invoiced_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.duty_invoiced_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_duty_invoiced_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.number_of_weeks_rolled_forward AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.shipping_method AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.total_shipping_unit AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.merch_invoice_amount AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_intake_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_intake_retail_value AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_intake_units AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_intake_week AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.cartons_sets AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.commitment_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_unit_retail_price AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_unit_selling_price AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_unit_supplier_cost AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.item_vat_rate AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_gsp_invoiced_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.no_of_cartons AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.no_of_cartons_sets AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.no_of_sets AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_next_delivery_week AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_currency AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.pack_item_unit_quantity AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.supplier_country AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.order_exchange_rate AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.nonmerch_invc_dt AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.merch_invc_dt AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.plan_vs_act_handover_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_pick_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.last_recieved_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.on_time_delivery AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_commitment_due_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.fir_commitment_week AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.booked_delivery_date AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.estimated_arr_dt AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.container_id AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.num_of_container AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.landed_cost_price_estimate_gross AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.factory_name AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.factory_id AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.confirmed_intake_wk AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.factory_country_cd AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.factory_country_name AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.shipping_term_desc AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.exit_port_country_code AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.exit_port_country_name AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.vessel_name AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.packing_method AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.vendor_purchase_order_number AS 'NOT DEFINED'
;

COMMENT ON COLUMN DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.dsd AS 'NOT DEFINED'
;



    /* Control columns for auditing */
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.eff_from_dt AS 'The date from which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.eff_to_dt AS 'The date until which the record is valid'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.del_ind AS 'The deletion indicator for the record, 0 for active, 1 for deleted'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.run_id AS 'The run id of the ETL job that created the record'
;

COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.update_run_id AS 'The run id of the ETL job that last updated the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.job_id AS 'The job id of the ETL job that created the record'
;
COMMENT ON DW${INSTANCE}A_ACC_FND.DW_FND_LOC_AGG_DAILY_ORDER_FCT.update_job_id AS 'The job id of the ETL job that last updated the record'
;

/*-----------------------------------------------------------------------------
* END OF VIEW CREATION
*-------------------------------------------------------------------------------*/