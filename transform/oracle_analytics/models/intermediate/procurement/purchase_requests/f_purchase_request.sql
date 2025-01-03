{{
    config(
        materialized='incremental',
        unique_key='Purchase_Request_Id',
        incremental_strategy='merge'
    )
}}
WITH prh AS (
    SELECT * FROM {{ ref('purchase_request_header') }}
),
prl AS (
    SELECT * FROM {{ ref('purchase_request_line') }}
),
prd AS (
    SELECT * FROM {{ ref('purchase_request_distribution') }}
),
final AS (
    SELECT
        -- Surrogate Key
        {{ dbt_utils.generate_surrogate_key(['prh.requisition_header_id', 'prl.requisition_line_id']) }} AS Purchase_Request_Id,
        
        -- Requisition Header Information
        prh.requisition_header_id AS requisition_header_id,
        prh.requisition_number AS requisition_number,  -- Requisition Number
        prh.preparer_id AS preparer_id,
        prh.document_status AS pr_status,
        prh.lifecycle_status AS lifecycle_status,
        prh.process_status AS process_status,
        prh.funds_status AS funds_status,
        prh.document_sub_type AS requisition_type,
        prh.creation_date AS creation_date,
        prh.last_update_date AS last_update_date,
        prh.approved_date as approved_date,
        prh.prc_bu_id AS prc_bu_id,
        prh.req_bu_id AS req_bu_id,

        -- Requisition Line Information
        prl.requisition_line_id AS requisition_line_id,
        prl.line_number AS line_number,
        prl.item_id AS item_id,
        prl.item_description AS item_description,
        prl.unit_price AS unit_price,
        prl.quantity AS quantity,
        prl.uom_code AS uom_code,  -- Unit of Measure
        prl.need_by_date AS need_by_date,
        prl.deliver_to_location_id AS deliver_to_location_id,

        -- JSON String for Distribution Data
        CAST(
            COLLECT_LIST(
                TO_JSON(NAMED_STRUCT(
                    'req_distribution_id', prd.distribution_id,
                    'distribution_num', prd.distribution_number,
                    'distribution_amount', prd.distribution_amount,
                    'creation_date', prd.creation_date,
                    'last_update_date', prd.last_update_date
                ))
            ) AS STRING
        ) AS distribution_detail,

        NOW() AS _etl_ingestion_time

    FROM prh
    JOIN prl ON prh.requisition_header_id = prl.requisition_header_id
    LEFT JOIN prd ON prl.requisition_line_id = prd.requisition_line_id
    GROUP BY ALL
)
SELECT * FROM final
{% if is_incremental() %}
WHERE last_update_date > (SELECT COALESCE(MAX(last_update_date), '1970-01-01') from {{ this }})
{% endif %}