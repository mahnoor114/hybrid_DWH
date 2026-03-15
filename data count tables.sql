-- Count rows in staging
SELECT COUNT(*) AS staging_rows FROM staging.sales_staging;

-- Count rows in dimensions
SELECT COUNT(*) AS customer_info_rows FROM retail_dw.dim_customer_info;
SELECT COUNT(*) AS customer_rows FROM retail_dw.dim_customer;
SELECT COUNT(*) AS product_rows FROM retail_dw.dim_product;
SELECT COUNT(*) AS date_rows FROM retail_dw.dim_date;

-- Count rows in fact table
SELECT COUNT(*) AS fact_sales_rows FROM retail_dw.fact_sales;
