with customers as (
    select * from {{ ref('stg_customers') }}
),

geolocation as (
    select
        geolocation_zip_code_prefix,
        avg(geolocation_lat) as geolocation_lat,
        avg(geolocation_lng) as geolocation_lng
    from {{ ref('stg_geolocation') }}
    group by geolocation_zip_code_prefix
)

select
    c.*,
    g.geolocation_lat,
    g.geolocation_lng

from customers as c
left join geolocation as g
    on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
