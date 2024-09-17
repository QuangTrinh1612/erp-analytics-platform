WITH BSIK AS (
    SELECT * FROM {{ ref('BSIK') }}
),
BSAK AS (
    SELECT * FROM {{ ref('BSAK') }}
),
BKPF AS (
    SELECT * FROM {{ ref('BKPF') }}
),
BSEG AS (
    SELECT * FROM {{ ref('BSEG') }}
),
non_clear_item AS (
    SELECT
        BSIK.GJAHR AS FISCAL_YEAR,
        BSIK.BUKRS AS COMPANY_CODE,
        BSIK.HKONT AS GL_ACCOUNT,
        BSIK.LIFNR AS VENDOR_CODE,
        BSIK.BELNR AS DOC_NO,
        BSIK.BUZEI AS DOC_ITEM,
        BSIK.BUDAT AS POSTING_DATE,
        NULLIF(BSIK.AUGDT,'00000000') AS CLEARING_DATE,
        BSIK.AUGBL AS CLEARING_DOC_NO,
        BSIK.WAERS AS CURRENCY_CODE,
        CASE
            WHEN BSIK.SHKZG = 'S' THEN N'Nợ'
            WHEN BSIK.SHKZG = 'H' THEN N'Có'
        END AS DC_INDICATOR,
        CASE
            WHEN BSIK.SHKZG = 'S' AND BSIK.XNEGP = 'X' THEN BSIK.DMBTR * 100
            WHEN BSIK.SHKZG = 'S' AND BSIK.XNEGP != 'X' THEN BSIK.DMBTR * 100
            WHEN BSIK.SHKZG = 'H' AND BSIK.XNEGP = 'X' THEN BSIK.DMBTR * -100
            WHEN BSIK.SHKZG = 'H' AND BSIK.XNEGP != 'X' THEN BSIK.DMBTR * -100
        END AS LOCAL_AMT,
        CASE
            WHEN BSIK.WAERS != 'VND' AND BSIK.SHKZG = 'S' AND BSIK.XNEGP = 'X' THEN BSIK.WRBTR
            WHEN BSIK.WAERS != 'VND' AND BSIK.SHKZG = 'S' AND BSIK.XNEGP != 'X' THEN BSIK.WRBTR
            WHEN BSIK.WAERS != 'VND' AND BSIK.SHKZG = 'H' AND BSIK.XNEGP = 'X' THEN BSIK.WRBTR * -1
            WHEN BSIK.WAERS != 'VND' AND BSIK.SHKZG = 'H' AND BSIK.XNEGP != 'X' THEN BSIK.WRBTR * -1
        END AS DOC_AMT,
        CASE
            WHEN BSIK.SHKZG = 'S' AND BSIK.XNEGP = 'X' THEN BSIK.MWSTS * 100
            WHEN BSIK.SHKZG = 'S' AND BSIK.XNEGP != 'X' THEN BSIK.MWSTS * 100
            WHEN BSIK.SHKZG = 'H' AND BSIK.XNEGP = 'X' THEN BSIK.MWSTS * -100
            WHEN BSIK.SHKZG = 'H' AND BSIK.XNEGP != 'X' THEN BSIK.MWSTS * -100
        END AS TAX_AMT,
        BSIK.ZFBDT AS DUE_DATE,
        BSIK.ZBD1T AS CASH_DISC_1,
        BSIK.ZBD2T AS CASH_DISC_2,
        BSIK.ZBD3T AS NET_PAYMNT_TERM,
        BSIK.REBZG AS INVOICE_NO,
        BSIK.REBZT AS DOC_TYPE,
        BSIK.BLDAT AS DOC_DATE,
        BSIK.SGTXT AS DOC_TEXT,
        BSIK.XBLNR AS REF_DOC,
        CASE BSIK.BSTAT
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
        BSIK.XNEGP AS IS_NEGATIVE_POSTING,

        BKPF.STBLG AS REVERSE_DOC_NO,
        CASE WHEN BKPF.STBLG <> '' THEN 'X' ELSE '' END AS IS_REVERSE,

        BKPF.BKTXT AS HEADER_TEXT,
        BSIK.SGTXT AS ITEM_TEXT,
        COALESCE(
            NULLIF(BSIK.MWSK1,''),
            NULLIF(BSIK.MWSK2,''),
            NULLIF(BSIK.MWSK3,''),
            BSIK.MWSKZ
        ) AS TAX_CODE,
        BKPF.USNAM AS USER_NAME

    FROM
        sri_sap.BSIK
        JOIN sri_sap.BKPF
            ON BSIK.MANDT = BKPF.MANDT
            AND BSIK.BUKRS = BKPF.BUKRS
            AND BSIK.BELNR = BKPF.BELNR
            AND BSIK.GJAHR = BKPF.GJAHR
    WHERE
        1 = 1
        AND BSIK.BSTAT NOT IN ( 'D' , 'L' , 'M' , 'V' , 'W' , 'Z' , 'S' )
),
clear_item AS (
    SELECT
        BSAK.GJAHR AS FISCAL_YEAR,
        BSAK.BUKRS AS COMPANY_CODE,
        BSAK.HKONT AS GL_ACCOUNT,
        BSAK.LIFNR AS VENDOR_CODE,
        BSAK.BELNR AS DOC_NO,
        BSAK.BUZEI AS DOC_ITEM,
        BSAK.BUDAT AS POSTING_DATE,
        NULLIF(BSAK.AUGDT,'00000000') AS CLEARING_DATE,
        BSAK.AUGBL AS CLEARING_DOC_NO,
        BSAK.WAERS AS CURRENCY_CODE,
        CASE
            WHEN BSAK.SHKZG = 'S' THEN N'Nợ'
            WHEN BSAK.SHKZG = 'H' THEN N'Có'
        END AS DC_INDICATOR,
        CASE
            WHEN BSAK.SHKZG = 'S' AND BSAK.XNEGP = 'X' THEN BSAK.DMBTR * 100
            WHEN BSAK.SHKZG = 'S' AND BSAK.XNEGP != 'X' THEN BSAK.DMBTR * 100
            WHEN BSAK.SHKZG = 'H' AND BSAK.XNEGP = 'X' THEN BSAK.DMBTR * -100
            WHEN BSAK.SHKZG = 'H' AND BSAK.XNEGP != 'X' THEN BSAK.DMBTR * -100
        END AS LOCAL_AMT,
        CASE
            WHEN BSAK.WAERS != 'VND' AND BSAK.SHKZG = 'S' AND BSAK.XNEGP = 'X' THEN BSAK.WRBTR
            WHEN BSAK.WAERS != 'VND' AND BSAK.SHKZG = 'S' AND BSAK.XNEGP != 'X' THEN BSAK.WRBTR
            WHEN BSAK.WAERS != 'VND' AND BSAK.SHKZG = 'H' AND BSAK.XNEGP = 'X' THEN BSAK.WRBTR * -1
            WHEN BSAK.WAERS != 'VND' AND BSAK.SHKZG = 'H' AND BSAK.XNEGP != 'X' THEN BSAK.WRBTR * -1
        END AS DOC_AMT,
        CASE
            WHEN BSAK.SHKZG = 'S' AND BSAK.XNEGP = 'X' THEN BSAK.MWSTS * 100
            WHEN BSAK.SHKZG = 'S' AND BSAK.XNEGP != 'X' THEN BSAK.MWSTS * 100
            WHEN BSAK.SHKZG = 'H' AND BSAK.XNEGP = 'X' THEN BSAK.MWSTS * -100
            WHEN BSAK.SHKZG = 'H' AND BSAK.XNEGP != 'X' THEN BSAK.MWSTS * -100
        END AS TAX_AMT,
        BSAK.ZFBDT AS DUE_DATE,
        BSAK.ZBD1T AS CASH_DISC_1,
        BSAK.ZBD2T AS CASH_DISC_2,
        BSAK.ZBD3T AS NET_PAYMNT_TERM,
        BSAK.REBZG AS INVOICE_NO,
        BSAK.REBZT AS DOC_TYPE,
        BSAK.BLDAT AS DOC_DATE,
        BSAK.SGTXT AS DOC_TEXT,
        BSAK.XBLNR AS REF_DOC,
        CASE BSAK.BSTAT
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
        BSAK.XNEGP AS IS_NEGATIVE_POSTING,

        BKPF.STBLG AS REVERSE_DOC_NO,
        CASE WHEN BKPF.STBLG <> '' THEN 'X' ELSE '' END AS IS_REVERSE,

        BKPF.BKTXT AS HEADER_TEXT,
        BSAK.SGTXT AS ITEM_TEXT,
        COALESCE(
            NULLIF(BSAK.MWSK1,''),
            NULLIF(BSAK.MWSK2,''),
            NULLIF(BSAK.MWSK3,''),
            BSAK.MWSKZ
        ) AS TAX_CODE,
        BKPF.USNAM AS USER_NAME
    FROM
        sri_sap.BSAK
        JOIN sri_sap.BKPF
            ON BSAK.MANDT = BKPF.MANDT
            AND BSAK.BUKRS = BKPF.BUKRS
            AND BSAK.BELNR = BKPF.BELNR
            AND BSAK.GJAHR = BKPF.GJAHR
    WHERE
        1 = 1
        AND BSAK.BSTAT NOT IN ( 'D' , 'L' , 'M' , 'V' , 'W' , 'Z' , 'S' )
),
ap_item AS (
    SELECT * FROM non_clear_item
    UNION ALL SELECT * FROM clear_item
)
SELECT
    ap_item.*,
    COALESCE(LOCAL_AMT,0) - COALESCE(TAX_AMT,0) AS BASE_AMT,
    ROUND(TAX_AMT / NULLIF(COALESCE(LOCAL_AMT,0) - COALESCE(TAX_AMT,0), 0),2) AS TAX_RATE,
    LEFT(REF_DOC,CHARINDEX('.', REF_DOC)) AS KI_HIEU_SO,
    RIGHT(REF_DOC,LEN(REF_DOC) - CHARINDEX('.', REF_DOC)) AS SO_HDGT
FROM
    ap_item