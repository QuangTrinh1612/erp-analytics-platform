{{
    config(
        materialized='incremental',
        unique_key='Journal_Entry_Id',
        incremental_strategy='merge'
    )
}}
WITH ae_header AS (
    SELECT 
        ae_header_id,
        application_id,
        application_name,
        gl_transfer_status_code,
        transfer_date,
        ledger_id,
        accounting_date,
        accounted_cr AS total_accounted_credit,
        accounted_dr AS total_accounted_debit,
        created_by,
        creation_date,
        last_updated_by,
        last_update_date
    FROM 
        {{ ref('xla_ae_header') }}
),
ae_line AS (
    SELECT 
        ae_line_id,
        ae_header_id,
        code_combination_id,
        segment1 || '-' || segment2 || '-' || segment3 || '-' || segment4 || '-' || segment5 AS account_code,
        segment1 AS company,
        segment2 AS cost_center,
        segment3 AS natural_account,
        segment4 AS intercompany,
        segment5 AS future_segment,
        accounting_class_code,
        accounted_dr AS line_accounted_debit,
        accounted_cr AS line_accounted_credit,
        created_by,
        creation_date,
        last_updated_by,
        last_update_date
    FROM 
        {{ ref('xla_ae_line') }}
),
transaction_entity AS (
    SELECT 
        application_id,
        entity_id,
        entity_code,
        event_type_code,
        created_by,
        creation_date,
        last_updated_by,
        last_update_date
    FROM 
        {{ ref('xla_transaction_entity') }}
),
gl_import_reference AS (
    SELECT 
        gl_sl_link_id,
        gl_sl_link_table,
        je_header_id,
        je_line_num,
        entity_id,
        created_by,
        creation_date,
        last_updated_by,
        last_update_date
    FROM 
        {{ ref('gl_import_reference') }}
),
xla_event AS (
    SELECT 
        event_id,
        application_id,
        entity_id,
        event_type_code,
        event_date,
        event_status_code,
        process_status_code,
        created_by,
        creation_date,
        last_updated_by,
        last_update_date
    FROM 
        {{ ref('xla_event') }}
)
SELECT 
    aeh.ae_header_id,
    aeh.application_id,
    aeh.application_name,
    aeh.gl_transfer_status_code,
    aeh.transfer_date,
    aeh.ledger_id,
    aeh.accounting_date,
    aeh.total_accounted_credit,
    aeh.total_accounted_debit,
    aeh.creation_date AS header_creation_date,
    aeh.last_update_date AS header_last_update_date,
    ael.ae_line_id,
    ael.account_code,
    ael.company,
    ael.cost_center,
    ael.natural_account,
    ael.intercompany,
    ael.future_segment,
    ael.accounting_class_code,
    ael.line_accounted_debit,
    ael.line_accounted_credit,
    ael.creation_date AS line_creation_date,
    ael.last_update_date AS line_last_update_date,
    xte.entity_id,
    xte.entity_code,
    xte.event_type_code,
    xte.creation_date AS entity_creation_date,
    xte.last_update_date AS entity_last_update_date,
    gir.je_header_id,
    gir.je_line_num,
    xev.event_id,
    xev.event_date,
    xev.event_status_code,
    xev.process_status_code,
    xev.creation_date AS event_creation_date,
    xev.last_update_date AS event_last_update_date

FROM 
    ae_header aeh
    LEFT JOIN ae_line ael 
        ON aeh.ae_header_id = ael.ae_header_id
    LEFT JOIN transaction_entity xte 
        ON aeh.application_id = xte.application_id
        AND ael.ae_header_id = xte.entity_id
    LEFT JOIN gl_import_reference gir 
        ON ael.ae_line_id = gir.gl_sl_link_id
    LEFT JOIN xla_event xev 
        ON xte.event_id = xev.event_id
        
{% if is_incremental() %}
WHERE aeh.last_update_date > (SELECT COALESCE(MAX(header_last_update_date), '1970-01-01') FROM {{ this }})
{% endif %}