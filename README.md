# Olist-End-to-end-SQL-Analysis
An end-to-end e-commerce analytics pipeline using SQL Server (T-SQL) &amp; Power BI. Features staging data cleaning, Star Schema warehouse design, advanced analytical querying (CTEs &amp; Window Functions), and automated logistics tracking.
# 📊 E-Commerce Sales & Logistics Analytics Portfolio
> **End-to-End Data Engineering & Analytics Project using SQL Server & Power BI**

## 📌 Project Overview
This project focuses on transforming raw operational data from an e-commerce platform (Olist Dataset) into clean, structured database views and high-impact business insights. The pipeline covers data cleaning and staging, data warehousing design using a Star Schema, advanced analytical SQL querying, and an interactive Power BI executive dashboard.

---

## 🛠️ Tech Stack & Skills Demonstrated
* **Database Engine:** SQL Server (T-SQL)
* **Data Architecture:** Staging Layer, Star Schema Model, Fact-to-Fact Relationships
* **Advanced SQL:** Window Functions (`DENSE_RANK`, `LEAD/LAG`), CTEs, Aggregations, Percentiles (`PERCENTILE_CONT`), and Date Analytics (`DATEDIFF`)
* **Data Visualization:** Power BI (Custom Map Geocoding Lookup via M Code, Dashboard UI/UX Design)

---

## 📐 Data Warehouse Architecture (Star Schema)
To optimize analytical query performance and prevent data redundancy, the staging tables were denormalized into a specialized Star Schema model. 

* **Fact Table:** `vw_sales_fact` (Centralizes orders, items, prices, and shipping logistics metrics).
* **Sub-Fact Tables:** `vw_payments_fact`, `vw_reviews` (Maintained separately to handle one-to-many transaction granularity without inflating sales figures).
* **Dimension Tables:** `vw_customers`, `vw_products`, `vw_sellers`, `Date`.

### Database Diagram (DBML)
```dbml
Table vw_customers {
  customer_id string [pk]
  customer_city string
  customer_state string
}

Table vw_products {
  product_id string [pk]
  product_category_name string
  product_weight_g float
}

Table vw_sellers {
  seller_id string [pk]
  seller_state string
}

Table vw_sales_fact {
  order_item_id string [pk]
  order_id string
  product_id string
  seller_id string
  customer_id string
  price float
  freight_value float
  total_item_value float
  order_status string
  order_purchase_timestamp datetime
  delivery_time int
  delivery_delay int
}

Ref: vw_customers.customer_id < vw_sales_fact.customer_id
Ref: vw_products.product_id < vw_sales_fact.product_id
Ref: vw_sellers.seller_id < vw_sales_fact.seller_id

## 🚀 Key Implementation Steps

### 1. Data Staging & Preprocessing

* **Handling Missing Data:** Enforced structural data integrity using conditional `COALESCE` statements to dynamically handle missing categorical entries in product attributes and locations.
* **Geospatial Optimization:** Generated localized geographic centroids using coordinate averaging (`AVG`) grouped by zip code prefix to dramatically accelerate geospatial mapping processing times in the BI layer.
* **Consistency Control:** Implemented unique constraints and surrogate keys utilizing `IDENTITY(1,1)` to guarantee staging data synchronization and consistency.

### 2. Business Logic Enrichment (SQL Views)

* **Logistics Performance Tracking:** Engineered robust `CASE WHEN` conditional logic integrated with `DATEDIFF` inside the fact views to continuously evaluate delivery durations and spot customer promise delays in days.
* **Geocoding Fix via Power Query M Code:** Built an advanced lookup dictionary utilizing `Record.FieldOrDefault` in M-Language to seamlessly substitute 2-character Brazilian state abbreviations with full state names, completely eliminating rendering errors on Bing Maps.

### 3. Business Intelligence Dashboard

* **Executive-Ready Interface:** Designed a comprehensive, dark-themed corporate dashboard focusing on interactive cross-filtering.
* **Tracked Metrics:** Delivers high-impact tracking for Core Revenue Trends, Top-Selling Product Categories, Customer Satisfaction (Review Scores), Logistical Latency (Fulfillment Bottlenecks), and Consumer Payment Method Distributions.
