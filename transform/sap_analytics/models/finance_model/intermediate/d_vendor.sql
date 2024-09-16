WITH LFA1 AS (
    SELECT * FROM {{ ref('LFA1') }}
    WHERE SPRAS = '{{ var("language") }}'
),
LFBK AS (
    SELECT * FROM {{ ref('LFBK') }}
)
SELECT
    LFA1.LIFNR AS VENDOR_CODE,
    LFA1.NAME1 AS VENDOR_NAME,
    LFA1.SORTL AS SEARCH_TERM,
    LFA1.ANRED AS TITLE,
    LFA1.KTOKK AS VENDOR_ACC_GRP,
    LFA1.ORT01 AS CITY,
    LFA1.LAND1 AS COUNTRY,
    LFA1.REGIO AS REGION,
    LFA1.BRSCH AS INDUSTRY,
    LFA1.PFACH AS PO_BOX,
    LFA1.PSTLZ AS POSTAL_CODE,
    LFA1.PSTL2 AS COMPANY_POSTAL,
    LFA1.TELF1 AS PHONE,
    LFA1.STRAS AS STREET_ADDR,
    LFA1.STCEG AS VAT_NO,
    LFA1.LOEVM as DELETE_FLG,
    LFBK.BANKL AS BANK_KEY,
    LFBK.BANKN AS BANK_ACCT_NO,
    LFBK.KOINH AS BACK_ACCT_HOLDER
FROM LFA1
LEFT JOIN LFBK
    ON LFA1.MANDT = LFBK.MANDT
    AND LFA1.LIFNR = LFBK.LIFNR