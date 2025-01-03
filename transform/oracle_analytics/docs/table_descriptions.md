{% docs f_purchase_request %}

## Key Tables:
- `POR_REQUISITION_HEADERS_ALL`: Stores header-level requisition information.
- `POR_REQUISITION_LINES_ALL`: Contains line-level details of requisitions.
- `POR_REQ_DISTRIBUTIONS_ALL`: Holds distribution data for each requisition line.

## Key Features:
- **Header Information**: Includes details such as requisition number, status, and preparer.
- **Line Information**: Contains item details like item description, price, and quantity.
- **Distribution Data**: The distribution details for each requisition line are stored as a JSON string in the distribution_data column. This data includes fields like distribution ID, charge account, and distribution amount.

{% enddocs %}

{% docs f_purchase_order %}

## Table Description:
The `f_purchase_order` table is a fact table in the data warehouse designed to store information related to purchase orders from Oracle Fusion Procurement. It integrates data from both `PO_HEADERS_ALL` (header-level data) and `PO_LINES_ALL` (line-level data), providing a comprehensive view of purchase order transactions, including the items purchased, suppliers, prices, and quantities. This table enables detailed analysis of procurement activity, such as total purchase amounts, supplier performance, and procurement trends.

## Key Facts:
- **Purchase Order Information**: Contains header-level details about the purchase order, such as the PO number, supplier, buyer, and order status.
- **Line-Level Details**: Includes line-level details like item description, unit price, and quantity.
- **Financial Analysis**: Enables financial analysis of procurement activities, such as total spending by supplier or item category.
- **Time-Driven Analytics**: Provides insights into procurement over time, including trends and order cycles through the order_date and line_creation_date.

## Use Cases:
- **Spend Analysis**: Analyze spending across suppliers, items, and time periods.
- **Supplier Performance**: Evaluate supplier performance based on purchase orders and deliveries.
- **Procurement Trends**: Identify trends in procurement activities, such as frequently ordered items or peak procurement periods.

{% enddocs %}

{% docs f_ar_line_item %}
The 'f_ar_line_item' model is a comprehensive representation of
Accounts Receivable (AR) line items. It is derived from multiple sources
including customer transaction lines, headers, and distributions. The
model includes a wide range of fields capturing various aspects of AR
transactions such as transaction IDs, numbers, dates, classes, document
types, currency codes, exchange rates, flags for prepayment, unpaid and
on-hold status, total amounts, customer IDs, site IDs, line numbers,
types, descriptions, quantities ordered, credited, invoiced, unit prices,
sales order details, inventory item IDs, credit memo IDs, revenue amounts,
remaining due amounts, tax rates, unit of measure codes, last update
dates, and distribution items. The model also includes a unique identifier
for each AR line item and a timestamp indicating the time of data
ingestion. This model is particularly useful for financial analysis,
reporting, and auditing purposes.
{% enddocs %}