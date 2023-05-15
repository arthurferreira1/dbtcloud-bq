{{ config(materialized='table') }}

with cte_payment AS (
  SELECT
    codigo_da_transacao
    , metodo_de_captura
    , bandeira_do_cartao
    , metodo_de_pagamento
    , estado_da_transacao
    , to_base64(md5(cast(
      coalesce(cast(codigo_da_transacao AS VARCHAR), '')
      AS BYTES
    ))) AS sk_dim_payment
  FROM {{ ref('ton_customers') }}
)

SELECT * FROM cte_payment