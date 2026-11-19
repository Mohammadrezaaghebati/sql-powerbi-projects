-- payment_performance_05.sql
-- using customer_orders to make new insight

select
	payment_method,
	SUM(
		case
			when order_status = 'Completed' then 1
		else 0
		end
	) as total_completed,
	
	SUM(
		case
			when order_status = 'Returned' then 1
		else 0
		end
	) as total_returned,

	SUM(
		case
			when order_status = 'Cancelled' then 1
		else 0
		end
	) as total_cancelled,

	count (order_status) as total_orders,
	
	(cast( SUM(
				case
				when order_status = 'Completed' then 1
				else 0
				end
				)as decimal(10,2)) / count (order_status) * 100 ) as completion_rate
from dbo.customer_orders
group by payment_method
-- ادامه دارد