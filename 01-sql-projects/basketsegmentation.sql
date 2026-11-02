-- خوشه بندی بر اساس اندازه سبد خرید مشتری
WITH BasketSegmentation AS (
    SELECT 
        order_id,
        customer_id,
        order_quantity,
        (order_amount_rial - discount_amount_rial) AS net_order_value_rial,
        discount_amount_rial,
        shipping_cost_rial,
        order_status,
        CASE 
            WHEN order_quantity = 1 THEN N'سبد تک‌محصولی (۱ عدد)'
            WHEN order_quantity BETWEEN 2 AND 3 THEN N'سبد متداول (۲ تا ۳ عدد)'
            ELSE N'سبد حجیم (۴ عدد به بالا)'
        END AS basket_tier
    FROM customer_orders
    WHERE order_status = 'Completed'
)
SELECT 
    basket_tier,
    COUNT(order_id) AS completed_orders,
    SUM(order_quantity) AS total_unit_sold,
    SUM(net_order_value_rial) AS total_revenue_rial,
    ROUND(AVG(CAST(net_order_value_rial AS FLOAT)), 0) AS avg_basket_value_rial,
    ROUND(
        (SUM(net_order_value_rial) * 100.0) / NULLIF(SUM(SUM(net_order_value_rial)) OVER(), 0), 
        2
    ) AS revenue_contribution_pct,
    -- بررسی میزان هزینه دریافتی از مشتری بابت ارسال
    ROUND(AVG(CAST(shipping_cost_rial AS FLOAT)), 0) AS avg_shipping_charged_rial
FROM BasketSegmentation
GROUP BY basket_tier
ORDER BY total_revenue_rial DESC;
GO
