{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'customers_raw') }}
)

select
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
from source_data
