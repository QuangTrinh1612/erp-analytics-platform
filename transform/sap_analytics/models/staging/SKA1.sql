SELECT
    [FUNC_AREA]
    ,[XBILK]
    ,[KTOKS]
    ,[KTOPL]
    ,[XLOEV]
    ,[XSPEP]
    ,[XSPEB]
    ,[XSPEA]
    ,[MANDT]
    ,[MUSTR]
    ,[SAKNR]
    ,[BILKT]
    ,[ERDAT]
    ,[ERNAM]
    ,[VBUND]
    ,[SAKAN]
    ,[GVTYP]
    ,[MCOD1]
FROM {{ source('SAP ECC', 'SKA1') }}