SELECT
    [WRBT3]
    ,[WRBT2]
    ,[FKBER]
    ,[WRBT1]
    ,[PPDIFF]
    ,[PPDIF3]
    ,[PPDIF2]
    ,[DMBT3]
    ,[DMBT2]
    ,[DMB21]
    ,[DMBT1]
    ,[DMB33]
    ,[DMB32]
    ,[DMB31]
    ,[DMB23]
    ,[DMB22]
    ,[BUDGET_PD]
    ,[GMVKZ]
    ,[REBZJ]
    ,[BDIFF]
    ,[BDIF3]
    ,[BDIF2]
    ,[INTRENO]
    ,[GJAHR]
    ,[ANFBJ]
    ,[AUGGJ]
    ,[WAERS]
    ,[GRANT_NBR]
    ,[GSBER]
    ,[HBKID]
    ,[WVERW]
    ,[PYCUR]
    ,[PSWSL]
    ,[HKTID]
    ,[MNDID]
    ,[IMKEY]
    ,[XBLNR]
    ,[XINVE]
    ,[BTYPE]
    ,[EGRUP]
    ,[XNOZA]
    ,[XNETB]
    ,[XNEGP]
    ,[XRAGL]
    ,[XPYPR]
    ,[XZAHL]
    ,[VNAME]
    ,[BUPLA]
    ,[XSTOV]
    ,[XEGDR]
    ,[XCPDD]
    ,[XARCH]
    ,[XANET]
    ,[KBLNR]
    ,[KBLPOS]
    ,[KKBER]
    ,[KONTT]
    ,[KOSTL]
    ,[KUNNR]
    ,[ZBD3T]
    ,[ZBD2T]
    ,[ZBD1T]
    ,[ZLSPR]
    ,[ZBFIX]
    ,[ZINKZ]
    ,[ZLSCH]
    ,[LOTKZ]
    ,[ZTERM]
    ,[ZUONR]
    ,[WSKTO]
    ,[WMWST]
    ,[WRBTR]
    ,[SKNTO]
    ,[SKNT3]
    ,[SKNT2]
    ,[LZBKZ]
    ,[MABER]
    ,[MANST]
    ,[SKFBT]
    ,[PYAMT]
    ,[PSWBT]
    ,[MWSTS]
    ,[MWST3]
    ,[MWST2]
    ,[MANSP]
    ,[MANDT]
    ,[DMBTR]
    ,[DMBE3]
    ,[DMBE2]
    ,[ABSBT]
    ,[FILKD]
    ,[EMPFB]
    ,[BSTAT]
    ,[ANLN1]
    ,[ANLN2]
    ,[SRTYPE]
    ,[GEBER]
    ,[BSCHL]
    ,[NPLNR]
    ,[AUFNR]
    ,[AUFPL]
    ,[LANDL]
    ,[REBZG]
    ,[BELNR]
    ,[ANFBN]
    ,[AUGBL]
    ,[EGLLD]
    ,[EGBLD]
    ,[MSCHL]
    ,[BLART]
    ,[MWSKZ]
    ,[MWSK3]
    ,[MWSK2]
    ,[MWSK1]
    ,[APLZL]
    ,[RFZEI]
    ,[VPOS2]
    ,[MONAT]
    ,[ETEN2]
    ,[PAYS_PROV]
    ,[PAYS_TRAN]
    ,[POSN2]
    ,[UEBGDAT]
    ,[QSSKZ]
    ,[MADAT]
    ,[RSTGR]
    ,[SAKNR]
    ,[HKONT]
    ,[SAMNR]
    ,[VBEWA]
    ,[SECCO]
    ,[SHKZG]
    ,[ZFBDT]
    ,[CPUDT]
    ,[BUDAT]
    ,[BLDAT]
    ,[ANFAE]
    ,[AUGDT]
    ,[PROJK]
    ,[DABRZ]
    ,[UZAWE]
    ,[VBELN]
    ,[VBEL2]
    ,[DTWS4]
    ,[DTWS3]
    ,[DTWS2]
    ,[DTWS1]
    ,[BUKRS]
    ,[ANFBU]
    ,[BVTYP]
    ,[REBZZ]
    ,[BUZEI]
    ,[PRCTR]
    ,[PPRCT]
    ,[STCEG]
    ,[ZBD2P]
    ,[ZBD1P]
    ,[PROJN]
    ,[VERTN]
    ,[VERTT]
    ,[VBUND]
    ,[REBZT]
    ,[PROPMANO]
    ,[CCBTC]
    ,[CESSION_KZ]
    ,[INFAE]
    ,[BUZID]
    ,[XREF2]
    ,[XREF1]
    ,[SGTXT]
    ,[XREF3]
    ,[KIDNO]
    ,[KONTL]
    ,[UMSKS]
    ,[UMSKZ]
    ,[ZUMSK]
    ,[FIPOS]
    ,[FISTL]
    ,[FKONT]
FROM {{ source('SAP ECC', 'BSID') }}