{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'order_items_raw') }}
)

select
    order_id,
    order_item_id,
    product_id,
    seller_id,
    cast(shipping_limit_date as timestamp) as shipping_limit_ts,
    cast(price as float) as price,
    cast(freight_value as float) as freight_value
from source_data
where
    order_id is not null
    and product_id is not null
