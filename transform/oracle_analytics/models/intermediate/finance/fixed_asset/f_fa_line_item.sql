{{ config(
    materialized='incremental',
    unique_key='asset_history_id'
) }}

WITH asset_history AS (
    SELECT 
        asset_hist.asset_id,
        asset_hist.asset_number,
        asset_hist.asset_type,
        asset_hist.asset_cost,
        asset_hist.original_cost,
        asset_hist.date_placed_in_service,
        asset_hist.asset_life_years,
        asset_hist.asset_life_months,
        asset_hist.unit_of_measure,
        asset_hist.units,
        asset_hist.revaluation_reserve,
        asset_hist.retirement_cost,
        asset_hist.retirement_date,
        asset_hist.retirement_type_code,
        asset_hist.cost_retired,
        asset_hist.asset_group_id,
        asset_hist.book_type_code,
        asset_hist.book_id,
        asset_hist.period_name,
        asset_hist.accounted_deprn_reserve,
        asset_hist.description,
        asset_hist.creation_date AS asset_creation_date,
        asset_hist.last_update_date AS asset_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'FA_ASSET_HISTORY') }} asset_hist
),

asset_books AS (
    SELECT 
        book.book_id,
        book.asset_id,
        book.deprn_method_code,
        book.deprn_start_date,
        book.deprn_end_date,
        book.deprn_expense_account_id,
        book.reserve_account_id,
        book.deprn_revalue_account_id,
        book.cost,
        book.ytd_deprn AS year_to_date_deprn,
        book.life_in_years,
        book.life_in_months,
        book.net_book_value,
        book.revalue_reserve,
        book.asset_type,
        book.creation_date AS book_creation_date,
        book.last_update_date AS book_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'FA_BOOKS') }} book
),

deprn_summary AS (
    SELECT 
        deprn.asset_id,
        deprn.book_id,
        deprn.period_name,
        deprn.deprn_amount AS period_deprn_amount,
        deprn.ytd_deprn AS year_to_date_deprn,
        deprn.accumulated_deprn,
        deprn.net_book_value,
        deprn.expense_account_id,
        deprn.creation_date AS deprn_creation_date,
        deprn.last_update_date AS deprn_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'FA_DEPRN_SUMMARY') }} deprn
),

gl_codes AS (
    SELECT 
        gl_code_combination_id,
        segment1 || '.' || segment2 || '.' || segment3 || '.' || segment4 || '.' || segment5 AS gl_account
    FROM 
        {{ source('oracle_fusion_finance', 'GL_CODE_COMBINATIONS') }}
)

SELECT 
    asset_hist.asset_id,
    asset_hist.asset_number,
    asset_hist.asset_type,
    asset_hist.asset_cost,
    asset_hist.original_cost,
    asset_hist.date_placed_in_service,
    asset_hist.asset_life_years,
    asset_hist.asset_life_months,
    asset_hist.unit_of_measure,
    asset_hist.units,
    asset_hist.revaluation_reserve,
    asset_hist.retirement_cost,
    asset_hist.retirement_date,
    asset_hist.retirement_type_code,
    asset_hist.cost_retired,
    asset_hist.asset_group_id,
    asset_hist.book_type_code,
    asset_hist.period_name,
    asset_hist.accounted_deprn_reserve,
    asset_hist.description,
    asset_hist.asset_creation_date,
    asset_hist.asset_last_update_date,
    asset_books.deprn_method_code,
    asset_books.deprn_start_date,
    asset_books.deprn_end_date,
    asset_books.cost AS book_cost,
    asset_books.year_to_date_deprn AS book_year_to_date_deprn,
    asset_books.life_in_years AS book_life_years,
    asset_books.life_in_months AS book_life_months,
    asset_books.net_book_value AS book_net_book_value,
    asset_books.revalue_reserve AS book_revalue_reserve,
    asset_books.book_creation_date,
    asset_books.book_last_update_date,
    deprn_summary.period_deprn_amount,
    deprn_summary.year_to_date_deprn AS deprn_summary_ytd_deprn,
    deprn_summary.accumulated_deprn,
    deprn_summary.net_book_value AS deprn_summary_net_book_value,
    deprn_summary.expense_account_id,
    gl.gl_account AS gl_account_code
FROM 
    asset_history asset_hist
LEFT JOIN 
    asset_books ON asset_hist.asset_id = asset_books.asset_id
LEFT JOIN 
    deprn_summary ON asset_hist.asset_id = deprn_summary.asset_id
    AND asset_hist.book_id = deprn_summary.book_id
    AND asset_hist.period_name = deprn_summary.period_name
LEFT JOIN 
    gl_codes gl ON asset_books.deprn_expense_account_id = gl.gl_code_combination_id

{% if is_incremental() %}
WHERE asset_hist.asset_last_update_date > (SELECT MAX(asset_last_update_date) FROM {{ this }})
{% endif %}
