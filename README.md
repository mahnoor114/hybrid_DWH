==================================================
STARFLAKE DATA WAREHOUSE PROJECT
==================================================

Project Overview:
-----------------
This project implements a **Starflake (Hybrid Star + Snowflake) Schema** in PostgreSQL
for transactional sales data. It simulates a real-world **data warehouse ETL pipeline**:

CSV → Staging Table → Dimension Tables → Fact Table

The hybrid schema combines:
- Star-style dimensions (dim_product, dim_date)
- Snowflake-style dimension (dim_customer linked to dim_customer_info)

It supports OLAP-style queries and analytics, making it ready for **BI dashboards**.

--------------------------------------------------
Dataset:
--------
Sample transactional CSV columns:
- orderID       : Transaction ID (Fact key)
- Customer_ID   : Customer reference
- Product_ID    : Product reference
- quantity      : Quantity purchased (measure)
- date          : Order date (to convert to date dimension)

Sample File: transactional_data_preprocessed.csv

--------------------------------------------------
Database Schema:
----------------

Staging Schema:
- staging.sales_staging: temporary table to load raw CSV data

Retail DW Schema:
- retail_dw.dim_customer_info   : Snowflake dimension (customer segment, region)
- retail_dw.dim_customer        : Links to dim_customer_info
- retail_dw.dim_product         : Star dimension (product)
- retail_dw.dim_date            : Star dimension (date)
- retail_dw.fact_sales          : Fact table storing transactions

Starflake Layout:
-----------------
           dim_customer
                |
                |
        dim_customer_info (snowflake)
                
dim_product --------------- fact_sales --------------- dim_date

--------------------------------------------------
ETL Pipeline:
-------------
1. Create staging schema and table, load CSV using COPY
2. Create retail_dw schema and dimension/fact tables
3. Populate dimension tables from staging:
   - dim_customer_info
   - dim_customer
   - dim_product
   - dim_date
4. Populate fact_sales table with joins to dimensions
5. Create indexes for performance
6. Create views for analytics

--------------------------------------------------
Views for Analytics:
--------------------
1. v_customer_sales     : total quantity per customer
2. v_product_sales      : total quantity per product
3. v_year_segment_sales : yearly sales by customer segment

Sample Queries:

-- Top 5 Customers by total quantity
SELECT * FROM retail_dw.v_customer_sales
ORDER BY total_quantity DESC
LIMIT 5;

-- Top 5 Products by total quantity sold
SELECT * FROM retail_dw.v_product_sales
ORDER BY total_quantity DESC
LIMIT 5;

-- Yearly sales by customer segment
SELECT * FROM retail_dw.v_year_segment_sales
ORDER BY year, customer_segment;

--------------------------------------------------
Indexing:
----------
- Fact table indexes:
  - fact_sales(customer_id)
  - fact_sales(product_id)
  - fact_sales(date_id)
- Dimension table indexes:
  - dim_customer_info(customer_segment)
  - dim_date(year, month)
  
Indexes improve  join and aggregation performance  on large datasets.

--------------------------------------------------
Features:
---------
- Demonstrates a hybrid Starflake schema
- Efficient ETL pipeline using staging
- Predefined views for analytics
- Ready for dashboards (Power BI / Tableau)

--------------------------------------------------
Future Improvements:
--------------------
- Add richer customer/product metadata for advanced analysis
- Use materialized views for faster reporting
- Automate ETL with Python or Airflow
- Include additional measures: revenue, discounts, promotions

--------------------------------------------------
Author:
-------
Mahnoor Haider
BS Data Science
==================================================
