SELECT
    JournalSourceAttribute4 AS ATTRIBUTE4,
    JournalSourceCreationDate AS CREATION_DATE,
    JournalSourceAttribute1 AS ATTRIBUTE1,
    JrnlSrcTransLangLastUpdatedBy AS LAST_UPDATED_BY,
    JournalSourceLastUpdateDate AS LAST_UPDATE_DATE,
    JournalSourceImpUsingKeyFlag AS IMPORT_USING_KEY_FLAG,
    JrnlSrcTransLangLastUpdateDate AS LAST_UPDATE_DATE,
    JournalSourceJournalRefFlag AS JOURNAL_REFERENCE_FLAG,
    JrnlSrcTransLangLastUpdateLog AS LAST_UPDATE_LOGIN,
    JournalSourceAttribute5 AS ATTRIBUTE5,
    JournalSourceLastUpdateLogin AS LAST_UPDATE_LOGIN,
    JournalSourceAttribute2 AS ATTRIBUTE2,
    JournalSourceAttributeCategory AS ATTRIBUTE_CATEGORY,
    JournalSourceObjectVersionNum AS OBJECT_VERSION_NUMBER,
    JournalSourceEffDateRuleCode AS EFFECTIVE_DATE_RULE_CODE,
    JournalSourceLastUpdatedBy AS LAST_UPDATED_BY,
    JournalSourceAttribute3 AS ATTRIBUTE3,
    JrnlSrcTransLangDescription AS DESCRIPTION,
    JrnlSrcTransLangLanguage AS LANGUAGE,
    JournalSourceJeSourceKey AS JE_SOURCE_KEY,
    JournalSourceCreatedBy AS CREATED_BY,
    JournalSourceJeSourceName AS JE_SOURCE_NAME,
    JrnlSrcTransLangJeSourceName AS JE_SOURCE_NAME,
    JrnlSrcTransLangSourceLang AS SOURCE_LANG,
    JournalSourceJournalApprvlFlag AS JOURNAL_APPROVAL_FLAG,
    JournalSourceOverrideEditsFlag AS OVERRIDE_EDITS_FLAG,
    JrnlSrcTransLangCreationDate AS CREATION_DATE,
    JrnlSrcTransLangCreatedBy AS CREATED_BY,
    JrnlSrcTransLangUserJeSrcName AS USER_JE_SOURCE_NAME,
    JournalSourceXlaApprovalFlag AS XLA_APPROVAL_FLAG
FROM {{ source('Fusion', 'Journal_Source_PVO') }}