CREATE OR REPLACE VIEW retail_dw.v_customer_sales AS
SELECT 
    c.customer_id,
    ci.customer_segment,
    SUM(f.quantity) AS total_quantity
FROM retail_dw.fact_sales f
JOIN retail_dw.dim_customer c
    ON f.customer_id = c.customer_id
JOIN retail_dw.dim_customer_info ci
    ON c.info_id = ci.customer_id
GROUP BY c.customer_id, ci.customer_segment;

SELECT * FROM retail_dw.v_customer_sales
ORDER BY total_quantity DESC
LIMIT 10;

--2 
CREATE OR REPLACE VIEW retail_dw.v_product_sales AS
SELECT 
    p.product_id,
    SUM(f.quantity) AS total_quantity
FROM retail_dw.fact_sales f
JOIN retail_dw.dim_product p
    ON f.product_id = p.product_id
GROUP BY p.product_id;


SELECT * FROM retail_dw.v_product_sales
ORDER BY total_quantity DESC
LIMIT 10;


--3
CREATE OR REPLACE VIEW retail_dw.v_year_segment_sales AS
SELECT 
    d.year,
    ci.customer_segment,
    SUM(f.quantity) AS total_quantity
FROM retail_dw.fact_sales f
JOIN retail_dw.dim_date d
    ON f.date_id = d.date_id
JOIN retail_dw.dim_customer c
    ON f.customer_id = c.customer_id
JOIN retail_dw.dim_customer_info ci
    ON c.info_id = ci.customer_id
GROUP BY d.year, ci.customer_segment
ORDER BY d.year, ci.customer_segment;


