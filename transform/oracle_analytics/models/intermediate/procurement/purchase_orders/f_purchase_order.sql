{{
    config(
        materialized='incremental',
        unique_key='Purchase_Order_Id',
        incremental_strategy='merge'
    )
}}
WITH poh AS (
    SELECT * FROM {{ ref("purchase_order_header") }}
),
pol AS (
    SELECT * FROM {{ ref("purchase_order_line") }}
),
final AS (
    SELECT
        -- Surrogate Key
        {{ dbt_utils.generate_surrogate_key(['poh.po_header_id', 'pol.po_line_id']) }} AS Purchase_Order_Id,

        -- Purchase Order Header Information
        poh.po_header_id AS po_header_id,
        poh.segment1 AS po_number, -- Purchase Order Number
        poh.vendor_id AS vendor_id,
        poh.vendor_site_id AS vendor_site_id,
        poh.agent_id AS buyer_id,
        poh.currency_code as currency_code,
        poh.approved_date as approved_date,

        -- Purchase Order Line Information
        pol.po_line_id AS po_line_id,
        pol.line_type_id AS line_type_id,
        pol.line_num AS line_number,
        pol.prc_bu_id as prc_bu_id,
        pol.req_bu_id as req_bu_id,
        pol.item_id AS item_id,
        pol.item_description AS item_description,
        pol.unit_price AS unit_price,
        pol.quantity AS quantity,
        pol.shipping_uom_quantity as shipping_qty,
        pol.uom_code AS uom_code, -- Unit of Measure

        -- Calculated Fields
        pol.quantity * pol.unit_price AS line_total_amount,

        -- Date Fields
        poh.creation_date AS header_creation_date,
        pol.creation_date AS line_creation_date,
        pol.last_update_date AS last_update_date,
        -- pol.cancelled_date AS cancelled_date,
        pol.closed_date as closed_date,

        -- Status Fields
        poh.document_status as header_status,
        pol.funds_status as funds_status,
        pol.line_status as line_status,
        
        NOW() AS _etl_ingestion_time

    FROM poh
    JOIN pol ON poh.po_header_id = pol.po_header_id
)
SELECT * FROM final
{% if is_incremental() %}
WHERE last_update_date > (SELECT COALESCE(MAX(last_update_date), '1970-01-01') from {{ this }})
{% endif %}