-- create staging tables and insert data from the original tables 
CREATE TABLE stg_geolocation_dataset (
    geolocation_key INT identity(1, 1) PRIMARY KEY,
    geolocation_zip_code_prefix varchar(255),
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(255)
);

INSERT INTO
    stg_geolocation_dataset (
        geolocation_zip_code_prefix,
        geolocation_lat,
        geolocation_lng,
        geolocation_city,
        geolocation_state
    )
SELECT
    geolocation_zip_code_prefix,
    avg(geolocation_lat) AS geolocation_lat,
    avg(geolocation_lng) AS geolocation_lng,
    max(geolocation_city) AS geolocation_city,
    max(geolocation_state) AS geolocation_state
FROM
    [Brazilian E-Commerce].[dbo].[olist_geolocation_dataset]
GROUP BY
    geolocation_zip_code_prefix;

CREATE TABLE stg_orders_dataset (
    order_id VARCHAR(255) PRIMARY KEY,
    customer_id VARCHAR(255),
    order_status VARCHAR(255),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

INSERT INTO
    stg_orders_dataset (
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date
    )
SELECT
    DISTINCT order_id,
    customer_id,
    coalesce(order_status, 'unknown') AS order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM
    [Brazilian E-Commerce].[dbo].[olist_orders_dataset];

CREATE TABLE stg_order_items_dataset (
    order_item_id INT identity(1, 1) PRIMARY KEY,
    order_id VARCHAR(255),
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date DATETIME,
    price FLOAT,
    freight_value FLOAT
);

INSERT INTO
    stg_order_items_dataset (
        order_id,
        product_id,
        seller_id,
        shipping_limit_date,
        price,
        freight_value
    )
SELECT
    DISTINCT order_id,
    product_id,
    seller_id,
    shipping_limit_date,
    coalesce(price, 0) AS price,
    coalesce(freight_value, 0) AS freight_value
FROM
    [Brazilian E-Commerce].[dbo].[olist_order_items_dataset];

CREATE TABLE stg_customers_dataset (
    customer_id VARCHAR(255) PRIMARY KEY,
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix VARCHAR(255),
    customer_city VARCHAR(255),
    customer_state VARCHAR(255)
);

INSERT INTO
    stg_customers_dataset (
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    )
SELECT
    DISTINCT customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    coalesce(customer_city, 'unknown') AS customer_city,
    coalesce(customer_state, 'unknown') AS customer_state
FROM
    [Brazilian E-Commerce].[dbo].[olist_customers_dataset];

CREATE TABLE stg_orders_payments_dataset (
    order_payment_id INT identity(1, 1) PRIMARY KEY,
    order_id VARCHAR(255),
    payment_sequential INT,
    payment_type VARCHAR(255),
    payment_installments INT,
    payment_value FLOAT
);

INSERT INTO
    stg_orders_payments_dataset (
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        payment_value
    )
SELECT
    DISTINCT order_id,
    payment_sequential,
    coalesce(payment_type, 'unknown') AS payment_type,
    coalesce(payment_installments, 0) AS payment_installments,
    coalesce(payment_value, 0) AS payment_value
FROM
    [Brazilian E-Commerce].[dbo].[olist_order_payments_dataset];

CREATE TABLE stg_order_reviews_dataset (
    review_id_key INT identity(1, 1) PRIMARY KEY,
    review_id VARCHAR(255),
    order_id VARCHAR(255),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message VARCHAR(255),
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

INSERT INTO
    stg_order_reviews_dataset (
        review_id,
        order_id,
        review_score,
        review_comment_title,
        review_comment_message,
        review_creation_date,
        review_answer_timestamp
    )
SELECT
    DISTINCT review_id,
    order_id,
    coalesce(review_score, 0) AS review_score,
    coalesce(review_comment_title, 'unknown') AS review_comment_title,
    coalesce(review_comment_message, 'unknown') AS review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM
    [Brazilian E-Commerce].[dbo].[olist_order_reviews_dataset];

CREATE TABLE stg_products_dataset (
    product_id VARCHAR(255) PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT
);

INSERT INTO
    stg_products_dataset (
        product_id,
        product_category_name,
        product_name_length,
        product_description_length,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
    )
SELECT
    DISTINCT product_id,
    coalesce(product_category_name, 'unknown') AS product_category_name,
    coalesce(product_name_lenght, 0) AS product_name_length,
    coalesce(product_description_lenght, 0) AS product_description_length,
    coalesce(product_photos_qty, 0) AS product_photos_qty,
    coalesce(product_weight_g, 0) AS product_weight_g,
    coalesce(product_length_cm, 0) AS product_length_cm,
    coalesce(product_height_cm, 0) AS product_height_cm,
    coalesce(product_width_cm, 0) AS product_width_cm
FROM
    [Brazilian E-Commerce].[dbo].[olist_products_dataset];

CREATE TABLE stg_sellers_dataset (
    seller_id VARCHAR(255) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(255),
    seller_city VARCHAR(255),
    seller_state VARCHAR(255)
);

INSERT INTO
    stg_sellers_dataset (
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state
    )
SELECT
    DISTINCT seller_id,
    seller_zip_code_prefix,
    coalesce(seller_city, 'unknown') AS seller_city,
    coalesce(seller_state, 'unknown') AS seller_state
FROM
    [Brazilian E-Commerce].[dbo].[olist_sellers_dataset];

CREATE TABLE stg_category_name_translation (
    product_category_name_key INT identity(1, 1) PRIMARY KEY,
    product_category_name varchar(255),
    product_category_name_english varchar(255)
);

INSERT INTO
    stg_category_name_translation (
        product_category_name,
        product_category_name_english
    )
SELECT
    DISTINCT column1 AS product_category_name,
    coalesce(column2, 'unknown') AS product_category_name_english
FROM
    [Brazilian E-Commerce].[dbo].[product_category_name_translation];