{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'order_payments_raw') }}
)

select order_id,
       payment_type,
       payment_installments as payment_installments,
       cast(payment_value as float) as payment_value,
from source_data

