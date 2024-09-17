WITH BSID AS (
    SELECT * FROM {{ ref('BSID') }}
),
BSAD AS (
    SELECT * FROM {{ ref('BSAD') }}
),
BKPF AS (
    SELECT * FROM {{ ref('BKPF') }}
),
BSEG AS (
    SELECT * FROM {{ ref('BSEG') }}
),
non_clear_item AS (
    SELECT
        BSID.GJAHR AS FISCAL_YEAR,
        BSID.BUKRS AS COMPANY_CODE,
        BSID.HKONT AS GL_ACCOUNT,
        BSID.KUNNR AS CUSTOMER_CODE,
        BSID.BELNR AS DOC_NO,
        BSID.BUZEI AS DOC_ITEM,
        BSID.BUDAT AS POSTING_DATE,
        NULLIF(BSID.AUGDT,'00000000') AS CLEARING_DATE,
        BSID.AUGBL AS CLEARING_DOC_NO,
        BSID.WAERS AS CURRENCY_CODE,
        CASE
            WHEN BSID.SHKZG = 'S' THEN 'Debit'
            WHEN BSID.SHKZG = 'H' THEN 'Credit'
        END AS DC_INDICATOR,
        CASE
            WHEN BSID.SHKZG = 'S' AND BSID.XNEGP = 'X' THEN BSID.DMBTR * 100
            WHEN BSID.SHKZG = 'S' AND BSID.XNEGP != 'X' THEN BSID.DMBTR * 100
            WHEN BSID.SHKZG = 'H' AND BSID.XNEGP = 'X' THEN BSID.DMBTR * -100
            WHEN BSID.SHKZG = 'H' AND BSID.XNEGP != 'X' THEN BSID.DMBTR * -100
        END AS LOCAL_AMT,
        CASE
            WHEN BSID.WAERS != 'VND' AND BSID.SHKZG = 'S' AND BSID.XNEGP = 'X' THEN BSID.WRBTR
            WHEN BSID.WAERS != 'VND' AND BSID.SHKZG = 'S' AND BSID.XNEGP != 'X' THEN BSID.WRBTR
            WHEN BSID.WAERS != 'VND' AND BSID.SHKZG = 'H' AND BSID.XNEGP = 'X' THEN BSID.WRBTR * -1
            WHEN BSID.WAERS != 'VND' AND BSID.SHKZG = 'H' AND BSID.XNEGP != 'X' THEN BSID.WRBTR * -1
        END AS DOC_AMT,
        NULLIF(BSID.ZFBDT, '00000000') AS DUE_DATE,
        BSID.ZBD1T AS CASH_DISC_1,
        BSID.ZBD2T AS CASH_DISC_2,
        BSID.ZBD3T AS NET_PAYMNT_TERM,
        BSID.REBZG AS INVOICE_NO,
        BSID.REBZT AS DOC_TYPE,
        BSID.BLDAT AS DOC_DATE,
        BSID.SGTXT AS DOC_TEXT,
        BSID.XBLNR AS REF_DOC,
        CASE BSID.BSTAT
            WHEN 'A' THEN 'Clearing Document'
            WHEN 'B' THEN 'Reset clearing document'
            WHEN 'D' THEN 'Recurring entry document'
            WHEN 'L' THEN 'Posting Not in Leading Ledger'
            WHEN 'M' THEN 'Sample document'
            WHEN 'S' THEN 'Noted items'
            WHEN 'V' THEN 'Parked document'
            WHEN 'W' THEN 'Parked document with change of document ID'
            WHEN 'Z' THEN 'Parked document which was deleted'
            WHEN 'C' THEN 'Balance Carryforward Line Items'
            ELSE 'Normal document'
        END AS DOC_STATUS,
        BSID.XNEGP AS IS_NEGATIVE_POSTING,

        BKPF.STBLG AS REVERSE_DOC_NO,
        CASE WHEN BKPF.STBLG <> '' THEN 'X' ELSE '' END AS IS_REVERSE,

        BKPF.BKTXT AS HEADER_TEXT,
        BSID.SGTXT AS ITEM_TEXT,
        BSID.MWSKZ AS TAX_CODE,
        BKPF.USNAM AS USER_NAME
    FROM
        BSID
        JOIN BKPF
            ON BSID.MANDT = BKPF.MANDT
            AND BSID.BUKRS = BKPF.BUKRS
            AND BSID.BELNR = BKPF.BELNR
            AND BSID.GJAHR = BKPF.GJAHR
    WHERE
        1 = 1
        AND BSID.BSTAT NOT IN ( 'D' , 'L' , 'M' , 'V' , 'W' , 'Z' , 'S' )
),
clear_item AS (
    SELECT
        BSAD.GJAHR AS FISCAL_YEAR,
        BSAD.BUKRS AS COMPANY_CODE,
        BSAD.HKONT AS GL_ACCOUNT,
        BSAD.KUNNR AS CUSTOMER_CODE,
        BSAD.BELNR AS DOC_NO,
        BSAD.BUZEI AS DOC_ITEM,
        BSAD.BUDAT AS POSTING_DATE,
        NULLIF(BSAD.AUGDT,'00000000') AS CLEARING_DATE,
        BSAD.AUGBL AS CLEARING_DOC_NO,
        BSAD.WAERS AS CURRENCY_CODE,
        CASE
            WHEN BSAD.SHKZG = 'S' THEN 'Debit'
            WHEN BSAD.SHKZG = 'H' THEN 'Credit'
        END AS DC_INDICATOR,
        CASE
            WHEN BSAD.SHKZG = 'S' AND BSAD.XNEGP = 'X' THEN BSAD.DMBTR * 100
            WHEN BSAD.SHKZG = 'S' AND BSAD.XNEGP != 'X' THEN BSAD.DMBTR * 100
            WHEN BSAD.SHKZG = 'H' AND BSAD.XNEGP = 'X' THEN BSAD.DMBTR * -100
            WHEN BSAD.SHKZG = 'H' AND BSAD.XNEGP != 'X' THEN BSAD.DMBTR * -100
        END AS LOCAL_AMT,
        CASE
            WHEN BSAD.WAERS != 'VND' AND BSAD.SHKZG = 'S' AND BSAD.XNEGP = 'X' THEN BSAD.WRBTR
            WHEN BSAD.WAERS != 'VND' AND BSAD.SHKZG = 'S' AND BSAD.XNEGP != 'X' THEN BSAD.WRBTR
            WHEN BSAD.WAERS != 'VND' AND BSAD.SHKZG = 'H' AND BSAD.XNEGP = 'X' THEN BSAD.WRBTR * -1
            WHEN BSAD.WAERS != 'VND' AND BSAD.SHKZG = 'H' AND BSAD.XNEGP != 'X' THEN BSAD.WRBTR * -1
        END AS DOC_AMT,
        NULLIF(BSAD.ZFBDT, '00000000') AS DUE_DATE,
        BSAD.ZBD1T AS CASH_DISC_1,
        BSAD.ZBD2T AS CASH_DISC_2,
        BSAD.ZBD3T AS NET_PAYMNT_TERM,
        BSAD.REBZG AS INVOICE_NO,
        BSAD.REBZT AS DOC_TYPE,
        BSAD.BLDAT AS DOC_DATE,
        BSAD.SGTXT AS DOC_TEXT,
        BSAD.XBLNR AS REF_DOC,
        CASE BSAD.BSTAT
            WHEN 'A' THEN 'Clearing Document'
            WHEN 'B' THEN 'Reset clearing document'
            WHEN 'D' THEN 'Recurring entry document'
            WHEN 'L' THEN 'Posting Not in Leading Ledger'
            WHEN 'M' THEN 'Sample document'
            WHEN 'S' THEN 'Noted items'
            WHEN 'V' THEN 'Parked document'
            WHEN 'W' THEN 'Parked document with change of document ID'
            WHEN 'Z' THEN 'Parked document which was deleted'
            WHEN 'C' THEN 'Balance Carryforward Line Items'
            ELSE 'Normal document'
        END AS DOC_STATUS,
        BSAD.XNEGP AS IS_NEGATIVE_POSTING,

        BKPF.STBLG AS REVERSE_DOC_NO,
        CASE WHEN BKPF.STBLG <> '' THEN 'X' ELSE '' END AS IS_REVERSE,

        BKPF.BKTXT AS HEADER_TEXT,
        BSAD.SGTXT AS ITEM_TEXT,
        BSAD.MWSKZ AS TAX_CODE,
        BKPF.USNAM AS USER_NAME
    FROM
        BSAD
        JOIN BKPF
            ON BSAD.MANDT = BKPF.MANDT
            AND BSAD.BUKRS = BKPF.BUKRS
            AND BSAD.BELNR = BKPF.BELNR
            AND BSAD.GJAHR = BKPF.GJAHR
    WHERE
        1 = 1
        AND BSAD.BSTAT NOT IN ( 'D' , 'L' , 'M' , 'V' , 'W' , 'Z' , 'S' )
),
ar_item AS (
    SELECT * FROM non_clear_item
    UNION ALL SELECT * FROM clear_item
),
final AS (
SELECT
    ar_item.*,
    CASE
        WHEN BSEG.SHKZG = 'S' AND BSEG.XNEGP = 'X' THEN BSEG.DMBTR * -100
        WHEN BSEG.SHKZG = 'S' AND BSEG.XNEGP != 'X' THEN BSEG.DMBTR * -100
        WHEN BSEG.SHKZG = 'H' AND BSEG.XNEGP = 'X' THEN BSEG.DMBTR * 100
        WHEN BSEG.SHKZG = 'H' AND BSEG.XNEGP != 'X' THEN BSEG.DMBTR * 100
    END AS TAX_AMT,
    LEFT(REF_DOC,CHARINDEX('.', REF_DOC)) AS KI_HIEU_SO,
    RIGHT(REF_DOC,LEN(REF_DOC) - CHARINDEX('.', REF_DOC)) AS SO_HDGT
FROM
    ar_item
    LEFT JOIN BSEG
        ON ar_item.COMPANY_CODE = BSEG.BUKRS
        AND ar_item.DOC_NO = BSEG.BELNR
        AND ar_item.FISCAL_YEAR = BSEG.GJAHR
        AND BSEG.MWART = 'A' -- OUTPUT TAX
)
SELECT
    *,
    COALESCE(LOCAL_AMT,0) - COALESCE(TAX_AMT,0) AS BASE_AMT,
    ROUND(TAX_AMT / NULLIF(COALESCE(LOCAL_AMT,0) - COALESCE(TAX_AMT,0), 0),2) AS TAX_RATE
FROM
    final