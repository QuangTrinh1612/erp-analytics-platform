SELECT
    [FKTYP_CRM]
    ,[FKTYP]
    ,[RPLNR]
    ,[GJAHR]
    ,[CMWAE]
    ,[WAERK]
    ,[STWAE]
    ,[AKWAE]
    ,[MTLAUR]
    ,[PHASE]
    ,[HITYP_PR]
    ,[MNDID]
    ,[INCO1]
    ,[INCO2]
    ,[XBLNR]
    ,[STAGE]
    ,[J_1AFITP]
    ,[BUPLA]
    ,[XEGDR]
    ,[NUMPG]
    ,[J_3GKBAUL]
    ,[J_3GKENIE]
    ,[KALSM]
    ,[KAPPL]
    ,[KDGRP]
    ,[MRNKZ]
    ,[KKBER]
    ,[KNUMA]
    ,[KNUMV]
    ,[KONDA]
    ,[KTGRD]
    ,[FKSTO]
    ,[KURRF]
    ,[CMKUF]
    ,[AKKUR]
    ,[KNKLI]
    ,[KUNWE]
    ,[KUNRG]
    ,[KUNAG]
    ,[KURST]
    ,[LCNUM]
    ,[ZLSCH]
    ,[LOGSYS]
    ,[FK_SOURCE_SYS]
    ,[ZTERM]
    ,[ZUONR]
    ,[MABER]
    ,[MANDT]
    ,[MANSP]
    ,[MWSBK]
    ,[NETWR]
    ,[VBTYP_EXT]
    ,[SPE_BILLING_IND]
    ,[SMENR]
    ,[SPART]
    ,[SPPAYM]
    ,[J_1TPBUPL]
    ,[STCEG_L]
    ,[LAND1]
    ,[LANDTX]
    ,[BELNR]
    ,[MSCHL]
    ,[CITYC]
    ,[EXNUM]
    ,[EXPKZ]
    ,[VKONT]
    ,[VTREF]
    ,[COUNC]
    ,[PLTYP]
    ,[POPER]
    ,[HB_RESDATE]
    ,[HB_EXPDATE]
    ,[KURRF_DAT]
    ,[VALDT]
    ,[FKDAT_RL]
    ,[FKDAT]
    ,[ERDAT]
    ,[MNDVG]
    ,[SEPON]
    ,[PAY_TYPE]
    ,[ERNAM]
    ,[AEDAT]
    ,[ERZET]
    ,[CPKUR]
    ,[VBELN]
    ,[BSTNK_VF]
    ,[BUKRS]
    ,[SFAKN]
    ,[SPPORD]
    ,[AD01BASDOC]
    ,[BVTYP]
    ,[VKORG]
    ,[BZIRK]
    ,[VSBED]
    ,[VTWEG]
    ,[STAFO]
    ,[STCEG]
    ,[STCEG_H]
    ,[STGRD]
    ,[SWENR]
    ,[AD01FAREG]
    ,[TAXK9]
    ,[TAXK8]
    ,[TAXK7]
    ,[TAXK6]
    ,[TAXK5]
    ,[TAXK4]
    ,[TAXK3]
    ,[TAXK2]
    ,[VCHRNMBR]
    ,[VALTG]
    ,[VBUND]
    ,[REGIO]
    ,[TAXK1]
    ,[DPC_REL]
    ,[NRZAS]
    ,[HB_CONT_REASON]
    ,[KIDNO]
    ,[ZUKRI]
    ,[RFBSK]
    ,[FKK_DOCSTAT]
    ,[FKART_RL]
    ,[FKART_AB]
    ,[FKART]
    ,[VBTYP]
FROM {{ source('SAP ECC', 'VBRK') }}