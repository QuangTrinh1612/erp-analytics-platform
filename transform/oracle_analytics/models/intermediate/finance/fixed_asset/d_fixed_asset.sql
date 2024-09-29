{{ config(
    materialized='incremental',
    unique_key='asset_id'
) }}

WITH asset_details AS (
    SELECT 
        asset_det.asset_id,
        asset_det.asset_number,
        asset_det.description AS asset_description,
        asset_det.asset_type,
        asset_det.asset_category_id,
        asset_det.date_placed_in_service,
        asset_det.asset_cost,
        asset_det.original_cost,
        asset_det.retirement_date,
        asset_det.unit_of_measure,
        asset_det.units,
        asset_det.parent_asset_id,
        asset_det.asset_group_id,
        asset_det.deprn_expense_account_id,
        asset_det.reserve_account_id,
        asset_det.book_type_code,
        asset_det.book_id,
        asset_det.creation_date AS asset_creation_date,
        asset_det.last_update_date AS asset_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'FA_ASSET_DETAILS') }} asset_det
),

asset_locations AS (
    SELECT 
        loc.asset_id,
        loc.location_code,
        loc.location_name,
        loc.location_description,
        loc.location_type,
        loc.creation_date AS location_creation_date,
        loc.last_update_date AS location_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'FA_LOCATIONS') }} loc
),

asset_categories AS (
    SELECT 
        cat.asset_category_id,
        cat.category_name,
        cat.asset_class,
        cat.asset_subclass,
        cat.creation_date AS category_creation_date,
        cat.last_update_date AS category_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'FA_CATEGORIES') }} cat
),

gl_codes AS (
    SELECT 
        gl_code_combination_id,
        segment1 || '.' || segment2 || '.' || segment3 || '.' || segment4 || '.' || segment5 AS gl_account
    FROM 
        {{ source('oracle_fusion_finance', 'GL_CODE_COMBINATIONS') }}
)

SELECT 
    asset_det.asset_id,
    asset_det.asset_number,
    asset_det.asset_description,
    asset_det.asset_type,
    asset_det.date_placed_in_service,
    asset_det.asset_cost,
    asset_det.original_cost,
    asset_det.retirement_date,
    asset_det.unit_of_measure,
    asset_det.units,
    asset_det.parent_asset_id,
    asset_det.asset_group_id,
    asset_det.book_type_code,
    asset_det.book_id,
    asset_categories.category_name AS asset_category,
    asset_categories.asset_class AS asset_classification,
    asset_categories.asset_subclass AS asset_subclassification,
    asset_det.deprn_expense_account_id,
    gl_codes.gl_account AS deprn_expense_gl_account,
    asset_det.reserve_account_id,
    asset_locations.location_code,
    asset_locations.location_name,
    asset_locations.location_description,
    asset_locations.location_type,
    asset_det.asset_creation_date,
    asset_det.asset_last_update_date
FROM 
    asset_details asset_det
LEFT JOIN 
    asset_locations ON asset_det.asset_id = asset_locations.asset_id
LEFT JOIN 
    asset_categories ON asset_det.asset_category_id = asset_categories.asset_category_id
LEFT JOIN 
    gl_codes ON asset_det.deprn_expense_account_id = gl_codes.gl_code_combination_id

{% if is_incremental() %}
WHERE asset_det.asset_last_update_date > (SELECT MAX(asset_last_update_date) FROM {{ this }})
{% endif %}
