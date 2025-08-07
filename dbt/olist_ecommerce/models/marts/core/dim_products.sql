with products as (
    select * from {{ ref('stg_products') }}
),

order_items as (
    select
        product_id,
        avg(price) as average_price,
        avg(freight_value) as average_freight_value,
        count(*) as num_orders
    from {{ ref('stg_order_items') }}
    group by product_id
)

select
    p.*,
    oi.average_price,
    oi.average_freight_value,
    oi.num_orders
from products as p
left join order_items as oi
    on p.product_id = oi.product_id
