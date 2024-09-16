{{
    config(
        index='HEAP',
        dist='REPLICATE'
    )
}}
WITH SKA1 AS (
    SELECT * FROM {{ ref('SKA1') }}
),
SKAT AS (
    SELECT * FROM {{ ref('SKAT') }}
),
SKB1 AS (
    SELECT * FROM {{ ref('SKB1') }}
)
SELECT
    CONCAT_WS('-', SKA1.KTOPL, SKA1.SAKNR, SKB1.BUKRS) AS GL_ACCOUNT_KEY, -- CHART_OF_ACCOUNT + GL_ACCOUNT_CODE + COMPANY_CODE
    SKA1.KTOPL AS CHART_OF_ACCOUNT,
	SKA1.SAKNR AS GL_ACCOUNT_CODE,
    SKB1.BUKRS AS COMPANY_CODE,
	SKA1.KTOKS AS GROUP_ACC_NO,
	SKA1.XBILK AS IS_BS_ACC,
	SKA1.GVTYP AS IS_PL_ACC,
	SKAT.TXT20 AS SHORT_DESC,
	SKAT.TXT50 AS LONG_DESC,
	SKB1.FDGRV AS PLANNING_GRP,
	SKB1.FDLEV AS PLANNING_LEVEL,
	SKB1.WAERS AS ACCOUNT_CURRENCY,
	SKB1.HBKID AS HOUSE_BANK_KEY,
	SKB1.HKTID AS ACCOUNT_ID
FROM SKA1
JOIN SKAT
    ON SKA1.MANDT = SKAT.MANDT
    AND SKA1.SAKNR = SKAT.SAKNR
    AND SKA1.KTOPL = SKAT.KTOPL
    AND SKAT.SPRAS = '{{ var("language") }}'
LEFT JOIN SKB1
    ON SKA1.MANDT = SKB1.MANDT
    AND SKA1.SAKNR = SKB1.SAKNR