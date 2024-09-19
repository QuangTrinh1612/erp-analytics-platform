<h1>
    <img
        src="..\..\asset\SAP\sap.png"
        alt="SAP SD - Data Model"
        height=50
    /> SAP Sales and Distribution (SD) Module - dbt Model Overview
</h1>

## Overview
The **Sales and Distribution (SD)** module in SAP is a comprehensive system that manages all aspects of sales order processing, from capturing customer orders to shipping products and billing the customers. This dbt model is designed to extract, transform, and load (ETL) relevant data from SAP SD, enabling businesses to analyze sales processes, monitor order statuses, and improve distribution channels.

## Business Concepts

1. **Sales Order Processing**: Central to the SD module, this process covers capturing customer orders, checking product availability, pricing, and generating documents like quotations and invoices.
  
2. **Pricing and Billing**: The system handles pricing configurations including discounts, surcharges, taxes, and processes related to billing and payments.

3. **Delivery and Shipment**: This concept involves managing the physical distribution of goods, tracking shipments, and ensuring products reach customers on time.

4. **Customer Master Data**: This contains all necessary information about customers, which influences order processing, billing, and pricing.
  
5. **Sales Analytics**: This allows businesses to assess their sales performance, revenue trends, and customer behavior by leveraging the dbt model for analytical reporting.

## Business Terms

- **Sales Order (SO)**: A document specifying details of goods or services a customer wants to purchase.
- **Delivery**: A physical shipment of goods to a customer.
- **Customer Master**: The data stored in SAP about each customer, including payment terms, addresses, and contact details.
- **Invoice**: A document issued after the delivery of goods that requests payment for the items sold.
- **Pricing Condition**: A set of rules and values in SAP that determines the final price for a product based on various factors.
- **Material Master**: Information about products or services managed by the company, used in SD processes.
  
## SAP SD - Data Model
### Data Mapping

<img
    src="..\..\asset\SAP\SAP Sale DM - ERD.png"
    alt="SAP SD - Data Model"
/>

### List of Tables

| Table Name                  | Description                                               |
|-----------------------------|-----------------------------------------------------------|
| **VBAK**                    | Sales Document: Header Data                               |
| **VBAP**                    | Sales Document: Item Data                                 |
| **LIKP**                    | Delivery Document: Header Data                            |
| **LIPS**                    | Delivery Document: Item Data                              |
| **KNA1**                    | General Customer Master Data                              |
| **KNVV**                    | Customer Sales Area Data                                  |
| **VBRK**                    | Billing Document: Header Data                             |
| **VBRP**                    | Billing Document: Item Data                               |
| **TVAK**                    | Sales Document Types                                      |
| **TVAP**                    | Sales Document: Item Categories                           |
| **MARA**                    | General Material Data                                     |
| **MVKE**                    | Sales Data for Materials                                  |