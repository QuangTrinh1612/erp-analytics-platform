{{  
    config(
        materialized='incremental',
        unique_key='AR_Line_Item_Id',
        incremental_strategy='merge'
    )
}}
WITH ar_line AS (
    SELECT * FROM {{ ref('ra_customer_trx_line') }}
),
ar_header AS (
    SELECT * FROM {{ ref('ra_customer_trx_header') }}
),
ar_distribution AS (
    SELECT
        customer_trx_line_id,
        CAST(
            COLLECT_LIST(
                TO_JSON(
                    STRUCT(
                        cust_trx_line_gl_dist_id,
                        code_combination_id,
                        account_class,
                        gl_date,
                        gl_posted_date,
                        amount,
                        percent
                    )
                )
            ) AS STRING
        ) AS distribution_items
    FROM {{ ref('ra_customer_trx_distribution') }}
    GROUP BY ALL
)
SELECT
    -- Surrogate Key
    {{ dbt_utils.generate_surrogate_key(['hdr.customer_trx_id', 'line.customer_trx_line_id']) }} AS AR_Line_Item_Id,

    hdr.customer_trx_id,
    hdr.trx_number,
    hdr.trx_date,
    hdr.trx_class,
    hdr.source_document_type,
    hdr.document_sub_type,
    hdr.invoice_currency_code,
    hdr.exchange_rate,
    hdr.prepayment_flag,
    hdr.br_unpaid_flag,
    hdr.br_on_hold_flag,
    hdr.br_amount AS total_amount,

    hdr.bill_to_customer_id AS customer_id,
    hdr.bill_to_site_use_id AS customer_site_id,
    hdr.bill_to_customer_id || '-' || hdr.bill_to_site_use_id AS customer_site_key,

    line.customer_trx_line_id,
    line.line_number,
    line.line_type,
    line.description AS line_description,
    line.quantity_ordered,
    line.quantity_credited,
    line.quantity_invoiced,
    line.unit_standard_price,
    line.unit_selling_price,
    line.sales_order,
    line.sales_order_line,
    line.sales_order_date,
    line.inventory_item_id,
    line.previous_customer_trx_id as credit_memo_trx_id,
    line.previous_customer_trx_line_id as credit_memo_trx_line_id,
    line.revenue_amount,
    line.amount_due_remaining,
    line.tax_rate,
    line.uom_code,
    line.last_update_date as line_last_update_date,

    dist.distribution_items, -- JSON string of distribution items for each line,
    NOW() AS _etl_ingestion_time

FROM ar_header hdr
JOIN ar_line line ON hdr.customer_trx_id = line.customer_trx_id
LEFT JOIN ar_distribution dist ON line.customer_trx_line_id = dist.customer_trx_line_id

{% if is_incremental() %}
WHERE line.last_update_date > (SELECT COALESCE(MAX(line_last_update_date), '1970-01-01') FROM {{ this }})
{% endif %}