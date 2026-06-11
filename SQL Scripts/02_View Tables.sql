CREATE VIEW vw_products AS
SELECT
    p.product_id,
    pct.product_category_name_english AS product_category_name,
    p.product_name_length,
    p.product_description_length,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM
    stg_products_dataset AS p
    LEFT JOIN stg_category_name_translation AS pct ON p.product_category_name = pct.product_category_name;

CREATE VIEW vw_payments_fact AS
SELECT
    order_payment_id,
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM
    stg_orders_payments_dataset;

CREATE VIEW vw_customers AS
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM
    stg_customers_dataset;

CREATE VIEW vw_sellers AS
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM
    stg_sellers_dataset;

CREATE VIEW vw_reviews AS
SELECT
    review_id_key,
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM
    stg_order_reviews_dataset;

CREATE VIEW vw_sales_fact AS
SELECT
    i.order_item_id,
    i.order_id,
    i.product_id,
    i.seller_id,
    o.customer_id,
    i.price,
    i.freight_value,
    ROUND(i.price + i.freight_value, 2) AS total_item_value,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    CASE
        WHEN o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL THEN DATEDIFF(
            DAY,
            o.order_purchase_timestamp,
            o.order_delivered_customer_date
        )
        ELSE NULL
    END AS delivery_time,
    CASE
        WHEN o.order_status = 'delivered'
        AND o.order_delivered_customer_date > o.order_estimated_delivery_date THEN DATEDIFF(
            DAY,
            o.order_estimated_delivery_date,
            o.order_delivered_customer_date
        )
        ELSE 0
    END AS delivery_delay
FROM
    stg_order_items_dataset AS i
    INNER JOIN stg_orders_dataset AS o ON i.order_id = o.order_id;