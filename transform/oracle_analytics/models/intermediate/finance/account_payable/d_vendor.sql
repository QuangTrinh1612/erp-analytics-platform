WITH supplier AS (
    SELECT * FROM {{ ref('supplier') }}
),
supplier_site AS (
    SELECT * FROM {{ ref('supplier_site') }}
)
SELECT
    -- Surrogate Key
    {{ dbt_utils.generate_surrogate_key(['s.vendor_id', 'ss.vendor_site_id']) }} AS vendor_surrg_key

    ,s.vendor_id
    ,s.business_relationship
    ,s.organization_type_lookup_code
    ,s.vendor_type_lookup_code
    ,ss.vendor_site_id
    ,ss.vendor_site_code
FROM supplier s
LEFT JOIN supplier_site ss
    ON s.vendor_id = ss.vendor_id