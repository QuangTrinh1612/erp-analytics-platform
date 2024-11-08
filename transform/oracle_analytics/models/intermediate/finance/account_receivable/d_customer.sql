{{  
    config(
        materialized='incremental',
        unique_key='customer_id',
        incremental_strategy='merge'
    )
}}
WITH customer_party AS (
    SELECT * FROM {{ ref('customer_party') }}
),

customer_accounts AS (
    SELECT * FROM {{ ref('customer_account') }}
)
SELECT 
    -- Surrogate Key
    {{ dbt_utils.generate_surrogate_key(['party.party_id', 'cust_acct.cust_account_id']) }} AS customer_id,

    cust_acct.cust_account_id AS cust_account_id,
    cust_acct.account_number,
    cust_acct.customer_type,
    party.party_id,
    party.party_number,
    party.party_name AS customer_name,
    cust_acct.status AS customer_status,
    cust_acct.account_name,
    cust_acct.tax_code,
    party.address1,
    party.address2,
    party.address3,
    party.address4,
    party.city,
    party.state,
    party.country,
    party.email_address,
    party.primary_phone_number,
    cust_acct.creation_date AS account_creation_date,
    cust_acct.last_update_date AS account_last_update_date,
    party.creation_date AS party_creation_date,
    party.last_update_date AS party_last_update_date
FROM 
    customer_accounts cust_acct
    LEFT JOIN customer_party party ON cust_acct.party_id = party.party_id
{% if is_incremental() %}
WHERE party.last_update_date > (SELECT COALESCE(MAX(party_last_update_date), '1970-01-01') FROM {{ this }})
{% endif %}
