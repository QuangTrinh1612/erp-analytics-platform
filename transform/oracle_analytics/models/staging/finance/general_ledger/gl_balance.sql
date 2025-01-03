SELECT
    BalancePeriodNum AS PERIOD_NUM,
    BalanceBeginBalanceDrBeq AS BEGIN_BALANCE_DR_BEQ,
    BalanceTranslatedFlag AS TRANSLATED_FLAG,
    BalanceProjectToDateCrBeq AS PROJECT_TO_DATE_CR_BEQ,
    BalanceQuarterToDateDrBeq AS QUARTER_TO_DATE_DR_BEQ,
    BalancePeriodNetCr AS PERIOD_NET_CR,
    BalanceQuarterToDateCr AS QUARTER_TO_DATE_CR,
    BalanceCodeCombinationId AS CODE_COMBINATION_ID,
    BalanceEncumbranceTypeId AS ENCUMBRANCE_TYPE_ID,
    BalanceBeginBalanceCrBeq AS BEGIN_BALANCE_CR_BEQ,
    BalanceQuarterToDateDr AS QUARTER_TO_DATE_DR,
    BalanceLastUpdateDate AS LAST_UPDATE_DATE,
    BalanceLedgerId AS LEDGER_ID,
    BalancePeriodYear AS PERIOD_YEAR,
    BalancePeriodNetDrBeq AS PERIOD_NET_DR_BEQ,
    BalanceProjectToDateDr AS PROJECT_TO_DATE_DR,
    BalancePeriodNetDr AS PERIOD_NET_DR,
    BalanceLastUpdatedBy AS LAST_UPDATED_BY,
    BalancePeriodName AS PERIOD_NAME,
    BalanceProjectToDateDrBeq AS PROJECT_TO_DATE_DR_BEQ,
    BalanceObjectVersionNumber AS OBJECT_VERSION_NUMBER,
    BalanceProjectToDateCr AS PROJECT_TO_DATE_CR,
    BalanceBeginBalanceDr AS BEGIN_BALANCE_DR,
    BalanceCurrencyCode AS CURRENCY_CODE,
    BalancePeriodNetCrBeq AS PERIOD_NET_CR_BEQ,
    BalanceQuarterToDateCrBeq AS QUARTER_TO_DATE_CR_BEQ,
    BalanceActualFlag AS ACTUAL_FLAG,
    BalanceBeginBalanceCr AS BEGIN_BALANCE_CR
FROM
    {{ source('Fusion', 'Balance_PVO') }}