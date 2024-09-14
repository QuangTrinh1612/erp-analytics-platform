<h1>
    <img
        src="..\asset\logo.svg"
        alt="ERP Data Analytics logo"
        height=50
    />
    ERP Data Analytics Platform - DBT
</h1>

# Code Snippet
Running Debug Connections
```bash
dbt debug --profiles-dir config --project-dir transform/procurement_analytics
```

dbt Run commands
```bash
dbt run --profiles-dir config --project-dir transform/procurement_analytics
```

# dbt - Data Models
## Procurement Analytics
### f_purchase_order
#### Table Description
The `f_purchase_order` table is a fact table in the data warehouse designed to store information related to purchase orders from Oracle Fusion Procurement. It integrates data from both `PO_HEADERS_ALL` (header-level data) and `PO_LINES_ALL` (line-level data), providing a comprehensive view of purchase order transactions, including the items purchased, suppliers, prices, and quantities. This table enables detailed analysis of procurement activity, such as total purchase amounts, supplier performance, and procurement trends.
#### Key Facts:
- Purchase Order Information: Contains header-level details about the purchase order, such as the PO number, supplier, buyer, and order status.
- Line-Level Details: Includes line-level details like item description, unit price, and quantity.
- Financial Analysis: Enables financial analysis of procurement activities, such as total spending by supplier or item category.
- Time-Driven Analytics: Provides insights into procurement over time, including trends and order cycles through the order_date and line_creation_date.
#### Use Cases:
- Spend Analysis: Analyze spending across suppliers, items, and time periods.
- Supplier Performance: Evaluate supplier performance based on purchase orders and deliveries.
- Procurement Trends: Identify trends in procurement activities, such as frequently ordered items or peak procurement periods.
#### Metadata
| Column Name          | Data Type  | Description |
|----------------------|------------|-------------|
| `po_header_id`        | NUMBER     | Unique identifier for the purchase order header. |
| `po_number`           | VARCHAR2   | The purchase order number, a unique identifier for each purchase order. |
| `supplier_id`         | NUMBER     | The ID of the supplier associated with the purchase order. |
| `supplier_site_id`    | NUMBER     | The ID of the supplier site associated with the purchase order. |
| `buyer_id`            | NUMBER     | The ID of the buyer responsible for the purchase order. |
| `order_date`          | DATE       | The date when the purchase order was created. |
| `po_status`           | VARCHAR2   | The current status of the purchase order (e.g., Open, Closed, Cancelled). |
| `organization_id`     | NUMBER     | The ID of the organization or business unit responsible for the purchase order. |
| `po_line_id`          | NUMBER     | Unique identifier for each purchase order line. |
| `line_number`         | NUMBER     | The line number within the purchase order. |
| `item_id`             | NUMBER     | The ID of the item being purchased. |
| `item_description`    | VARCHAR2   | Description of the item being purchased. |
| `unit_price`          | NUMBER     | Price per unit of the item. |
| `quantity`            | NUMBER     | Quantity of the item being ordered. |
| `uom_code`            | VARCHAR2   | Unit of measure for the quantity (e.g., Each, Box). |
| `line_type_id`        | NUMBER     | Type of the line item (e.g., Goods, Services). |
| `line_total_amount`   | NUMBER     | Total amount for the line item (calculated as `unit_price * quantity`). |
| `line_creation_date`  | DATE       | The date when the purchase order line was created. |
| `last_update_date`    | DATE       | The date when the purchase order line was last updated. |