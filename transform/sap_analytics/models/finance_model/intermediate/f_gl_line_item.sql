WITH BKPF AS (
    SELECT * FROM {{ ref('BKPF') }}
),
BSEG AS (
    SELECT * FROM {{ ref('BSEG') }}
),
BSEC AS (
    SELECT * FROM {{ ref('BSEC') }}
),
FAGL_011ZC AS (
    SELECT * FROM {{ ref('FAGL_011ZC') }}
)
SELECT
    BKPF.GJAHR AS FISCAL_YEAR,
	MONTH(BKPF.BUDAT) AS FISCAL_PERIOD,
    BKPF.BUDAT AS POSTING_DATE,
    BKPF.BUKRS AS COMPANY_CODE,
    BKPF.CPUDT AS ENTRY_DATE,
    BKPF.BLDAT AS DOC_DATE,
    BKPF.BELNR AS DOC_NO,
    BSEG.BUZEI AS DOC_ITEM,
    BKPF.XBLNR AS REF_DOC,
    BKPF.BLART AS DOC_TYPE,
    BSEG.KOART AS ACCOUNT_TYPE,
    COALESCE(NULLIF(BSEG.SGTXT,''), BKPF.BKTXT) AS DESCRIPTION,
    BSEG.HKONT AS GL_ACCOUNT_NO,
    BSEG.PRCTR AS PROFIT_CENTRE,
    BSEG.KOSTL AS COST_CENTRE,
    BSEG.LIFNR AS VENDOR_CODE,
    BSEG.KUNNR AS CUSTOMER_CODE,
    BSEG.AUFNR AS ORDER_NO,
    BSEG.VBELN AS BILLING_DOC,
    BSEG.VBEL2 AS SALE_DOC,
    BKPF.USNAM AS USER_NAME,
    BKPF.WAERS AS CURRENCY_CODE,
    CASE
        WHEN BSEG.SHKZG = 'S' AND BSEG.XNEGP = '' THEN N'Nợ'
        WHEN BSEG.SHKZG = 'S' AND BSEG.XNEGP = 'X' THEN N'Có'
        WHEN BSEG.SHKZG = 'H' AND BSEG.XNEGP = '' THEN N'Có'
        WHEN BSEG.SHKZG = 'H' AND BSEG.XNEGP = 'X' THEN N'Nợ'
    END AS DC_INDICATOR,
    BSEG.XNEGP AS IS_NEGATIVE_POSTING,
    CASE
        WHEN BSEG.SHKZG = 'S' AND BSEG.XNEGP = '' THEN BSEG.DMBTR * 100
        WHEN BSEG.SHKZG = 'S' AND BSEG.XNEGP = 'X' THEN BSEG.DMBTR * 100
        WHEN BSEG.SHKZG = 'H' AND BSEG.XNEGP = '' THEN BSEG.DMBTR * -100
        WHEN BSEG.SHKZG = 'H' AND BSEG.XNEGP = 'X' THEN BSEG.DMBTR * -100
    END AS AMOUNT_VND,
    CASE WHEN BKPF.WAERS != 'VND' THEN BSEG.WRBTR END AS AMOUNT_FX,
    CASE WHEN BKPF.WAERS != 'VND' THEN BKPF.KURSF * 1000 END AS FX_RATE,
    BKPF.STBLG AS REVERSE_DOC_NO,
    CASE WHEN BKPF.STBLG <> '' THEN 'X' ELSE '' END AS IS_REVERSE,
    CASE WHEN DATEADD(day,1,EOMONTH(BKPF.BUDAT, -1)) = DATEADD(day,1,EOMONTH(REVERSE.BUDAT, -1)) THEN 1 ELSE 0 END AS IS_REVERSE_SP, -- Same period
    BSEG.EBELN AS PO_NUMBER,
    BSEG.MATNR AS MATERIAL_CODE,
    CONCAT_WS(' ', BSEC.NAME1, BSEC.NAME2, BSEC.NAME3, BSEC.NAME4) AS OBJECT_NAME,
	BSEG.MENGE AS QUANTITY,
    BKPF.BSTAT AS DOC_STATUS,

    FI_ACC.ERGSL AS IS_ITEM,
    BSEG.MEINS AS BUOM,
    BSEG.ZUONR AS ASSIGN_NO,
    BSEG.BSCHL AS POSTING_KEY,
    BSEG.AUGBL AS CLEARING_DOC
FROM
    BKPF
    JOIN BSEG
        ON BKPF.MANDT = BSEG.MANDT
        AND BKPF.BUKRS = BSEG.BUKRS
        AND BKPF.BELNR = BSEG.BELNR
        AND BKPF.GJAHR = BSEG.GJAHR

    -- GET ONE-TIME VENDOR OR CUSTOMER INFO
    LEFT JOIN BSEC
        ON BKPF.MANDT = BSEC.MANDT
        AND BKPF.BUKRS = BSEC.BUKRS
        AND BKPF.BELNR = BSEC.BELNR
        AND BKPF.GJAHR = BSEC.GJAHR
        AND BSEG.BUZEI = BSEC.BUZEI
    
    LEFT JOIN FAGL_011ZC FI_ACC
        ON FI_ACC.VERSN = '{{ var("version_income_statement") }}' -- Income Statement
        AND BSEG.HKONT BETWEEN FI_ACC.VONKT AND FI_ACC.BISKT
    
    LEFT JOIN BKPF REVERSE
        ON BKPF.MANDT = REVERSE.MANDT
        AND BKPF.STBLG = REVERSE.BELNR
        AND BKPF.BUKRS = REVERSE.BUKRS
        AND BKPF.GJAHR = REVERSE.STJAH