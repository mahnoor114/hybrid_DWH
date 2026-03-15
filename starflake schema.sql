CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.sales_staging (
    orderID BIGINT,
    customer_id BIGINT,
    product_id VARCHAR(20),
    quantity INT,
    order_date DATE
);

COPY staging.sales_staging(orderID, customer_id, product_id, quantity, order_date)
FROM  'C:\dwh project\transactional_data_preprocessed.csv' 
DELIMITER ','
CSV HEADER;


CREATE SCHEMA IF NOT EXISTS retail_dw;


CREATE TABLE retail_dw.dim_customer_info (
    customer_id BIGINT PRIMARY KEY,
    customer_segment VARCHAR(50) DEFAULT 'General',
    customer_region VARCHAR(50) DEFAULT 'Unknown'
);



CREATE TABLE retail_dw.dim_customer (
    customer_id BIGINT PRIMARY KEY,
    info_id BIGINT,
    FOREIGN KEY (info_id) REFERENCES retail_dw.dim_customer_info(customer_id)
);


CREATE TABLE retail_dw.dim_product (
    product_id VARCHAR(20) PRIMARY KEY
);

CREATE TABLE retail_dw.dim_date (
    date_id SERIAL PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    month INT,
    day INT
);


CREATE TABLE retail_dw.fact_sales (
    order_id BIGINT,
    customer_id BIGINT,
    product_id VARCHAR(20),
    date_id INT,
    quantity INT,
    
    FOREIGN KEY (customer_id) REFERENCES retail_dw.dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES retail_dw.dim_product(product_id),
    FOREIGN KEY (date_id) REFERENCES retail_dw.dim_date(date_id)
);


-- loading data 

INSERT INTO retail_dw.dim_customer_info (customer_id)
SELECT DISTINCT customer_id
FROM staging.sales_staging;


INSERT INTO retail_dw.dim_customer (customer_id, info_id)
SELECT customer_id, customer_id
FROM retail_dw.dim_customer_info;


INSERT INTO retail_dw.dim_product (product_id)
SELECT DISTINCT product_id
FROM staging.sales_staging;


INSERT INTO retail_dw.dim_date (full_date, year, month, day)
SELECT DISTINCT
    order_date,
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date),
    EXTRACT(DAY FROM order_date)
FROM staging.sales_staging;


--loading into fact table 
INSERT INTO retail_dw.fact_sales (order_id, customer_id, product_id, date_id, quantity)
SELECT
    s.orderID,
    s.customer_id,
    s.product_id,
    d.date_id,
    s.quantity
FROM staging.sales_staging s
JOIN retail_dw.dim_date d
ON s.order_date = d.full_date;
