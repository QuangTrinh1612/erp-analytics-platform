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