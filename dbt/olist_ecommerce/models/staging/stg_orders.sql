{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'orders_raw') }}
)

select order_id,
       customer_id,
       order_status,
       cast(order_purchase_timestamp as timestamp) as purchase_ts,
       cast(order_delivered_customer_date as timestamp) as delivery_ts,
       cast(order_estimated_delivery_date as timestamp) as estimated_delivery_ts
from source_data
where order_id is not null

