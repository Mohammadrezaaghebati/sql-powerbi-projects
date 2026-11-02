-- تحلیل خرید مشتری

WITH CustomerOrderHistory AS (
    SELECT 
        customer_id,
        username,
        first_name + N' ' + last_name AS full_name,
        order_id,
        order_date,
        order_quantity,
        (order_amount_rial - discount_amount_rial) AS net_order_value_rial,
        
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY order_date ASC
        ) AS customer_order_seq,
        
        LAG(order_date) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date ASC
        ) AS previous_order_date,
        
        LAG(order_amount_rial - discount_amount_rial) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date ASC
        ) AS previous_order_value_rial,

        MAX(order_date) OVER () AS max_dataset_date
    FROM customer_orders
    WHERE order_status = 'Completed'
),
CustomerRetentionMetrics AS (
    SELECT 
        customer_id,
        username,
        full_name,
        COUNT(order_id) AS total_completed_orders,
        SUM(order_quantity) AS total_items_bought,
        SUM(net_order_value_rial) AS lifetime_value_rial, -- ارزش طول عمر مشتری (CLV)
        MIN(order_date) AS first_purchase_date,
        MAX(order_date) AS last_purchase_date,
        
        DATEDIFF(DAY, MAX(order_date), MAX(max_dataset_date)) AS days_since_last_order,
        
        AVG(DATEDIFF(DAY, previous_order_date, order_date)) AS avg_days_between_orders,
        
        SUM(CASE 
            WHEN customer_order_seq = 2 THEN (net_order_value_rial - previous_order_value_rial) 
            ELSE NULL 
        END) AS second_order_value_diff_rial
    FROM CustomerOrderHistory
    GROUP BY customer_id, username, full_name
)
SELECT 
    customer_id,
    username,
    full_name,
    total_completed_orders,
    total_items_bought,
    lifetime_value_rial,
    first_purchase_date,
    last_purchase_date,
    days_since_last_order AS recency_days,
    ISNULL(avg_days_between_orders, 0) AS days_between_purchases,
    ISNULL(second_order_value_diff_rial, 0) AS basket_growth_in_2nd_order_rial,
    
    CASE 
        WHEN total_completed_orders > 1 AND second_order_value_diff_rial > 0 
            THEN N'مشتری وفادار - با رشد سبد خرید (Up-sell)'
        WHEN total_completed_orders > 1 AND second_order_value_diff_rial <= 0 
            THEN N'مشتری وفادار - با افت سبد در خرید مجدد'
        WHEN total_completed_orders = 1 AND days_since_last_order <= 30 
            THEN N'مشتری جدید (تک‌خرید اخیر - پتانسیل بازگشت)'
        ELSE N'مشتری در خطر ریزش (تک‌خرید قدیمی - نیاز به کمپین احیا)'
    END AS retention_segment
FROM CustomerRetentionMetrics
ORDER BY total_completed_orders DESC, lifetime_value_rial DESC;
GO