{{ config(materialized='table') }}

WITH fct_customers AS (

SELECT  

dim_payment.sk_dim_payment
, dim_users.sk_dim_user
, ton_customers.data_e_hora_da_transacao
, ton_customers.valor_da_transacao
FROM {{ ref('ton_customers') }}
LEFT JOIN {{ ref('dim_payment') }}
ON ton_customers.codigo_da_transacao = dim_payment.codigo_da_transacao
LEFT JOIN {{ ref('dim_users') }}
ON ton_customers.codigo_do_usuario = dim_users.codigo_do_usuario

)

SELECT * FROM fct_customers