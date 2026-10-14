# SQL Documentation

## Supply Chain Fulfillment & Delivery Performance Analytics

### 1. Overview

This folder documents the PostgreSQL analysis supporting the Supply Chain Fulfillment & Delivery Performance Analytics project.

The analysis uses the historical Olist Brazilian E-Commerce Public Dataset to examine order fulfillment, delivery reliability, operational bottlenecks, geographic service gaps, and freight costs.

### 2. Database Environment

- **Database:** PostgreSQL
- **Database name:** `olist_supply_chain`
- **Development tool:** pgAdmin
- **Visualization tool:** Tableau
- **Data source:** Olist Brazilian E-Commerce Public Dataset

### 3. Analytical Workflow

1. Import the nine source CSV datasets into PostgreSQL.
2. Examine relationships between orders, customers, payments, products, and order items.
3. Build reusable analytical views at the appropriate level of detail.
4. Validate order counts and prevent duplicate-order inflation.
5. Calculate fulfillment and delivery performance indicators.
6. Export an executive-level dataset for Tableau visualization.

### 4. Analytical Views

**`vw_order_performance`**

Supports order-level fulfillment and delivery performance analysis.

**`vw_executive_dashboard`**

Provides an order-level analytical dataset for the Tableau executive dashboard, with 99,441 records.

### 5. Key Performance Indicators

| Metric | Result |
|---|---:|
| Total Orders | 99,441 |
| Delivered Orders | 96,478 |
| Order Completion Rate | 97.02% |
| Evaluated Deliveries | 96,470 |
| On-Time Deliveries | 89,936 |
| Late Deliveries | 6,534 |
| On-Time Delivery Rate | 93.23% |
| Average Delay for Late Deliveries | 10.62 days |
| Total Freight Charges | R$2.25 million |
| Freight-to-Product Value Ratio | 16.57% |

### 6. Analytical Focus Areas

- Monthly on-time delivery performance
- Order fulfillment and delivery completion
- Approval-to-carrier processing time
- Carrier-to-customer transportation time
- State-level delivery performance
- Freight cost analysis

### 7. Data Quality and Interpretation

The analysis distinguishes total orders from delivered and evaluated orders. Delivery performance percentages use the relevant evaluated-order population rather than all historical orders.

State-level results should be interpreted alongside order volumes, especially where sample sizes are small.

Comparisons between fulfillment stages and delivery outcomes are descriptive and do not independently establish causation.

### 8. Repository Organization

The `sql` folder will contain documented SQL scripts for data validation, analytical views, KPI calculations, and supporting queries.

### 9. Data Usage

This is an independent portfolio project using historical public e-commerce data. It does not contain proprietary information from The Home Depot or any other employer.
