SELECT
    *
FROM
    [Brazilian E-Commerce].[dbo].[vw_sales_fact];

-- Calculate the total number of products sold, total number of customers, and average number of products sold per customer
SELECT
    count(order_item_id) AS Total_Products_Sold,
    count(DISTINCT customer_id) AS Total_Customers,
    cast(
        count(order_item_id) * 1.0 / count(DISTINCT customer_id) AS decimal(10, 2)
    ) AS Average_Products_Per_Customer
FROM
    [Brazilian E-Commerce].[dbo].[vw_sales_fact];

-- Calculate the total revenue, total number of orders, and average revenue per order
SELECT
    cast(SUM(total_item_value) AS decimal(10, 2)) AS Total_Revenue,
    count(DISTINCT order_id) AS Total_Orders,
    cast(
        SUM(total_item_value) * 1.0 / count(DISTINCT order_id) AS decimal(10, 2)
    ) AS Average_Revenue_Per_Order
FROM
    [Brazilian E-Commerce].[dbo].[vw_sales_fact];

-- Calculate the minimum, maximum, mean, and median price of products sold
WITH median_cte AS (
    SELECT
        DISTINCT PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY
                price
        ) OVER() AS Median_Price
    FROM
        [Brazilian E-Commerce].[dbo].[vw_sales_fact]
)
SELECT
    MIN(s.price) AS Min_Price,
    MAX(s.price) AS Max_Price,
    AVG(s.price) AS Mean_Price,
    m.Median_Price
FROM
    [Brazilian E-Commerce].[dbo].[vw_sales_fact] s
    CROSS JOIN median_cte m
GROUP BY
    m.Median_Price;

WITH MonthlySales AS (
    SELECT
        dateadd(
            MONTH,
            datediff(MONTH, 0, order_purchase_timestamp),
            0
        ) AS sales_MONTH,
        cast(SUM(total_item_value) AS decimal (10, 2)) AS Revenue
    FROM
        [Brazilian E-Commerce].[dbo].[vw_sales_fact]
    GROUP BY
        dateadd(
            MONTH,
            datediff(MONTH, 0, order_purchase_timestamp),
            0
        )
)
SELECT
    sales_MONTH,
    Revenue,
    isnull(
        LAG(Revenue, 12) OVER (
            ORDER BY
                sales_MONTH
        ),
        0
    ) AS Prev_year_rev,
    isnull(
        cast(
            (
                Revenue - LAG(Revenue, 12) OVER (
                    ORDER BY
                        sales_MONTH
                )
            ) * 100.0 / nullif(
                LAG(Revenue, 12) OVER (
                    ORDER BY
                        sales_MONTH
                ),
                0
            ) AS decimal(10, 2)
        ),
        0
    ) AS YoY_Growth_Percentage
FROM
    MonthlySales
WHERE
    sales_MONTH >= '2017-01-01';

-- Calculate the current month's revenue, the maximum revenue ever, the minimum revenue ever, and the percentage of revenue drop from the peak
WITH seasonal_sales AS (
    SELECT
        dateadd(
            MONTH,
            datediff(MONTH, 0, order_purchase_timestamp),
            0
        ) AS sales_MONTH,
        cast(SUM(total_item_value) AS decimal(18, 2)) AS Revenue
    FROM
        [Brazilian E-Commerce].[dbo].[vw_sales_fact]
    GROUP BY
        dateadd(
            MONTH,
            datediff(MONTH, 0, order_purchase_timestamp),
            0
        )
)
SELECT
    sales_MONTH,
    Revenue AS Current_Month_Revenue,
    MAX(Revenue) OVER () AS Max_Revenue_Ever,
    MIN(Revenue) OVER () AS Min_Revenue_Ever,
    CAST(
        (MAX(Revenue) OVER () - Revenue) * 100.0 / NULLIF(MAX(Revenue) OVER (), 0) AS DECIMAL(10, 2)
    ) AS Drop_From_Peak_Percentage
FROM
    seasonal_sales
ORDER BY
    sales_MONTH;

-- Average Delay of Delivery in Days
SELECT
    AVG(delivery_delay) AS Avg_Delay
FROM
    [Brazilian E-Commerce].[dbo].[vw_sales_fact];

-- Average Delay of Delivery in Days by Review Score
SELECT
    o.review_score AS Review_Score,
    ROUND(AVG(s.delivery_delay), 2) AS Avg_Delay_Time
FROM
    [Brazilian E-Commerce].[dbo].[vw_sales_fact] AS s
    LEFT JOIN [Brazilian E-Commerce].[dbo].[vw_reviews] AS o ON s.order_id = o.order_id
WHERE
    review_score IS NOT NULL
GROUP BY
    o.review_score
ORDER BY
    review_score ASC;

-- Core Bottlenecks by State
SELECT
    se.seller_state,
    c.customer_state,
    COUNT(order_item_id) AS Total_Products_Sold,
    ROUND(AVG(s.delivery_delay), 2) AS Avg_Delay
FROM
    [Brazilian E-Commerce].[dbo].[vw_sales_fact] AS s
    JOIN [Brazilian E-Commerce].[dbo].[vw_customers] AS c ON s.customer_id = c.customer_id
    JOIN [Brazilian E-Commerce].[dbo].[vw_sellers] AS se ON s.seller_id = se.seller_id
WHERE
    order_status = 'delivered'
    AND delivery_delay > 0
GROUP BY
    c.customer_state,
    se.seller_state
HAVING
    COUNT(order_item_id) > 10
ORDER BY
    avg_delay DESC,
    total_products_sold DESC;