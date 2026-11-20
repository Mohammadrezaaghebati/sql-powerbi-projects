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

	count (*) as total_orders,
	
	cast(round((cast( SUM(
				case
					when order_status = 'Completed' then 1
				else 0
				end
				)as decimal(5,2)) / count (*) * 100 ),2)as decimal(5,2)) as completion_rate,

	cast(round((cast( SUM(
				case
					when order_status = 'Cancelled' then 1
				else 0
				end
				)as decimal(5,2)) / count (*) * 100 ),2)as decimal(5,2)) as cancellation_rate,

	cast(round((cast( SUM(
				case
					when order_status = 'Returned' then 1
				else 0
				end
				)as decimal(5,2)) / count (*) * 100 ),2)as decimal(5,2)) as returned_rate
from dbo.customer_orders
group by payment_method