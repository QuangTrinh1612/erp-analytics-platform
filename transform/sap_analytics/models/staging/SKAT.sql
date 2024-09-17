SELECT
    [KTOPL]
    ,[MANDT]
    ,[SPRAS]
    ,[SAKNR]
    ,[TXT20]
    ,[TXT50]
    ,[MCOD1]
FROM {{ source('SAP ECC', 'SKAT') }}