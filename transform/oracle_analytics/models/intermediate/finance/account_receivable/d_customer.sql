{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}

WITH customer_parties AS (
    SELECT 
        party.party_id,
        party.party_number,
        party.party_name,
        party.party_type,
        party.taxpayer_identification_number,
        party.creation_date AS party_creation_date,
        party.last_update_date AS party_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'HZ_PARTIES') }} party
    WHERE party.party_type = 'ORGANIZATION'
),

customer_accounts AS (
    SELECT 
        cust_acct.cust_account_id AS customer_id,
        cust_acct.party_id,
        cust_acct.account_number AS customer_account_number,
        cust_acct.account_description AS customer_description,
        cust_acct.status AS customer_status,
        cust_acct.account_type AS customer_account_type,
        cust_acct.creation_date AS account_creation_date,
        cust_acct.last_update_date AS account_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'HZ_CUST_ACCOUNTS') }} cust_acct
),

customer_sites AS (
    SELECT 
        sites.cust_acct_site_id AS customer_site_id,
        sites.cust_account_id AS customer_id,
        sites.site_use_code,
        sites.status AS site_status,
        sites.location_id,
        sites.creation_date AS site_creation_date,
        sites.last_update_date AS site_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'HZ_CUST_ACCOUNT_SITES_ALL') }} sites
),

customer_locations AS (
    SELECT 
        loc.location_id,
        loc.address1,
        loc.address2,
        loc.address3,
        loc.address4,
        loc.city,
        loc.postal_code,
        loc.state,
        loc.province,
        loc.country,
        loc.creation_date AS location_creation_date,
        loc.last_update_date AS location_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'HZ_LOCATIONS') }} loc
),

customer_contacts AS (
    SELECT 
        contact.party_id,
        contact.contact_point_id,
        contact.contact_point_type,
        contact.contact_point_purpose,
        contact.email_address,
        contact.phone_number,
        contact.creation_date AS contact_creation_date,
        contact.last_update_date AS contact_last_update_date
    FROM 
        {{ source('oracle_fusion_finance', 'HZ_CONTACT_POINTS') }} contact
    WHERE contact.contact_point_type IN ('EMAIL', 'PHONE')
)

SELECT 
    cust_acct.customer_id,
    cust_acct.customer_account_number,
    party.party_number,
    party.party_name AS customer_name,
    cust_acct.customer_description,
    cust_acct.customer_status,
    cust_acct.customer_account_type,
    party.taxpayer_identification_number,
    cust_acct.account_creation_date,
    cust_acct.account_last_update_date,
    COALESCE(
        MAX(CASE WHEN site.site_use_code = 'BILL_TO' THEN loc.address1 END),
        MAX(CASE WHEN site.site_use_code = 'SHIP_TO' THEN loc.address1 END)
    ) AS primary_address,
    COALESCE(
        MAX(CASE WHEN site.site_use_code = 'BILL_TO' THEN loc.city END),
        MAX(CASE WHEN site.site_use_code = 'SHIP_TO' THEN loc.city END)
    ) AS primary_city,
    COALESCE(
        MAX(CASE WHEN site.site_use_code = 'BILL_TO' THEN loc.state END),
        MAX(CASE WHEN site.site_use_code = 'SHIP_TO' THEN loc.state END)
    ) AS primary_state,
    COALESCE(
        MAX(CASE WHEN site.site_use_code = 'BILL_TO' THEN loc.country END),
        MAX(CASE WHEN site.site_use_code = 'SHIP_TO' THEN loc.country END)
    ) AS primary_country,
    MAX(CASE WHEN contact.contact_point_type = 'EMAIL' THEN contact.email_address END) AS primary_email,
    MAX(CASE WHEN contact.contact_point_type = 'PHONE' THEN contact.phone_number END) AS primary_phone,
    party.party_creation_date,
    party.party_last_update_date
FROM 
    customer_accounts cust_acct
LEFT JOIN 
    customer_parties party ON cust_acct.party_id = party.party_id
LEFT JOIN 
    customer_sites site ON cust_acct.customer_id = site.customer_id
LEFT JOIN 
    customer_locations loc ON site.location_id = loc.location_id
LEFT JOIN 
    customer_contacts contact ON party.party_id = contact.party_id
GROUP BY 
    cust_acct.customer_id,
    cust_acct.customer_account_number,
    party.party_number,
    party.party_name,
    cust_acct.customer_description,
    cust_acct.customer_status,
    cust_acct.customer_account_type,
    party.taxpayer_identification_number,
    cust_acct.account_creation_date,
    cust_acct.account_last_update_date,
    party.party_creation_date,
    party.party_last_update_date

{% if is_incremental() %}
WHERE party.party_last_update_date > (SELECT MAX(party_last_update_date) FROM {{ this }})
{% endif %}
