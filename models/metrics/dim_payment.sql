{{ config(materialized='table') }}

with cte_payment AS (
  SELECT
    codigo_da_transacao
    , metodo_de_captura
    , bandeira_do_cartao
    , credit_card
    , estado_da_transacao
    , to_base64(md5(cast(
      coalesce(cast(codigo_da_transacao AS VARCHAR), '')
      AS VARBINARY
    )))) AS sk_dim_payment
  FROM {{ ref('ton_customers') }}
)

SELECT * FROM cte_payment