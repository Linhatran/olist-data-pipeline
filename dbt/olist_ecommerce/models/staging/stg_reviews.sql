{{ config(materialized='table') }}

with source_data as (
    select * from {{ source('olist', 'order_reviews_raw') }}
)

select review_id,
       order_id,
       review_score,
       review_comment_title,
       review_comment_message,
       cast(review_creation_date as timestamp) as review_creation_ts,
       cast(review_answer_timestamp as timestamp) as review_answer_ts
from source_data

