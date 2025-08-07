{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'geolocation_raw') }}
)

select geolocation_zip_code_prefix,
       geolocation_city,
       geolocation_state,
       cast(geolocation_lat as float) as geolocation_lat,
       cast(geolocation_lng as float) as geolocation_lng
from source_data