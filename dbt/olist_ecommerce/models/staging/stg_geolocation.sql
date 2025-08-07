{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'geolocation_raw') }}
)

select geolocation_zip_code_prefix,
       geolocation_city,
       geolocation_state
from source_data