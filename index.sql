-- Index on Customer_ID for fast join with dim_customer
CREATE INDEX idx_fact_customer
ON retail_dw.fact_sales (customer_id);

-- Index on Product_ID for fast join with dim_product
CREATE INDEX idx_fact_product
ON retail_dw.fact_sales (product_id);

-- Index on Date_ID for fast join with dim_date
CREATE INDEX idx_fact_date
ON retail_dw.fact_sales (date_id);


-- Index on customer info segment (optional if often queried)
CREATE INDEX idx_customer_segment
ON retail_dw.dim_customer_info (customer_segment);

-- Index on product_id (redundant for PK but can help in big joins)
CREATE INDEX idx_product_id
ON retail_dw.dim_product (product_id);

-- Index on year/month in date dimension for time-based queries
CREATE INDEX idx_date_year_month
ON retail_dw.dim_date (year, month);


CREATE INDEX idx_fact_year_segment
ON retail_dw.fact_sales (date_id, customer_id);


SELECT *
FROM retail_dw.v_product_sales
ORDER BY total_quantity DESC
LIMIT 5;


SELECT *
FROM retail_dw.v_year_segment_sales
ORDER BY year, customer_segment;


SELECT *
FROM retail_dw.v_year_segment_sales
ORDER BY year, customer_segment;
