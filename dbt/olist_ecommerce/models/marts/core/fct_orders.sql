with orders as (
    select * from {{ ref('stg_orders') }}
    where order_status != 'canceled'
),

order_items_agg as (
    select
        order_id,
        count(*) as num_items,
        sum(price) as total_price,
        sum(freight_value) as total_freight_value
    from {{ ref('stg_order_items') }}
    group by order_id
),

payments_agg as (
    select
        order_id,
        sum(payment_value) as total_payment_value
    from {{ ref('stg_payments') }}
    group by order_id
)

select
    o.*,
    oia.num_items,
    oia.total_price,
    oia.total_freight_value,
    pa.total_payment_value

from orders as o
inner join order_items_agg as oia
    on o.order_id = oia.order_id
inner join payments_agg as pa
    on o.order_id = pa.order_id
