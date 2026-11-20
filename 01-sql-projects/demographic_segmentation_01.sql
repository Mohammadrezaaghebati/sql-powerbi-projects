-- خوشه بندی مشتریان برای کمپین های آینده
SELECT 
    customer_id,
    first_name,
    last_name,
    gender,
    birth_date,
    -- استخراج سال تولد و محاسبه سن (مبنا: سال ۱۴۰۴)
    (1404 - (birth_date / 10000)) AS age,
    
    -- خوشه‌بندی سنی و نسلی
    CASE 
        WHEN (1404 - (birth_date / 10000)) < 25 THEN N'زیر ۲۵ سال (نسل Z)'
        WHEN (1404 - (birth_date / 10000)) BETWEEN 25 AND 34 THEN N'۲۵ تا ۳۴ سال (جوانان)'
        WHEN (1404 - (birth_date / 10000)) BETWEEN 35 AND 44 THEN N'۳۵ تا ۴۴ سال (میانسالان اول)'
        ELSE N'بالای ۴۵ سال'
    END AS age_cohort,
    
    -- تقسیم‌بندی ترکیبی بازاریابی
    CASE 
        WHEN (1404 - (birth_date / 10000)) < 30 AND gender = 'Female' THEN N'خانم‌های زیر ۳۰ سال'
        WHEN (1404 - (birth_date / 10000)) < 30 AND gender = 'Male' THEN N'آقایان زیر ۳۰ سال'
        WHEN (1404 - (birth_date / 10000)) >= 30 AND gender = 'Female' THEN N'خانم‌های ۳۰ سال به بالا'
        ELSE N'آقایان ۳۰ سال به بالا'
    END AS marketing_segment
INTO customer_demographics
FROM (
    SELECT DISTINCT 
        customer_id, 
        first_name, 
        last_name, 
        gender, 
        birth_date
    FROM customer_orders
) AS clean_customers;
GO

-- ۲. اجرای کوئری تحلیلی با توابع پنجره‌ای و رتبه‌بندی
WITH DemographicsPerformance AS (
    SELECT 
        d.age_cohort,
        d.gender,
        COUNT(DISTINCT d.customer_id) AS total_customers,
        COUNT(o.order_id) AS total_orders,
        SUM(o.order_amount_rial - o.discount_amount_rial) AS net_revenue_rial,
        ROUND(AVG(CAST(o.order_amount_rial - o.discount_amount_rial AS FLOAT)), 0) AS avg_order_value_rial,
        SUM(o.discount_amount_rial) AS total_discount_given
    FROM customer_demographics d
    JOIN customer_orders o ON d.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY d.age_cohort, d.gender
)
SELECT 
    age_cohort,
    gender,
    total_customers,
    total_orders,
    net_revenue_rial,
    avg_order_value_rial,
    -- سهم فروش به درصد
    ROUND(
        (net_revenue_rial * 100.0) / NULLIF(SUM(net_revenue_rial) OVER(), 0), 
        2
    ) AS revenue_share_pct,
    -- نرخ حساسیت به تخفیف به درصد
    ROUND(
        (total_discount_given * 100.0) / NULLIF(net_revenue_rial + total_discount_given, 0), 
        2
    ) AS discount_sensitivity_pct,
    -- رتبه‌بندی گروه‌ها بر اساس درآمد خالص
    DENSE_RANK() OVER(ORDER BY net_revenue_rial DESC) AS revenue_rank
FROM DemographicsPerformance
ORDER BY revenue_rank ASC;
GO