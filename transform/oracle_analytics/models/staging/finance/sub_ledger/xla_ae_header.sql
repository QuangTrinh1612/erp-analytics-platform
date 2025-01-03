SELECT
    JournalEntryHeaderDocSequenceValue AS DOC_SEQUENCE_VALUE,
    JournalEntryHeaderAttribute12 AS ATTRIBUTE12,
    JournalEntryHeaderAmbContextCode AS AMB_CONTEXT_CODE,
    JournalEntryHeaderCompletionAcctSeqVersionId AS COMPLETION_ACCT_SEQ_VERSION_ID,
    JournalEntryHeaderReferenceDate AS REFERENCE_DATE,
    JournalEntryHeaderFundsStatusCode AS FUNDS_STATUS_CODE,
    JournalEntryHeaderAttribute13 AS ATTRIBUTE13,
    JournalEntryHeaderCloseAcctSeqVersionId AS CLOSE_ACCT_SEQ_VERSION_ID,
    JournalEntryHeaderPacketId AS PACKET_ID,
    JournalEntryHeaderLastUpdateDate AS LAST_UPDATE_DATE,
    JournalEntryHeaderDocSequenceVersionId AS DOC_SEQUENCE_VERSION_ID,
    CompAcctSeqVersionsSeqVersionId AS SEQ_VERSION_ID,
    JournalEntryHeaderAttribute14 AS ATTRIBUTE14,
    JournalEntryHeaderAttribute10 AS ATTRIBUTE10,
    JournalEntryHeaderUpgValidFlag AS UPG_VALID_FLAG,
    JournalEntryHeaderEntityId AS ENTITY_ID,
    JournalEntryHeaderCreationDate AS CREATION_DATE,
    JournalEntryHeaderParentAeHeaderId AS PARENT_AE_HEADER_ID,
    JournalEntryHeaderUpgSourceApplicationId AS UPG_SOURCE_APPLICATION_ID,
    JournalEntryHeaderGlTransferStatusCode AS GL_TRANSFER_STATUS_CODE,
    JournalEntryHeaderAttribute15 AS ATTRIBUTE15,
    JournalEntryHeaderAttribute9 AS ATTRIBUTE9,
    JournalEntryHeaderAccountingBatchId AS ACCOUNTING_BATCH_ID,
    JournalEntryHeaderGroupId AS GROUP_ID,
    CloseAcctSeqVersionsSeqVersionId AS SEQ_VERSION_ID,
    JournalEntryHeaderLedgerId AS LEDGER_ID,
    JournalEntryHeaderProductRuleVersion AS PRODUCT_RULE_VERSION,
    JournalEntryHeaderAttributeCategory AS ATTRIBUTE_CATEGORY,
    JournalEntryHeaderAttribute2 AS ATTRIBUTE2,
    JournalEntryHeaderCompletionAcctSeqAssignId AS COMPLETION_ACCT_SEQ_ASSIGN_ID,
    JournalEntryHeaderEventTypeCode AS EVENT_TYPE_CODE,
    JournalEntryHeaderProductRuleTypeCode AS PRODUCT_RULE_TYPE_CODE,
    JournalEntryHeaderBalanceTypeCode AS BALANCE_TYPE_CODE,
    JournalEntryHeaderAttribute8 AS ATTRIBUTE8,
    JournalEntryHeaderCloseAcctSeqValue AS CLOSE_ACCT_SEQ_VALUE,
    JournalEntryHeaderUpgBatchId AS UPG_BATCH_ID,
    JournalEntryHeaderCloseAcctSeqAssignId AS CLOSE_ACCT_SEQ_ASSIGN_ID,
    JournalEntryHeaderDescription AS DESCRIPTION,
    JournalEntryHeaderProductRuleCode AS PRODUCT_RULE_CODE,
    CompAcctSeqVersionsVersionName AS VERSION_NAME,
    CompAcctSeqVersionsHeaderName AS HEADER_NAME,
    JournalEntryHeaderAttribute7 AS ATTRIBUTE7,
    JournalEntryHeaderAccountingEntryStatusCode AS ACCOUNTING_ENTRY_STATUS_CODE,
    JournalEntryHeaderMergeEventId AS MERGE_EVENT_ID,
    JournalEntryHeaderPeriodName AS PERIOD_NAME,
    JournalEntryHeaderRequestId AS REQUEST_ID,
    JournalEntryHeaderEventId AS EVENT_ID,
    JournalEntryHeaderAccountingEntryTypeCode AS ACCOUNTING_ENTRY_TYPE_CODE,
    JournalEntryHeaderAttribute1 AS ATTRIBUTE1,
    JournalEntryHeaderAttribute6 AS ATTRIBUTE6,
    JournalEntryHeaderLastUpdateLogin AS LAST_UPDATE_LOGIN,
    JournalEntryHeaderJeCategoryName AS JE_CATEGORY_NAME,
    JournalEntryHeaderObjectVersionNumber AS OBJECT_VERSION_NUMBER,
    JournalEntryHeaderAeHeaderId AS AE_HEADER_ID,
    JournalEntryHeaderCompletedDate AS COMPLETED_DATE,
    CloseAcctSeqVersionsHeaderName AS HEADER_NAME,
    JournalEntryHeaderDocSequenceAssignId AS DOC_SEQUENCE_ASSIGN_ID,
    JournalEntryHeaderMultiPeriodFlag AS MULTIPERIOD_FLAG,
    JournalEntryHeaderParentAeLineNum AS PARENT_AE_LINE_NUM,
    JournalEntryHeaderDocSequenceId AS DOC_SEQUENCE_ID,
    JournalEntryHeaderAccountingDate AS ACCOUNTING_DATE,
    JournalEntryHeaderDocCategoryCode AS DOC_CATEGORY_CODE,
    JournalEntryHeaderAttribute3 AS ATTRIBUTE3,
    JournalEntryHeaderLegalEntityId AS LEGAL_ENTITY_ID,
    JournalEntryHeaderApplicationId AS APPLICATION_ID,
    JournalEntryHeaderCompletionAcctSeqValue AS COMPLETION_ACCT_SEQ_VALUE,
    JournalEntryHeaderLastUpdatedBy AS LAST_UPDATED_BY,
    JournalEntryHeaderAttribute5 AS ATTRIBUTE5,
    JournalEntryHeaderGlTransferDate AS GL_TRANSFER_DATE,
    JournalEntryHeaderAccrualReversalFlag AS ACCRUAL_REVERSAL_FLAG,
    JournalEntryHeaderEncumbranceTypeId AS ENCUMBRANCE_TYPE_ID,
    JournalEntryHeaderCreatedBy AS CREATED_BY,
    JournalEntryHeaderBudgetVersionId AS BUDGET_VERSION_ID,
    JournalEntryHeaderZeroAmountFlag AS ZERO_AMOUNT_FLAG,
    JournalEntryHeaderAttribute11 AS ATTRIBUTE11,
    CloseAcctSeqVersionsVersionName AS VERSION_NAME,
    JournalEntryHeaderAttribute4 AS ATTRIBUTE4,
    JournalEntryHeaderNeedBalFlag AS NEED_BAL_CODE
FROM
    {{ source('Fusion', 'XLA_AE_Header_PVO') }}