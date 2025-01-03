SELECT
    NextFyPotentialRevenue AS NEXT_FY_POTENTIAL_REVENUE,
    Comments AS COMMENTS,
    IdenAddrPartySiteId AS IDEN_ADDR_PARTY_SITE_ID,
    TradingPartnerIdentifier AS TRADING_PARTNER_IDENTIFIER,
    PrimaryPhoneAreaCode AS PRIMARY_PHONE_AREA_CODE,
    PartyNumber AS PARTY_NUMBER,
    PersonLastName AS PERSON_LAST_NAME,
    State AS STATE,
    PersonAcademicTitle AS PERSON_ACADEMIC_TITLE,
    PrimaryPhoneLineType AS PRIMARY_PHONE_LINE_TYPE,
    RequestId AS REQUEST_ID,
    Salutation AS SALUTATION,
    PartyName AS PARTY_NAME,
    PrimaryPhoneCountryCode AS PRIMARY_PHONE_COUNTRY_CODE,
    Building AS BUILDING,
    PreferredContactMethod AS PREFERRED_CONTACT_METHOD,
    PrimaryPhoneExtension AS PRIMARY_PHONE_EXTENSION,
    PrimaryUrlContactPtId AS PRIMARY_URL_CONTACT_PT_ID,
    CreatedBy1 AS CREATED_BY,
    PrimaryPhonePurpose AS PRIMARY_PHONE_PURPOSE,
    AddrElementAttribute4 AS ADDR_ELEMENT_ATTRIBUTE4,
    AddrElementAttribute3 AS ADDR_ELEMENT_ATTRIBUTE3,
    PostalCode AS POSTAL_CODE,
    HomeCountry AS HOME_COUNTRY,
    -- LastUpdateDate1 AS LAST_UPDATE_DATE,
    LanguageName AS LANGUAGE_NAME,
    InternalFlag AS INTERNAL_FLAG,
    LastUpdateLogin1 AS LAST_UPDATE_LOGIN,
    CertReasonCode AS CERT_REASON_CODE,
    AnalysisFy AS ANALYSIS_FY,
    UserGuid AS USER_GUID,
    CertificationLevel AS CERTIFICATION_LEVEL,
    Address4 AS ADDRESS4,
    ValidatedFlag AS VALIDATED_FLAG,
    CreatedBy AS CREATED_BY,
    LastUpdateDate AS LAST_UPDATE_DATE,
    AddrElementAttribute2 AS ADDR_ELEMENT_ATTRIBUTE2,
    Latitude AS LATITUDE,
    CreatedByModule AS CREATED_BY_MODULE,
    GroupType AS GROUP_TYPE,
    EffectiveEndDate AS EFFECTIVE_END_DATE,
    LastUpdatedBy AS LAST_UPDATED_BY,
    AddrElementAttribute5 AS ADDR_ELEMENT_ATTRIBUTE5,
    PartyUsageCode AS PARTY_USAGE_CODE,
    Address1 AS ADDRESS1,
    Url AS URL,
    PrimaryEmailContactPtId AS PRIMARY_EMAIL_CONTACT_PT_ID,
    PrimaryPhoneNumber AS PRIMARY_PHONE_NUMBER,
    LastUpdatedBy1 AS LAST_UPDATED_BY,
    CategoryCode AS CATEGORY_CODE,
    PreferredContactPersonId AS PREFERRED_CONTACT_PERSON_ID,
    PartyType AS PARTY_TYPE,
    GsaIndicatorFlag AS GSA_INDICATOR_FLAG,
    Address2 AS ADDRESS2,
    PersonSecondLastName AS PERSON_SECOND_LAST_NAME,
    County AS COUNTY,
    CurrFyPotentialRevenue AS CURR_FY_POTENTIAL_REVENUE,
    EffectiveStartDate AS EFFECTIVE_START_DATE,
    PostalCodeExtension AS POSTAL_PLUS4_CODE,
    PersonTitle AS PERSON_TITLE,
    PersonLastNamePrefix AS PERSON_LAST_NAME_PREFIX,
    YearEstablished AS YEAR_ESTABLISHED,
    FloorNumber AS FLOOR_NUMBER,
    AddrElementAttribute1 AS ADDR_ELEMENT_ATTRIBUTE1,
    CeoName AS CEO_NAME,
    CreatedByModule1 AS CREATED_BY_MODULE,
    EmailAddress AS EMAIL_ADDRESS,
    HqBranchInd AS HQ_BRANCH_IND,
    PrefFunctionalCurrency AS PREF_FUNCTIONAL_CURRENCY,
    OwnerTableName AS OWNER_TABLE_NAME,
    OwnerTableId AS OWNER_TABLE_ID,
    Comments1 AS COMMENTS,
    Gender AS GENDER,
    MissionStatement AS MISSION_STATEMENT,
    DunsNumberC AS DUNS_NUMBER_C,
    FiscalYearendMonth AS FISCAL_YEAREND_MONTH,
    Longitude AS LONGITUDE,
    OrigSystemReference AS ORIG_SYSTEM_REFERENCE,
    SicCode AS SIC_CODE,
    MaritalStatus AS MARITAL_STATUS,
    DateOfBirth AS DATE_OF_BIRTH,
    ThirdPartyFlag AS THIRD_PARTY_FLAG,
    PersonPreNameAdjunct AS PERSON_PRE_NAME_ADJUNCT,
    PrimaryPhoneContactPtId AS PRIMARY_PHONE_CONTACT_PT_ID,
    PersonMiddleName AS PERSON_MIDDLE_NAME,
    -- CreationDate1 AS CREATION_DATE,
    IdenAddrLocationId AS IDEN_ADDR_LOCATION_ID,
    LastUpdateLogin AS LAST_UPDATE_LOGIN,
    PersonFirstName AS PERSON_FIRST_NAME,
    PreferredName AS PREFERRED_NAME,
    SicCodeType AS SIC_CODE_TYPE,
    PreferredNameId AS PREFERRED_NAME_ID,
    Province AS PROVINCE,
    EmployeesTotal AS EMPLOYEES_TOTAL,
    StatusFlag AS STATUS_FLAG,
    Country AS COUNTRY,
    PersonPreviousLastName AS PERSON_PREVIOUS_LAST_NAME,
    LocationId AS LOCATION_ID,
    PartyId AS PARTY_ID,
    Address3 AS ADDRESS3,
    Status AS STATUS,
    City AS CITY,
    CreationDate AS CREATION_DATE,
    PartyUniqueName AS PARTY_UNIQUE_NAME,
    PartyUsgAssignmentId AS PARTY_USG_ASSIGNMENT_ID,
    PersonNameSuffix AS PERSON_NAME_SUFFIX,
    JgzzFiscalCode AS JGZZ_FISCAL_CODE
FROM
    {{ source('Fusion', 'Customer_PVO') }}