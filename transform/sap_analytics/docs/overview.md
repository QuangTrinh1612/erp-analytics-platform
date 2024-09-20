{% docs __overview__ %}

# SAP SD Module - dbt Models Overview

## Project Overview
The SAP SD (Sales and Distribution) module manages sales processes, distribution, and billing in an organization. This dbt project focuses on modeling the sales data, ensuring that the data is organized, clean, and optimized for analytics. The models in this project cover various aspects of the SAP SD module such as sales orders, deliveries, and invoicing.

---

## Models Breakdown

### 1. **stg_sales_orders**
**Description:**  
This staging model extracts and cleans raw sales order data from the SAP system. The sales orders data typically includes details like order number, customer, products, and order dates.

**Source Tables:**  
- `VBAK` (Sales Document: Header Data)
- `VBAP` (Sales Document: Item Data)

**Key Columns:**
- `sales_order_number`
- `customer_id`
- `order_date`
- `product_id`
- `quantity`

**Transformation Summary:**  
- Data cleaning and type conversions
- Joining header and line-item data
- Filter on relevant date ranges

---

### 2. **stg_deliveries**
**Description:**  
This staging model deals with deliveries related to sales orders. It tracks shipping, delivery schedules, and delivery performance.

**Source Tables:**  
- `LIKP` (SD Document: Delivery Header Data)
- `LIPS` (SD Document: Delivery: Item Data)

**Key Columns:**
- `delivery_number`
- `sales_order_number`
- `delivery_date`
- `shipment_status`

**Transformation Summary:**  
- Joining delivery header and item data
- Calculating lead times between order and delivery

---

### 3. **stg_invoices**
**Description:**  
This model handles invoicing data. It collects information related to billing and payments for the sales orders.

**Source Tables:**  
- `VBRK` (Billing Document: Header Data)
- `VBRP` (Billing Document: Item Data)

**Key Columns:**
- `invoice_number`
- `sales_order_number`
- `invoice_date`
- `invoice_amount`

**Transformation Summary:**  
- Joining billing header and item data
- Currency conversion (if applicable)

---

### 4. **fact_sales**
**Description:**  
The fact table combines sales orders, deliveries, and invoicing data, forming a comprehensive view of the entire sales process.

**Source Models:**
- `stg_sales_orders`
- `stg_deliveries`
- `stg_invoices`

**Key Columns:**
- `sales_order_number`
- `customer_id`
- `product_id`
- `order_date`
- `delivery_date`
- `invoice_date`
- `total_sales_amount`

**Transformation Summary:**  
- Joining sales, delivery, and invoice models
- Aggregating data by sales order
- Calculating key metrics (e.g., total revenue, delivery performance)

---

### 5. **dim_customers**
**Description:**  
This dimension table contains details of customers associated with the sales orders.

**Source Tables:**  
- `KNA1` (Customer Master: General Data)
- `KNVV` (Customer Master: Sales Area Data)

**Key Columns:**
- `customer_id`
- `customer_name`
- `sales_area`
- `customer_type`

**Transformation Summary:**  
- Data cleaning
- Enriching customer data with sales area information

---

## Usage of Models
- **Fact Tables:** Used to analyze sales, delivery, and invoicing trends.
- **Dimension Tables:** Provide contextual information on customers, products, and regions.
- **Staging Tables:** Standardize raw SAP SD data for consistent downstream transformations.

---

## Performance Considerations
- **Indexing Key Columns:** Ensure important columns such as `sales_order_number` and `customer_id` are indexed for performance.
- **Incremental Models:** Consider using incremental models for large tables like sales orders and invoices to optimize dbt runs.

---

## Future Enhancements
- Integrating with other SAP modules like MM (Materials Management) or FI (Financial Accounting).
- Adding more derived metrics and KPIs, such as profit margin and customer lifetime value (CLV).

{% enddocs %}