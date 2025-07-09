-- vw_sales – Combine orders, items, price, freight, and computed profit
CREATE VIEW vw_sales AS
SELECT 
    o.order_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    p.product_category_name,
    pt.product_category_name_english,
    o.order_purchase_timestamp,
    oi.price,
    oi.freight_value,
    (oi.price - oi.freight_value) AS profit -- assumed logic

FROM olist_order_items_dataset as oi
JOIN 
   olist_orders_dataset as o ON o.order_id = oi.order_id
JOIN 
    olist_products_dataset as p ON p.product_id = oi.product_id
LEFT JOIN 
    product_category_name_translation as pt ON p.product_category_name = pt.product_category_name;





--  vw_returns – Flag returned orders (using review_score = 1 or status = 'canceled')

CREATE VIEW vw_returns AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
    r.review_score,
    CASE 
        WHEN o.order_status = 'canceled' OR r.review_score IN (1, 2) THEN 1 
        ELSE 0 
    END AS is_returned
FROM 
    olist_orders_dataset o
LEFT JOIN 
    olist_order_reviews_dataset r ON o.order_id = r.order_id;





-- vw_customer_segmentation – Simulate customer segments
CREATE VIEW vw_customer_segmentation AS
WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        c.customer_id,
        c.customer_city,
        c.customer_state,
        o.order_id,
        o.order_purchase_timestamp
    FROM 
        olist_customers_dataset c
    JOIN 
        olist_orders_dataset o ON c.customer_id = o.customer_id
),
customer_latest_id AS (
    SELECT
        customer_unique_id,
        customer_id,
        ROW_NUMBER() OVER (
            PARTITION BY customer_unique_id 
            ORDER BY order_purchase_timestamp DESC
        ) AS rn
    FROM 
        customer_orders
),
customer_order_summary AS (
    SELECT 
        customer_unique_id,
        COUNT(DISTINCT order_id) AS total_orders,
        MAX(customer_city) AS customer_city,
        MAX(customer_state) AS customer_state
    FROM 
        customer_orders
    GROUP BY 
        customer_unique_id
),
final_segmentation AS (
    SELECT 
        s.customer_unique_id,
        l.customer_id,
        s.customer_city,
        s.customer_state,
        s.total_orders,
        CASE 
            WHEN s.total_orders > 5 THEN 'Corporate'
            WHEN s.total_orders BETWEEN 2 AND 5 THEN 'Small Business'
            ELSE 'Consumer'
        END AS customer_segment
    FROM 
        customer_order_summary s
    JOIN 
        customer_latest_id l 
        ON s.customer_unique_id = l.customer_unique_id AND l.rn = 1
)
SELECT * FROM final_segmentation;


--vw_order_monthly – Extract time features for time-series analysis

CREATE VIEW vw_order_monthly AS
SELECT 
    order_id,
    customer_id,
    order_purchase_timestamp,
    DATENAME(month, order_purchase_timestamp) AS order_month,
    YEAR(order_purchase_timestamp) AS order_year,
    DATEPART(quarter, order_purchase_timestamp) AS order_quarter
FROM 
    olist_orders_dataset;
