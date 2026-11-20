-- data_validation_payment_performance_05_01
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM dbo.customer_orders
GROUP BY order_status;