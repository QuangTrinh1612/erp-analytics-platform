{{
    config(
        materialized='incremental',
        unique_key='Subledger_Entry_Id',
        incremental_strategy='merge'
    )
}}
WITH ae_header AS (
    SELECT * FROM {{ ref('xla_ae_header') }}
),
ae_line AS (
    SELECT 
        *
    FROM 
        {{ ref('xla_ae_line') }}
),
transaction_entity AS (
    SELECT * FROM {{ ref('xla_transaction_entity') }}
),
gl_import_reference AS (
    SELECT * FROM {{ ref('gl_import_reference') }}
),
xla_event AS (
    SELECT * FROM {{ ref('xla_event') }}
)
SELECT 
    -- Surrogate Key
    {{ dbt_utils.generate_surrogate_key(['aeh.application_id', 'aeh.ae_header_id', 'ael.ae_line_num', 'xte.entity_id']) }} AS Subledger_Entry_Id,

    aeh.ae_header_id,
    aeh.application_id,
    aeh.gl_transfer_status_code,
    aeh.ledger_id,
    aeh.accounting_date,
    aeh.creation_date AS header_creation_date,
    aeh.last_update_date AS header_last_update_date,
    ael.ae_line_num,
    ael.code_combination_id,
    ael.accounting_class_code,
    ael.accounted_dr AS line_accounted_debit,
    ael.accounted_cr AS line_accounted_credit,
    ael.creation_date AS line_creation_date,
    ael.last_update_date AS line_last_update_date,
    xte.entity_id,
    xte.entity_code,
    xte.creation_date AS entity_creation_date,
    xte.last_update_date AS entity_last_update_date,
    gir.je_header_id,
    gir.je_line_num,
    xev.event_id,
    xev.event_date,
    xev.event_status_code,
    xev.process_status_code,
    xev.creation_date AS event_creation_date,
    xev.last_update_date AS event_last_update_date,

    NOW() AS _etl_ingestion_time
FROM 
    ae_header aeh
    LEFT JOIN ae_line ael 
        ON aeh.ae_header_id = ael.ae_header_id
    LEFT JOIN transaction_entity xte 
        ON aeh.application_id = xte.application_id
        AND ael.ae_header_id = xte.entity_id
    LEFT JOIN gl_import_reference gir 
        ON ael.gl_sl_link_table = gir.gl_sl_link_table
        AND ael.gl_sl_link_id = gir.gl_sl_link_id
    LEFT JOIN xla_event xev 
        ON aeh.event_id = xev.event_id
        AND aeh.application_id = xev.application_id
        
{% if is_incremental() %}
WHERE ael.last_update_date > (SELECT COALESCE(MAX(line_last_update_date), '1970-01-01') FROM {{ this }})
{% endif %}