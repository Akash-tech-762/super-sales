select years,customer_id,d_rank,payment
from
(select year(orders.order_purchase_timestamp) as years,orders.customer_id,
round(sum(payments.payment_value),2) as payment,
dense_rank() over(partition by year(orders.order_purchase_timestamp) order by sum(payments.payment_value) desc )d_rank
from orders join payments
on payments.order_id=orders.order_id
group by year(orders.order_purchase_timestamp),orders.customer_id) as a
where d_rank <= 3;