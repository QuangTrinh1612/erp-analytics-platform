SELECT
    [ZINRT]
    ,[ZUAWA]
    ,[MITKZ]
    ,[ZINDT]
    ,[ERDAT]
    ,[DATLZ]
    ,[BUSAB]
    ,[BUKRS]
    ,[SAKNR]
    ,[ALTKT]
    ,[ERNAM]
    ,[BEWGP]
    ,[FDGRV]
    ,[FDLEV]
    ,[FIPLS]
    ,[FIPOS]
    ,[FSTAG]
    ,[STEXT]
    ,[MCAKEY]
    ,[TOGRU]
    ,[HBKID]
    ,[HKTID]
    ,[MWSKZ]
    ,[RECID]
    ,[INFKY]
    ,[WMETH]
    ,[KDFSL]
    ,[VZSKZ]
    ,[WAERS]
    ,[XGKON]
    ,[XMWNO]
    ,[XLGCLR]
    ,[MANDT]
    ,[BEGRU]
    ,[XSALH]
    ,[XOPVW]
    ,[XNKON]
    ,[XMITK]
    ,[XLOEB]
    ,[XKRES]
    ,[XINTB]
    ,[XSPEB]
FROM {{ source('SAP ECC', 'SKB1') }}