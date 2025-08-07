{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'sellers_raw') }}
)

select 
       seller_id,
       seller_zip_code_prefix,
       seller_city,
       seller_state
from source_data
