{{
    config(
        materialized='incremental',
        unique_key='Journal_Entry_Id',
        incremental_strategy='merge'
    )
}}
WITH je_batch AS (
    SELECT * FROM {{ ref('je_batch') }}
),
je_header AS (
    SELECT * FROM {{ ref('je_header') }}
),
je_line AS (
    SELECT * FROM {{ ref('je_line') }}
),
ledger AS (
    SELECT * FROM {{ ref('gl_ledger') }}
)
SELECT 
    -- Surrogate Key
    {{ dbt_utils.generate_surrogate_key(['jb.je_batch_id', 'jh.je_header_id', 'jl.je_line_num']) }} AS Journal_Entry_Id,

    jh.je_header_id,
    jb.je_batch_id,
    jl.je_line_num,
    jb.name AS batch_name,
    jh.name AS journal_name,
    jh.status AS je_status,
    jh.actual_flag,
    jh.je_category,
    jh.je_source,
    jh.period_name,
    jl.code_combination_id,
    jh.description AS journal_description,
    jl.description AS line_description,
    jl.entered_dr AS entered_debit,
    jl.entered_cr AS entered_credit,
    jl.accounted_dr AS accounted_debit,
    jl.accounted_cr AS accounted_credit,
    jh.currency_code AS journal_currency,
    jl.currency_code AS line_currency,
    l.name AS ledger_name,
    l.short_name AS edger_short_name,
    l.currency_code AS ledger_currency,
    jb.status AS batch_status,
    jb.description AS batch_description,
    jh.creation_date AS journal_creation_date,
    jl.creation_date AS line_creation_date,
    jl.last_update_date AS last_update_date,

    NOW() AS _etl_ingestion_time
FROM 
    je_line jl
    LEFT JOIN je_header jh ON jl.je_header_id = jh.je_header_id
    LEFT JOIN je_batch jb ON jh.je_batch_id = jb.je_batch_id
    LEFT JOIN ledger l ON jh.ledger_id = l.ledger_id

{% if is_incremental() %}
WHERE jl.last_update_date > (SELECT COALESCE(MAX(last_update_date), '1970-01-01') FROM {{ this }})
{% endif %}