# Oracle Fusion Mart Documentation

## Overview
This document provides an overview of the Oracle Fusion data mart designed for business intelligence and analytics. It outlines the key tables, columns, business logic, and common use cases to help business intelligence analysts understand and utilize the data effectively.

## Table of Contents
1. [Introduction](#introduction)
2. [Data Model](#data-model)
   - [Fact Tables](#fact-tables)
   - [Dimension Tables](#dimension-tables)
3. [Fact Table Descriptions](#fact-table-descriptions)
   - [fact_ar_line_item](#fact_ar_line_item)
   - [fact_purchase_request](#fact_purchase_request)
4. [Dimension Table Descriptions](#dimension-table-descriptions)
   - [dim_customer](#dim_customer)
   - [dim_product](#dim_product)
5. [Data Lineage](#data-lineage)
6. [Query Optimization](#query-optimization)
7. [Common Use Cases](#common-use-cases)
8. [Data Refresh Schedule](#data-refresh-schedule)
9. [Contact Information](#contact-information)

## Introduction
The Oracle Fusion Mart provides a centralized repository for transactional and master data from Oracle Fusion applications. This mart is designed to support reporting and analytics needs, enabling business intelligence analysts to extract insights and create dashboards.

## Data Model
The data model consists of several fact and dimension tables that capture various aspects of business operations.

### Fact Tables
Fact tables contain the quantitative data for analysis. They are usually linked to dimension tables through foreign keys.

- `fact_ar_line_item`: Accounts receivable line items, including transaction details and GL distributions.
- `fact_purchase_request`: Purchase request details, including header and line item information.

### Dimension Tables
Dimension tables contain descriptive attributes related to the facts.

- `dim_customer`: Information about customers.
- `dim_product`: Information about products.

## Fact Table Descriptions

### `fact_ar_line_item`
This table contains line item details for accounts receivable transactions, integrating information from the following source tables:
- **Source Tables**:
  - `RA_CUSTOMER_TRX_ALL`: Transaction headers.
  - `RA_CUSTOMER_TRX_LINES_ALL`: Transaction line details.
  - `RA_CUST_TRX_LINE_GL_DIST_ALL`: GL distribution details stored as a JSON string.

#### Columns:
- `customer_trx_id`: Unique identifier for the transaction.
- `line_id`: Unique identifier for the transaction line.
- `trx_number`: Transaction number.
- `trx_date`: Date of the transaction.
- `line_description`: Description of the line item.
- `line_amount`: Amount of the line item.
- `distribution_items`: JSON string containing GL distribution details:
    ```json
    [
      {
        "cust_trx_line_gl_dist_id": "12345",
        "code_combination_id": "67890",
        "account_class": "REVENUE",
        "gl_date": "2023-08-01",
        "gl_posted_date": "2023-08-05",
        "amount": 100.00,
        "percent": 100.00
      }
    ]
    ```

#### Key Metrics:
- **Total Line Amount**: Sum of `line_amount` for the given period or filters.
- **GL Distribution Amount**: Total amount distributed based on the JSON details.

### `fact_purchase_request`
This table captures details about purchase requests, including headers and line items.

#### Columns:
- `request_id`: Unique identifier for the purchase request.
- `request_date`: Date of the purchase request.
- `status`: Current status of the request.
- `total_amount`: Total amount requested.

#### Key Metrics:
- **Total Requested Amount**: Aggregated sum of `total_amount`.
- **Approved Requests**: Count of requests with status 'Approved'.

## Dimension Table Descriptions

### `dim_customer`
Stores detailed information about customers.

#### Columns:
- `customer_id`: Unique identifier for the customer.
- `customer_name`: Full name of the customer.
- `customer_type`: Type of customer (e.g., Individual, Corporate).
- `region`: Geographic region of the customer.

### `dim_product`
Contains information about products offered.

#### Columns:
- `product_id`: Unique identifier for the product.
- `product_name`: Name of the product.
- `product_category`: Category of the product (e.g., Electronics, Apparel).
- `price`: Price of the product.

## Data Lineage
This section provides a high-level view of data flow from source systems to the final tables in the mart.

1. **Source Systems**: Data is extracted from Oracle Fusion application tables.
2. **Staging Area**: Data is cleaned and staged for transformation.
3. **Transformation**: Data is transformed according to business rules and loaded into fact and dimension tables.
4. **Data Mart**: Final tables are available for reporting and analysis.

## Query Optimization
### Distribution Items
#### Function schema_of_json
Use function `schema_of_json` to find out the schema of the JSON string. It is very useful to save time to find out schema for a JSON column in your Spark DataFrame.

Example:
``` sql
SELECT
  schema_of_json(
    '[
      {"Attr_INT":1, "ATTR_DOUBLE":10.201, "ATTR_DATE": "2021-01-01"},
      {"Attr_INT":1, "ATTR_DOUBLE":10.201, "ATTR_DATE": "2021-02-01"}
    ]'
  );
```
Output:
``` bash
array<struct<ATTR_DATE:string,ATTR_DOUBLE:double,Attr_INT:bigint>>
```

#### JSON array
The following code snippet parse a JSON array string using Spark SQL functions:

Example:
``` sql
SELECT
  from_json(
    '[
      {"Attr_INT":1, "ATTR_DOUBLE":10.201, "ATTR_DATE": "2021-01-01"},
      {"Attr_INT":1, "ATTR_DOUBLE":10.201, "ATTR_DATE": "2021-02-01"}
    ]',
    'array<struct<ATTR_DATE:string,ATTR_DOUBLE:double,Attr_INT:bigint>>'
  );
```
Output:
``` bash
[
  {"ATTR_DATE":"2021-01-01","ATTR_DOUBLE":10.201,"Attr_INT":1},
  {"ATTR_DATE":"2021-02-01","ATTR_DOUBLE":10.201,"Attr_INT":1}
]
```

#### Explode JSON array
In the above example, each column is an array type. We can explode the array of map first to flat the result.

Example:

```sql
SELECT
  r1.col.Attr_INT,
  r1.col.ATTR_DATE,
  r1.col.ATTR_DOUBLE
FROM (
  SELECT
    explode(r.json) AS col
  FROM (
    SELECT
      from_json(
        '[
          {"Attr_INT":1, "ATTR_DOUBLE":10.201, "ATTR_DATE": "2021-01-01"},
          {"Attr_INT":1, "ATTR_DOUBLE":10.201, "ATTR_DATE": "2021-02-01"}
        ]',
        'array<struct<ATTR_DATE:string,ATTR_DOUBLE:double,Attr_INT:bigint>>'
      ) AS json
  ) r
) AS r1;
```

Output:

```bash
Attr_INT        ATTR_DATE       ATTR_DOUBLE
1               2021-01-01      10.201
1               2021-02-01      10.201
```

## Common Use Cases
- **Sales Performance Analysis**: Use `fact_ar_line_item` and `dim_product` to analyze sales performance by product and customer.
- **Expense Tracking**: Use `fact_purchase_request` and `dim_customer` to track expenses and approval statuses.

## Data Refresh Schedule
The data mart is refreshed daily at 2:00 AM UTC. Any changes to the source systems are reflected in the data mart after this time.

## Contact Information
For any questions or support regarding the Oracle Fusion Mart, please contact:

- **Data Warehouse Team**: [datawarehouse@example.com](mailto:datawarehouse@example.com)
- **BI Support**: [bisupport@example.com](mailto:bisupport@example.com)