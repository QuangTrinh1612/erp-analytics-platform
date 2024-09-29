{{ config(
    materialized='incremental',
    unique_key='ap_line_item_id'
) }}

WITH ap_invoice_lines AS (
    SELECT 
        inv_line.invoice_line_id AS ap_line_item_id,
        inv_line.invoice_id,
        inv_line.line_number,
        inv_line.line_type_lookup_code AS line_type,
        inv_line.quantity_invoiced,
        inv_line.unit_price,
        inv_line.line_amount,
        inv_line.tax_amount,
        inv_line.description AS line_description,
        inv_line.accounting_date,
        inv_line.distribution_set_id,
        inv_line.gl_date,
        inv_line.code_combination_id AS gl_code_combination_id,
        inv_line.creation_date AS line_creation_date,
        inv_line.last_update_date AS line_last_update_date,
        inv_line.currency_code
    FROM 
        {{ source('oracle_fusion_finance', 'AP_INVOICE_LINES_ALL') }} inv_line
),

ap_invoices AS (
    SELECT 
        inv.invoice_id,
        inv.invoice_num AS invoice_number,
        inv.invoice_date,
        inv.supplier_id,
        inv.vendor_site_id AS supplier_site_id,
        inv.amount AS invoice_amount,
        inv.payment_status,
        inv.payment_status_flag,
        inv.creation_date AS invoice_creation_date,
        inv.last_update_date AS invoice_last_update_date,
        inv.currency_code
    FROM 
        {{ source('oracle_fusion_finance', 'AP_INVOICES_ALL') }} inv
),

po_distributions AS (
    SELECT 
        po_dist.distribution_id,
        po_dist.line_location_id,
        po_dist.po_header_id,
        po_dist.quantity_ordered,
        po_dist.quantity_billed,
        po_dist.quantity_delivered,
        po_dist.po_distribution_id,
        po_dist.creation_date AS po_distribution_creation_date,
        po_dist.last_update_date AS po_distribution_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'PO_DISTRIBUTIONS_ALL') }} po_dist
),

po_headers AS (
    SELECT 
        po_header.po_header_id,
        po_header.segment1 AS po_number,
        po_header.type_lookup_code AS po_type,
        po_header.vendor_id AS supplier_id,
        po_header.vendor_site_id AS supplier_site_id,
        po_header.creation_date AS po_creation_date,
        po_header.last_update_date AS po_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'PO_HEADERS_ALL') }} po_header
),

gl_codes AS (
    SELECT 
        gl_code_combination_id,
        code_combination AS gl_code_combination,
        segment1 || '.' || segment2 || '.' || segment3 || '.' || segment4 || '.' || segment5 AS gl_account
    FROM 
        {{ source('oracle_fusion_finance', 'GL_CODE_COMBINATIONS') }}
)

SELECT 
    ap_invoice_lines.ap_line_item_id,
    ap_invoice_lines.invoice_id,
    ap_invoice_lines.line_number,
    ap_invoice_lines.line_type,
    ap_invoice_lines.quantity_invoiced,
    ap_invoice_lines.unit_price,
    ap_invoice_lines.line_amount,
    ap_invoice_lines.tax_amount,
    ap_invoice_lines.line_description,
    ap_invoice_lines.accounting_date,
    ap_invoice_lines.gl_date,
    ap_invoice_lines.currency_code,
    ap_invoice_lines.gl_code_combination_id,
    gl.gl_account AS gl_account_code,
    ap_invoices.invoice_number,
    ap_invoices.invoice_date,
    ap_invoices.supplier_id,
    ap_invoices.invoice_amount,
    ap_invoices.payment_status,
    ap_invoices.payment_status_flag,
    ap_invoices.invoice_creation_date,
    ap_invoices.invoice_last_update_date,
    po_distributions.po_header_id,
    po_headers.po_number,
    po_headers.po_type,
    po_headers.supplier_id AS po_supplier_id,
    po_headers.po_creation_date,
    po_headers.po_last_update_date
FROM 
    ap_invoice_lines
LEFT JOIN 
    ap_invoices ON ap_invoice_lines.invoice_id = ap_invoices.invoice_id
LEFT JOIN 
    po_distributions ON ap_invoice_lines.distribution_set_id = po_distributions.distribution_id
LEFT JOIN 
    po_headers ON po_distributions.po_header_id = po_headers.po_header_id
LEFT JOIN 
    gl_codes gl ON ap_invoice_lines.gl_code_combination_id = gl.gl_code_combination_id

{% if is_incremental() %}
WHERE ap_invoice_lines.line_last_update_date > (SELECT MAX(line_last_update_date) FROM {{ this }})
{% endif %}
