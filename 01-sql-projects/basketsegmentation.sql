-- خوشه بندی بر اساس اندازه سبد خرید مشتری
with basketsegmentation as ( 
	select
	  order_id,
	  customer_id,
	  order_quantity,
	  (order_amount_rial - discount_amount_rial) as net_order_value_rial,
	  discount_amount_rial,
	  order_status,
	  -- بر اساس تعداد ایتم های فاکتور
	  case
		when order_quantity = 1 then N'سبد کوچک'
		when order_quantity between 2 and 3 then N'سبد معمولی'
	  else N'سبد حجیم'
	  
	  end as basket_tier
	  
	  from customer_orders
	  where order_status = 'completed'
	  )
  select 
    order_id,
    customer_id,
    order_quantity,
    net_order_value_rial,
    basket_tier
from BasketSegmentation;