with orders as (
  select * from {{ ref('stg_orders') }}
  where order_status != 'canceled'
),

order_items_agg as (
    select count(*) as num_items,
           order_id,
           sum(price) as total_price,
           sum(freight_value) as total_freight_value
    from {{ ref('stg_order_items') }}
    group by order_id
),

payments_agg as (
    select sum(payment_value) as total_payment_value,
           order_id
    from {{ ref('stg_payments') }}
    group by order_id
)

select o.*,
       oia.num_items,
       oia.total_price,
       oia.total_freight_value,
       pa.total_payment_value

from orders o
inner join order_items_agg oia
on o.order_id = oia.order_id
inner join payments_agg pa
on o.order_id = pa.order_id
