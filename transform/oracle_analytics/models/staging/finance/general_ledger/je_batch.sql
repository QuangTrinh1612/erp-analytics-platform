SELECT
    JournalBatchApprovalStatusCode AS APPROVAL_STATUS_CODE,
    JournalBatchGroupId AS GROUP_ID,
    JournalBatchLastUpdateDate AS LAST_UPDATE_DATE,
    JournalBatchPostedDate AS POSTED_DATE,
    JournalBatchPeriodSetName AS PERIOD_SET_NAME,
    JournalBatchControlTotal AS CONTROL_TOTAL,
    JournalBatchRunningTotalDr AS RUNNING_TOTAL_DR,
    JournalBatchStatus AS STATUS,
    JournalBatchAverageJournalFlag AS AVERAGE_JOURNAL_FLAG,
    JournalBatchCreatedBy AS CREATED_BY,
    JournalBatchCreationDate AS CREATION_DATE,
    JournalBatchLastUpdatedBy AS LAST_UPDATED_BY,
    JournalBatchPostingRunId AS POSTING_RUN_ID,
    JournalBatchRunningTotalAccountedDr AS RUNNING_TOTAL_ACCOUNTED_DR,
    JournalBatchFundsStatusCode AS FUNDS_STATUS_CODE,
    JournalBatchParentJeBatchId AS PARENT_JE_BATCH_ID,
    JournalBatchJeBatchId AS JE_BATCH_ID,
    JournalBatchRunningTotalCr AS RUNNING_TOTAL_CR,
    JournalBatchRunningTotalAccountedCr AS RUNNING_TOTAL_ACCOUNTED_CR,
    JournalBatchAccountedPeriodType AS ACCOUNTED_PERIOD_TYPE,
    JournalBatchName AS NAME,
    JournalBatchRequestId AS REQUEST_ID,
    JournalBatchDescription AS DESCRIPTION,
    JournalBatchJeSource AS JE_SOURCE,
    JournalBatchApproverEmployeeId AS APPROVER_EMPLOYEE_ID,
    JournalBatchActualFlag AS ACTUAL_FLAG,
    JournalBatchDateCreated AS DATE_CREATED,
    JournalBatchDefaultEffectiveDate AS DEFAULT_EFFECTIVE_DATE,
    JournalBatchObjectVersionNumber AS OBJECT_VERSION_NUMBER,
    JournalBatchChartOfAccountsId AS CHART_OF_ACCOUNTS_ID,
    JournalBatchDefaultPeriodName AS DEFAULT_PERIOD_NAME,
    JournalBatchLastUpdateLogin AS LAST_UPDATE_LOGIN,
    JournalBatchErrorMessage AS ERROR_MESSAGE
FROM {{ source('Fusion', 'Journal_Batch_PVO') }}