SELECT
    [VONKT]
    ,[BISKT]
    ,[VERSN]
    ,[ERGSL]
    ,[XHABN]
    ,[XSOLL]
    ,[XVERD]
    ,[KTOPL]
    ,[MANDT]
FROM
    {{ source('SAP ECC', 'FAGL_011ZC') }}