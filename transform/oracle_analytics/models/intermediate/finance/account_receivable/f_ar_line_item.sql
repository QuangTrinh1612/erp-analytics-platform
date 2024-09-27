{{ config(
    materialized='incremental',
    unique_key='ar_line_item_id'
) }}

WITH ar_lines AS (
    SELECT 
        trx_line.customer_trx_line_id AS ar_line_item_id,
        trx_line.customer_trx_id,
        trx_line.line_number,
        trx_line.inventory_item_id,
        trx_line.quantity_ordered,
        trx_line.quantity_invoiced,
        trx_line.unit_selling_price,
        trx_line.extended_amount,
        trx_line.tax_amount,
        trx_line.accounting_rule_id,
        trx_line.line_type,
        trx_line.creation_date AS line_creation_date,
        trx_line.last_update_date AS line_last_update_date,
        trx_line.currency_code,
        trx_line.account_class,
        trx_line.gl_date,
        trx_line.gl_code_combination_id,
        trx_line.description AS line_description
    FROM 
        {{ source('oracle_fusion_finance', 'RA_CUSTOMER_TRX_LINES_ALL') }} trx_line
),

ar_transactions AS (
    SELECT 
        trx.customer_trx_id,
        trx.trx_number AS invoice_number,
        trx.trx_date AS invoice_date,
        trx.currency_code,
        trx.bill_to_customer_id,
        trx.bill_to_site_use_id,
        trx.ship_to_customer_id,
        trx.ship_to_site_use_id,
        trx.transaction_type_id,
        trx.creation_date AS trx_creation_date,
        trx.last_update_date AS trx_last_update_date,
        trx.trx_type_name AS transaction_type
    FROM 
        {{ source('oracle_fusion_finance', 'RA_CUSTOMER_TRX_ALL') }} trx
),

customers AS (
    SELECT 
        cust_acct.cust_account_id,
        cust_acct.party_id,
        cust_acct.account_number,
        cust_acct.account_name,
        cust_acct.creation_date AS customer_creation_date,
        cust_acct.last_update_date AS customer_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'HZ_CUST_ACCOUNTS') }} cust_acct
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
    ar_lines.ar_line_item_id,
    ar_lines.customer_trx_id,
    ar_lines.line_number,
    ar_lines.inventory_item_id,
    ar_lines.quantity_ordered,
    ar_lines.quantity_invoiced,
    ar_lines.unit_selling_price,
    ar_lines.extended_amount,
    ar_lines.tax_amount,
    ar_lines.line_creation_date,
    ar_lines.line_last_update_date,
    ar_lines.currency_code,
    ar_lines.account_class,
    ar_lines.gl_date,
    ar_lines.line_description,
    ar_lines.gl_code_combination_id,
    gl.gl_account AS gl_account_code,
    ar_transactions.invoice_number,
    ar_transactions.invoice_date,
    ar_transactions.transaction_type,
    ar_transactions.trx_creation_date,
    ar_transactions.trx_last_update_date,
    ar_transactions.bill_to_customer_id,
    ar_transactions.ship_to_customer_id,
    cust.account_number AS customer_account_number,
    cust.account_name AS customer_name,
    cust.customer_creation_date,
    cust.customer_last_update_date
FROM 
    ar_lines
LEFT JOIN 
    ar_transactions ON ar_lines.customer_trx_id = ar_transactions.customer_trx_id
LEFT JOIN 
    customers cust ON ar_transactions.bill_to_customer_id = cust.cust_account_id
LEFT JOIN 
    gl_codes gl ON ar_lines.gl_code_combination_id = gl.gl_code_combination_id

{% if is_incremental() %}
WHERE ar_lines.line_last_update_date > (SELECT MAX(line_last_update_date) FROM {{ this }})
{% endif %}
