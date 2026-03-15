SELECT 
    c.customer_id,
    ci.customer_segment,
    SUM(f.quantity) AS total_quantity
FROM retail_dw.fact_sales f
JOIN retail_dw.dim_customer c
    ON f.customer_id = c.customer_id
JOIN retail_dw.dim_customer_info ci
    ON c.info_id = ci.customer_id
GROUP BY c.customer_id, ci.customer_segment
ORDER BY total_quantity DESC
LIMIT 10;


SELECT 
    p.product_id,
    SUM(f.quantity) AS total_quantity
FROM retail_dw.fact_sales f
JOIN retail_dw.dim_product p
    ON f.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_quantity DESC
LIMIT 10;


SELECT 
    d.year,
    SUM(f.quantity) AS total_quantity
FROM retail_dw.fact_sales f
JOIN retail_dw.dim_date d
    ON f.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;


SELECT 
    c.customer_id,
    p.product_id,
    SUM(f.quantity) AS total_quantity
FROM retail_dw.fact_sales f
JOIN retail_dw.dim_customer c
    ON f.customer_id = c.customer_id
JOIN retail_dw.dim_product p
    ON f.product_id = p.product_id
GROUP BY c.customer_id, p.product_id
ORDER BY c.customer_id, total_quantity DESC;



SELECT 
    c.customer_id,
    ci.customer_segment,
    ci.customer_region
FROM retail_dw.dim_customer c
JOIN retail_dw.dim_customer_info ci
    ON c.info_id = ci.customer_id
LIMIT 10;


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

