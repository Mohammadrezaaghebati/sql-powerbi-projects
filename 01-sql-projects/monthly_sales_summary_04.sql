select 
    DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)		    as sales_month,
    count(order_id)												    as completed_orders,
    sum(order_amount_rial - discount_amount_rial)				    as net_revenue_rial,
    AVG(cast(order_amount_rial - discount_amount_rial as float))    as avg_order_value_rial
from dbo.customer_orders
where order_status = 'completed'
group by DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) 
order by sales_month;