{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'products_raw') }}
)

select
    product_id,
    product_category_name,
    product_weight_g,
    product_height_cm,
    product_width_cm,
    product_length_cm
from source_data
