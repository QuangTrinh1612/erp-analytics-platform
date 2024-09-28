{% docs __overview__ %}

# Oracle ERP - dbt Models Overview

## Project Overview
This dbt project focuses on modeling data extracted from Oracle ERP, specifically covering areas like procurement, finance, and inventory management. The goal of this project is to create clean, consistent, and optimized models for analytics and reporting, sourced from Oracle tables.

---

## Finance Models Breakdown

### 1. **Source Tables**
- `AP_INVOICES_ALL`: Contains invoice headers.
- `AP_INVOICE_LINES_ALL`: Contains line-level details for each invoice.
- `AP_INVOICE_DISTRIBUTIONS_ALL`: Contains distribution details for the invoices. This will be represented as a JSON string.
- `AP_INVOICE_PAYMENTS_ALL`: Contains payment details associated with the invoices.
- `AR_PAYMENT_SCHEDULES_ALL`: Contains payment schedule information, including due dates and status.

## Procurement Models Breakdown

### 1. **stg_purchase_orders**
**Description:**  
This staging model captures and cleans raw purchase order data from Oracle ERP, representing the orders placed by the organization with suppliers.

**Source Tables:**  
- `PO_HEADERS_ALL` (Purchase Order Headers)
- `PO_LINES_ALL` (Purchase Order Lines)

**Key Columns:**
- `purchase_order_number`
- `supplier_id`
- `order_date`
- `product_id`
- `quantity`

**Transformation Summary:**  
- Cleaning and standardizing column formats
- Joining header and line-item data
- Filtering for active or recent purchase orders

---

### 2. **stg_requisitions**
**Description:**  
This model handles procurement requisition data, which tracks requests for materials or services that later result in purchase orders.

**Source Tables:**  
- `POR_REQUISITION_HEADERS_ALL` (Requisition Headers)
- `POR_REQUISITION_LINES_ALL` (Requisition Lines)

**Key Columns:**
- `requisition_number`
- `requested_by`
- `product_id`
- `quantity`
- `approval_status`

**Transformation Summary:**  
- Joining requisition header and line-item data
- Filtering by approval status (e.g., only approved requisitions)
- Creating calculated fields for lead time (days between requisition and order)

---

### 3. **stg_invoices**
**Description:**  
This staging model manages invoices related to procurement, capturing billing information for received goods or services.

**Source Tables:**  
- `AP_INVOICES_ALL` (Invoice Headers)
- `AP_INVOICE_LINES_ALL` (Invoice Lines)

**Key Columns:**
- `invoice_number`
- `supplier_id`
- `invoice_date`
- `invoice_amount`

**Transformation Summary:**  
- Joining invoice header and line-item data
- Performing currency conversion, if needed
- Filtering invalid or incomplete invoice records

---

### 4. **fact_procurement**
**Description:**  
The fact table combines data from purchase orders, requisitions, and invoices to create a comprehensive view of the procurement process.

**Source Models:**
- `stg_purchase_orders`
- `stg_requisitions`
- `stg_invoices`

**Key Columns:**
- `purchase_order_number`
- `requisition_number`
- `supplier_id`
- `product_id`
- `order_date`
- `invoice_date`
- `total_invoice_amount`

**Transformation Summary:**  
- Joining relevant staging models
- Aggregating data by purchase order and requisition
- Calculating procurement KPIs, such as total spend, order-to-invoice lead times

---

### 5. **dim_suppliers**
**Description:**  
This dimension model provides details about suppliers, including supplier classification and geographic information.

**Source Tables:**  
- `PO_VENDORS` (Suppliers)
- `PO_VENDOR_SITES_ALL` (Supplier Sites)

**Key Columns:**
- `supplier_id`
- `supplier_name`
- `country`
- `supplier_category`

**Transformation Summary:**  
- Data cleaning and standardization
- Enriching supplier data with location details and category

---

### 6. **dim_products**
**Description:**  
This dimension model contains product-related data, describing the items procured by the organization.

**Source Tables:**  
- `MTL_SYSTEM_ITEMS_B` (Inventory Items)
- `MTL_CATEGORIES_B` (Item Categories)

**Key Columns:**
- `product_id`
- `product_name`
- `category_id`
- `unit_of_measure`

**Transformation Summary:**  
- Joining item data with category information
- Standardizing product names and UOMs for consistent reporting

---

## Usage of Models
- **Fact Tables:** Track procurement activities from requisitions to invoicing, providing insights into procurement performance.
- **Dimension Tables:** Provide descriptive context for key entities like suppliers and products, enhancing reporting granularity.
- **Staging Tables:** Serve as cleaned, normalized layers for transforming raw Oracle ERP data into consumable models.

---

## Performance Considerations
- **Incremental Models:** Use incremental loading for large transactional tables like purchase orders and invoices to reduce run times.
- **Optimized Joins:** Ensure efficient joins between header and line-item tables by leveraging database keys and indexes.
- **Partitioning Large Tables:** Consider partitioning large source tables by date or supplier for improved query performance.

---

## Future Enhancements
- Incorporate data from additional Oracle ERP modules like Finance or HR.
- Develop more granular KPIs and dashboards, such as supplier performance metrics and procurement cycle time analyses.

{% enddocs %}