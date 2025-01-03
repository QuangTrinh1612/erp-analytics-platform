SELECT
    [STAGING_TIME]
    ,[SCHEDULING_TYPE]
    ,[TRANSPORT_CHAIN]
    ,[ALC]
    ,[PMT_OFFICE]
    ,[PSOTL]
    ,[J_1KFTBUS]
    ,[J_SC_CURRENCY]
    ,[SUBMI_RELEVANT]
    ,[J_1KFTIND]
    ,[XLFZA]
    ,[XZEMP]
    ,[ACTSS]
    ,[FITYP]
    ,[STCDT]
    ,[XCPDK]
    ,[WERKR]
    ,[SPERM]
    ,[SPERR]
    ,[STKZU]
    ,[SPERZ]
    ,[NODEL]
    ,[LOEVM]
    ,[KONZS]
    ,[LTSNA]
    ,[TERM_LI]
    ,[IPISP]
    ,[REGSS]
    ,[KTOKK]
    ,[KTOCK]
    ,[MIN_COMP]
    ,[KUNNR]
    ,[BORGR_YEAUN]
    ,[LNRZA]
    ,[LIFNR]
    ,[FISKU]
    ,[FISKN]
    ,[LZONE]
    ,[WERKS]
    ,[MANDT]
    ,[CARRIER_CONF]
    ,[PLKAL]
    ,[ADRNR]
    ,[SPRAS]
    ,[CVP_XBLCK]
    ,[BEGRU]
    ,[BRSCH]
    ,[UPTIM]
    ,[BAHNS]
    ,[LAND1]
    ,[PSOVN]
    ,[NAME4]
    ,[PSON3]
    ,[NAME3]
    ,[PSON2]
    ,[NAME2]
    ,[PSON1]
    ,[NAME1]
    ,[BUBKZ]
    ,[BBSNR]
    ,[BBBNR]
    ,[ESRNR]
    ,[PFACH]
    ,[PODKZB]
    ,[BORGR_DATUN]
    ,[RNEDATE]
    ,[RGDATE]
    ,[UPDAT]
    ,[REVDB]
    ,[SPERQ]
    ,[QSSYS]
    ,[J_1KFREPRE]
    ,[QSSYSDAT]
    ,[GBDAT]
    ,[ERDAT]
    ,[SCACD]
    ,[SEXKZ]
    ,[SFRGR]
    ,[ERNAM]
    ,[DLGRP]
    ,[DTAMS]
    ,[DTAWS]
    ,[DUEFL]
    ,[STCD1]
    ,[STCD2]
    ,[STCEG]
    ,[STGDL]
    ,[STKZA]
    ,[STKZN]
    ,[PSOFG]
    ,[PSOST]
    ,[PSTLZ]
    ,[PSTL2]
    ,[TAXBS]
    ,[J_SC_CAPITAL]
    ,[VBUND]
    ,[REGIO]
    ,[LFURL]
    ,[DATLT]
    ,[PSOHS]
    ,[CONFS]
    ,[TELBX]
    ,[ANRED]
    ,[TELF2]
    ,[TELF1]
    ,[GBORT]
    ,[SORTL]
    ,[EMNFR]
    ,[KRAUS]
    ,[TELX1]
    ,[TELTX]
    ,[PROFS]
    ,[TELFX]
    ,[STRAS]
    ,[PFORT]
    ,[ORT02]
    ,[ORT01]
    ,[STENR]
    ,[STCD4]
    ,[STCD3]
    ,[PSOIS]
    ,[MCOD3]
    ,[MCOD2]
    ,[MCOD1]
    ,[CRC_NUM]
    ,[TXJCD]
    ,[DUNSP4]
    ,[STCD5]
    ,[CNAE]
    ,[COMSIZE]
    ,[CRTN]
    ,[DECREGPC]
    ,[EXP]
    ,[ICMSTAXPAY]
    ,[INDTYP]
    ,[RG]
    ,[RNE]
    ,[TDT]
    ,[UF]
    ,[LEGALNAT]
    ,[RIC]
FROM {{ source('SAP ECC', 'LFA1') }}