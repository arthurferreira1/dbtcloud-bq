{{ config(materialized='table') }}

with source_ton_customers AS (
    select * from {{ source(ton_customers, customer_raw) }}
)

, final as (
    select * from source_ton_customers
)

select * from final
