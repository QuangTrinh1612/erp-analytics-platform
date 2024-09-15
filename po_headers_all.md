| Name | Datatype | Length | Precision | Not-null | Comments | Flexfield-mapping |
| --- | --- | --- | --- | --- | --- | --- |
| PO_DISTRIBUTION_ID | NUMBER |  | 18 | Yes | Document distribution unique identifier. Primary key for this table. |  |
| BUDGET_DATE | DATE |  |  |  | Budget date used for commitment control |  |
| CANCEL_BUDGET_DATE | DATE |  |  |  | Budget date used for commitment control for cancel action |  |
| CLOSE_BUDGET_DATE | DATE |  |  |  | Budget date used for commitment control for close action |  |
| FUNDS_STATUS | VARCHAR2 | 25 |  |  | Indicates whether the distribution amount is reserved or not |  |
| LAST_UPDATE_DATE | TIMESTAMP |  |  | Yes | Who column: indicates the date and time of the last update of the row. |  |
| DIST_INTENDED_USE | VARCHAR2 | 240 |  |  | Intended Use is the purpose for which a product is likely to be used in the business by the purchaser |  |
| PRC_BU_ID | NUMBER |  | 18 | Yes | PRC_BU_ID |  |
| REQ_BU_ID | NUMBER |  | 18 | Yes | REQ_BU_ID |  |
| LAST_UPDATED_BY | VARCHAR2 | 64 |  | Yes | Who column: indicates the user who last updated the row. |  |
| PO_HEADER_ID | NUMBER |  | 18 | Yes | Document header unique identifier. References PO_HEADERS_ALL.PO_HEADER_ID. |  |
| PO_LINE_ID | NUMBER |  | 18 | Yes | Document line unique identifier. References PO_LINES_ALL.PO_LINE_ID. |  |
| LINE_LOCATION_ID | NUMBER |  | 18 | Yes | Document shipment schedule unique identifier. References PO_LINES_LOCATIONS_ALL.LINE_LOCATION_ID. |  |
| SET_OF_BOOKS_ID | NUMBER |  | 18 | Yes | Set of Books unique identifier. References GL_SETS_OF_BOOKS.SET_OF_BOOKS_ID. |  |
| CODE_COMBINATION_ID | NUMBER |  | 18 |  | Unique identifier for the General Ledger charge account. References GL_CODE_COMBINATIONS.CODE_COMBINATION_ID. |  |
| QUANTITY_ORDERED | NUMBER |  |  |  | Quantity ordered on the distribution |  |
| LAST_UPDATE_LOGIN | VARCHAR2 | 32 |  |  | Who column: indicates the session login associated to the user who last updated the row. |  |
| CREATION_DATE | TIMESTAMP |  |  | Yes | Who column: indicates the date and time of the creation of the row. |  |
| CREATED_BY | VARCHAR2 | 64 |  | Yes | Who column: indicates the user who created the row. |  |
| QUANTITY_DELIVERED | NUMBER |  |  |  | Quantity delivered against the distribution |  |
| QUANTITY_BILLED | NUMBER |  |  |  | Quantity invoiced by Oracle Payables against the distribution |  |
| QUANTITY_CANCELLED | NUMBER |  |  |  | Quantity cancelled for the distribution |  |
| CONSIGNMENT_QUANTITY | NUMBER |  |  |  | Quantity In Consigned Inventory after deliver transaction |  |
| REQ_HEADER_REFERENCE_NUM | VARCHAR2 | 25 |  |  | Identifies the requisition number of the corresponding paper requisition, if you do not autocreate the purchase order from online requisitions. |  |
| REQ_LINE_REFERENCE_NUM | VARCHAR2 | 25 |  |  | Identifies the requisition line number of the corresponding paper requisition, if you do not autocreate the purchase order from online requisitions. |  |
| REQ_DISTRIBUTION_ID | NUMBER |  | 18 |  | Requisition distribution unique identifier. References PO_REQ_DISTRIBUTIONS_ALL.DISTRIBUTION_ID. |  |
| DELIVER_TO_LOCATION_ID | NUMBER |  | 18 |  | Unique identifier for the delivery location. References HR_LOCATIONS_ALL.LOCATION_ID. |  |
| DELIVER_TO_PERSON_ID | NUMBER |  | 18 |  | Unique identifier for the requester. References HR_EMPLOYEES.EMPLOYEE_ID. |  |
| RATE_DATE | DATE |  |  |  | Currency conversion date |  |
| RATE | NUMBER |  |  |  | Currency conversion rate. References GL_DAILY_CONVERSION_RATES_R10.CONVERSION_RATE. |  |
| AMOUNT_BILLED | NUMBER |  |  |  | Amount invoiced by Oracle Payables against the distribution |  |
| ACCRUED_FLAG | VARCHAR2 | 1 |  |  | Indicates whether the distribution was accrued (received but not yet billed). |  |
| ENCUMBERED_FLAG | VARCHAR2 | 1 |  |  | Distribution encumbered flag |  |
| ENCUMBERED_AMOUNT | NUMBER |  |  |  | Encumbered amount for distribution |  |
| UNENCUMBERED_QUANTITY | NUMBER |  |  |  | Quantity unencumbered on the distribution |  |
| UNENCUMBERED_AMOUNT | NUMBER |  |  |  | Amount unencumbered on the distribution |  |
| FAILED_FUNDS_LOOKUP_CODE | VARCHAR2 | 25 |  |  | Type of budgetary control approval failure |  |
| GL_ENCUMBERED_DATE | DATE |  |  |  | Date the distribution was encumbered |  |
| GL_ENCUMBERED_PERIOD_NAME | VARCHAR2 | 15 |  |  | Period in which the distribution was encumbered |  |
| GL_CANCELLED_DATE | DATE |  |  |  | Date the distribution was cancelled |  |
| DESTINATION_TYPE_CODE | VARCHAR2 | 25 |  |  | Final destination of the purchased items |  |
| DESTINATION_ORGANIZATION_ID | NUMBER |  | 18 |  | Final destination organization unique identifier. References HR_ALL_ORGANIZATION_UNITS.ORGANIZATION_ID. Combined with DESTINATION_SUBINVENTORY, forms a foreign key to INV_SECONDARY_INVENTORIES. Combined with WIP_ENTITY_ID, forms a foreign key to WIP_ENTITIES. Combined with WIP_LINE_ID, forms a foreign key to WIP_LINES. Combined with WIP_ENTITY_ID, WIP_OPERATION_SEQ_NUM, and WIP_REPETITIVE_SCHEDULE_ID, forms a foreign key to WIP_OPERATIONS. Combined with WIP_ENTITY_ID, WIP_OPERATION_SEQ_NUM, WIP_RESOURCE_SEQ_NUM, and WIP_REPETITIVE_SCHEDULE_ID, forms a foreign key to WIP_OPERATION_RESOURCES. |  |
| DESTINATION_SUBINVENTORY | VARCHAR2 | 10 |  |  | Subinventory unique identifier for inventory purchases. Combined with DESTINATION_ORGANIZATION_ID, forms a foreign key to INV_SECONDARY_INVENTORIES. |  |
| ATTRIBUTE_CATEGORY | VARCHAR2 | 30 |  |  | Descriptive Flexfield: structure definition of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE1 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE2 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE3 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE4 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE5 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE6 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE7 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE8 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE9 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE10 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE11 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE12 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE13 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE14 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE15 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE16 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE17 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE18 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE19 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE20 | VARCHAR2 | 150 |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER1 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER2 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER3 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER4 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER5 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER6 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER7 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER8 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER9 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_NUMBER10 | NUMBER |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE1 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE2 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE3 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE4 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE5 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE6 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE7 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE8 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE9 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_DATE10 | DATE |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP1 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP2 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP3 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP4 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP5 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP6 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP7 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP8 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP9 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| ATTRIBUTE_TIMESTAMP10 | TIMESTAMP |  |  |  | Descriptive Flexfield: segment of the user descriptive flexfield. | Purchase Order Distributions (PO_DISTRIBUTIONS) |
| GLOBAL_ATTRIBUTE_CATEGORY | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: structure definition of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE1 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE2 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE3 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE4 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE5 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE6 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE7 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE8 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE9 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE10 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE11 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE12 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE13 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE14 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE15 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE16 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE17 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE18 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE19 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE20 | VARCHAR2 | 150 |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_DATE1 | DATE |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_DATE2 | DATE |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_DATE3 | DATE |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_DATE4 | DATE |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_DATE5 | DATE |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_NUMBER1 | NUMBER |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_NUMBER2 | NUMBER |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_NUMBER3 | NUMBER |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_NUMBER4 | NUMBER |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| GLOBAL_ATTRIBUTE_NUMBER5 | NUMBER |  |  |  | Global Descriptive Flexfield: segment of the global descriptive flexfield. |  |
| WIP_ENTITY_ID | NUMBER |  | 18 |  | WIP job or repetitive assembly identifier. Combined with DESTINATION_ORGANIZATION_ID, forms a foreign key to WIP_ENTITIES. Combined with DESTINATION_ORGANIZATION_ID, WIP_OPERATION_SEQ_NUM, and WIP_REPETITIVE_SCHEDULE_ID, forms a foreign key to WIP_OPERATIONS. Combined with DESTINATION_ORGANIZATION_ID, WIP_OPERATION_SEQ_NUM, WIP_RESOURCE_SEQ_NUM, and WIP_REPETITIVE_SCHEDULE_ID, forms a foreign key to WIP_OPERATION_RESOURCES. |  |
| WIP_OPERATION_SEQ_NUM | NUMBER |  |  |  | WIP operation sequence number within a routing. Combined with WIP_ENTITY_ID, DESTINATION_ORGANIZATION_ID, WIP_REPETITIVE_SCHEDULE_ID, forms a foreign key to WIP_OPERATIONS. Combined with WIP_ENTITY_ID, DESTINATION_ORGANIZATION_ID, WIP_RESOURCE_SEQ_NUM, and WIP_REPETITIVE_SCHEDULE_ID, forms a foreign key to WIP_OPERATION_RESOURCES. |  |
| WIP_RESOURCE_SEQ_NUM | NUMBER |  |  |  | WIP resource sequence number. Combined with WIP_ENTITY_ID, DESTINATION_ORGANIZATION_ID, WIP_OPERATION_SEQ_NUM, and WIP_REPETITIVE_SCHEDULE_ID, forms a foreign key to WIP_OPERATION_RESOURCES. |  |
| WIP_REPETITIVE_SCHEDULE_ID | NUMBER |  | 18 |  | WIP repetitive schedule identifier. Combined with WIP_ENTITY_ID, DESTINATION_ORGANIZATION_ID, and WIP_OPERATION_SEQ_NUM, forms a foreign key to WIP_OPERATIONS. Combined with WIP_ENTITY_ID, DESTINATION_ORGANIZATION_ID, WIP_OPERATION_SEQ_NUM, and WIP_RESOURCE_SEQ_NUM, forms a foreign key to WIP_OPERATION_RESOURCES. |  |
| WIP_LINE_ID | NUMBER |  | 18 |  | WIP line identifier. Combined with DESTINATION_ORGANIZATION_ID, forms a foreign key to WIP_LINES. |  |
| BOM_RESOURCE_ID | NUMBER |  | 18 |  | BOM resource unique identifier. References BOM_RESOURCES.RESOURCE_ID. |  |
| BUDGET_ACCOUNT_ID | NUMBER |  | 18 |  | Unique identifier for the General Ledger budget account. References GL_CODE_COMBINATIONS.CODE_COMBINATION_ID. |  |
| ACCRUAL_ACCOUNT_ID | NUMBER |  | 18 |  | Unique identifier for the General Ledger accrual account. References GL_CODE_COMBINATIONS.CODE_COMBINATION_ID. |  |
| VARIANCE_ACCOUNT_ID | NUMBER |  | 18 |  | Unique identifier for the General Ledger variance account. References GL_CODE_COMBINATIONS.CODE_COMBINATION_ID. |  |
| PREVENT_ENCUMBRANCE_FLAG | VARCHAR2 | 1 |  |  | Indicates whether distribution should be encumbered |  |
| GOVERNMENT_CONTEXT | VARCHAR2 | 30 |  |  | USSGL descriptive flexfield context column |  |
| DESTINATION_CONTEXT | VARCHAR2 | 30 |  |  | Protected descriptive flexfield context column for destination details |  |
| DISTRIBUTION_NUM | NUMBER |  |  | Yes | Distribution number |  |
| SOURCE_DISTRIBUTION_ID | NUMBER |  | 18 |  | Unique identifier of the planned purchase order distribution that was referenced when creating this scheduled release distribution. References PO_DISTRIBUTIONS_ALL.PO_DISTRIBUTION_ID. |  |
| REQUEST_ID | NUMBER |  | 18 |  | Enterprise Service Scheduler: indicates the request ID of the job that created or last updated the row. |  |
| JOB_DEFINITION_NAME | VARCHAR2 | 100 |  |  | Enterprise Service Scheduler: indicates the name of the job that created or last updated the row. |  |
| JOB_DEFINITION_PACKAGE | VARCHAR2 | 900 |  |  | Enterprise Service Scheduler: indicates the package name of the job that created or last updated the row. |  |
| PROGRAM_NAME | VARCHAR2 | 30 |  |  | PROGRAM_NAME |  |
| PROGRAM_APP_NAME | VARCHAR2 | 50 |  |  | PROGRAM_APP_NAME |  |
| GL_CLOSED_DATE | DATE |  |  |  | Date the distribution was final-closed |  |
| ACCRUE_ON_RECEIPT_FLAG | VARCHAR2 | 1 |  |  | Indicates whether items are accrued upon receipt |  |
| SOLDTO_BU_ID | NUMBER |  | 18 |  | Sold to Business Unit Unique Identifier |  |
| KANBAN_CARD_ID | NUMBER |  | 18 |  | Primary key for the kanban card. References MTL_KANBAN_CARDS.KANBAN_CARD_ID. |  |
| AWARD_ID | NUMBER |  | 18 |  | Award identifier. References GMS_AWARD_DISTRIBUTIONS.AWARD_SET_ID. |  |
| END_ITEM_UNIT_NUMBER | VARCHAR2 | 30 |  |  | Project Manufacturing end item unit number |  |
| TAX_RECOVERY_OVERRIDE_FLAG | VARCHAR2 | 1 |  |  | Indicator of whether tax recovery should be used |  |
| RECOVERABLE_TAX | NUMBER |  |  |  | The Recoverable exclusive tax amount for the distribution. |  |
| NONRECOVERABLE_TAX | NUMBER |  |  |  | The Nonrecoverable exclusive tax amount for the distribution. |  |
| RECOVERABLE_INCLUSIVE_TAX | NUMBER |  |  |  | The portion of the taxes paid that is included in the Distribution Ordered amount and which is recoverable. |  |
| NONRECOVERABLE_INCLUSIVE_TAX | NUMBER |  |  |  | The portion of the taxes paid that is included in the Distribution Ordered amount and which is nonrecoverable. |  |
| TAX_EXCLUSIVE_AMOUNT | NUMBER |  |  |  | The Purchase order distribution amount that is exclusive of all the taxes. |  |
| RECOVERY_RATE | NUMBER |  |  |  | Percentage of tax that can be recovered |  |
| OKE_CONTRACT_LINE_ID | NUMBER |  | 18 |  | Line Id associated with a contract. References OKC_K_LINES_B.ID. |  |
| OKE_CONTRACT_DELIVERABLE_ID | NUMBER |  | 18 |  | Deliverable Id corresponding to contract. References OKE_K_DELIVERABLES_B.DELIVERABLE_ID. |  |
| AMOUNT_ORDERED | NUMBER |  |  |  | Amount ordered for service lines |  |
| AMOUNT_DELIVERED | NUMBER |  |  |  | Amount delivered for service lines |  |
| AMOUNT_CANCELLED | NUMBER |  |  |  | Amount cancelled for service lines |  |
| DISTRIBUTION_TYPE | VARCHAR2 | 25 |  |  | -- FPJ Encumbrance Rewrite project |  |
| AMOUNT_TO_ENCUMBER | NUMBER |  |  |  | -- FPJ Encumbrance Rewrite Project |  |
| INVOICE_ADJUSTMENT_FLAG | VARCHAR2 | 1 |  |  | Flag to indicate invoice adjustment |  |
| DEST_CHARGE_ACCOUNT_ID | NUMBER |  | 18 |  | Added in Shared Procurement Services Project (FPJ). This is the Charge Account of the Destination OU (DOU), when the DOU is different from the Purchasing OU (POU) and a Transaction Flow exists between the DOU and POU. It is a unique identifier for a General Ledger account and references GL_CODE_COMBINATIONS.code_combination_id. |  |
| DEST_VARIANCE_ACCOUNT_ID | NUMBER |  | 18 |  | Added in Shared Procurement Services Project (FPJ). This is the  Variance Account of the DOU, when the DOU is different from the POU and a Transaction Flow exists between the DOU and POU. It is a unique identifier for a General Ledger account and references GL_CODE_COMBINATIONS.code_combination_id. |  |
| QUANTITY_FINANCED | NUMBER |  |  |  | For Financing Distributions, the number of units which have been pre-paid |  |
| AMOUNT_FINANCED | NUMBER |  |  |  | For Advance or Financing Distributions, the amount which has been pre-paid |  |
| QUANTITY_RECOUPED | NUMBER |  |  |  | For Financing Distributions, the number of units for which prepayments have been liquidated |  |
| AMOUNT_RECOUPED | NUMBER |  |  |  | For Advance or Financing Distributions, the amount of the prepayments which has been liquidated |  |
| RETAINAGE_WITHHELD_AMOUNT | NUMBER |  |  |  | The total amount withheld as Retainage against this Distribution |  |
| RETAINAGE_RELEASED_AMOUNT | NUMBER |  |  |  | The amount of Retainage released for this Distribution |  |
| INVOICED_VAL_IN_NTFN | NUMBER |  |  |  | Amount or Quantity Billed at the time of sending the Confirm Receipt notification |  |
| TAX_ATTRIBUTE_UPDATE_CODE | VARCHAR2 | 15 |  |  | Keeps track of create/update actions on this entity |  |
| INTERFACE_DISTRIBUTION_REF | VARCHAR2 | 240 |  |  | Interface Distribution Reference |  |
| OBJECT_VERSION_NUMBER | NUMBER |  | 9 | Yes | Used to implement optimistic locking. This number is incremented every time that the row is updated. The number is compared at the start and end of a transaction to detect whether another session has updated the row since it was queried. |  |
| PJC_PROJECT_ID | NUMBER |  | 18 |  | PJC_PROJECT_ID | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_TASK_ID | NUMBER |  | 18 |  | PJC_TASK_ID | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_EXPENDITURE_ITEM_DATE | DATE |  |  |  | PJC_EXPENDITURE_ITEM_DATE | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_ORGANIZATION_ID | NUMBER |  | 18 |  | PJC_ORGANIZATION_ID | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_EXPENDITURE_TYPE_ID | NUMBER |  | 18 |  | Expenditure type used to build the transaction descriptive flexfield for project-related transaction distributions. | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_CONTEXT_CATEGORY | VARCHAR2 | 40 |  |  | Segment used to identify the descriptive flexfield application context for project-related standardized cost collection. | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_BILLABLE_FLAG | VARCHAR2 | 1 |  |  | Flag that indicates if a project-related item is available to be billed to customers. | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE1 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE2 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE3 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE4 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE5 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE6 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE7 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE8 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE9 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_USER_DEF_ATTRIBUTE10 | VARCHAR2 | 150 |  |  | Reserved for user-definable project information | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_CONTRACT_ID | NUMBER |  | 18 |  | Identifier of contract. This attribute is used when Oracle Contract Billing or Oracle Grants Accounting is installed. |  |
| PJC_WORK_TYPE_ID | NUMBER |  | 18 |  | Identifier for project-related classification of the worked performed. | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_CAPITALIZABLE_FLAG | VARCHAR2 | 1 |  |  | Flag that indicates if a project-related item is eligible for capitalization. | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE1 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE2 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE3 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE4 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE5 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE6 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE7 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE8 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE9 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_RESERVED_ATTRIBUTE10 | VARCHAR2 | 150 |  |  | Reserved for future project-related functionality | Project Costing Details (PROJECTS_STD_COST_COLLECTION) |
| PJC_FUNDING_ALLOCATION_ID | NUMBER |  | 18 |  | Specifies the name of the project funding override. This attribute is used when Oracle Contract Billing or Oracle Grants Accounting is installed |  |
| PJC_CONTRACT_LINE_ID | NUMBER |  | 18 |  | Tracks contract line information. This attribute is used when Oracle Contract Billing or Oracle Grants Accounting is installed. |  |
| ORIGINAL_DISTRIBUTION_ID | NUMBER |  | 18 |  | Holds the po_distribution_id of the distribution from which this shipment was copied/split over |  |
| DELIVER_TO_CUST_LOCATION_ID | NUMBER |  | 18 |  | The final location where goods will be delivered that were previously received from a supplier. |  |
| DELIVER_TO_CUST_ID | NUMBER |  | 18 |  | Customer to whom merchandise is being delivered. |  |
| DELIVER_TO_CUST_CONTACT_ID | NUMBER |  | 18 |  | Contact from the company where the good are being delivered. |  |
| SHIPPING_UOM_QTY_DELIVERED | NUMBER |  |  |  | Quantity in shipping unit of measure delivered against the distribution |  |
| SECONDARY_QUANTITY_DELIVERED | NUMBER |  |  |  | Quantity in secondary unit of measure delivered against the distribution |  |
| SHIPPING_UOM_QUANTITY | NUMBER |  |  |  | Quantity in shipping unit of measure |  |
| SHIPPING_UOM_QUANTITY_CANCELED | NUMBER |  |  |  | Quantity in shipping unit of measure canceled up until today |  |
