{{ config(materialized='table') }}

WITH cte_dim_user_ranking AS (
  SELECT
    codigo_do_usuario
    , estado_do_usuario
    , cidade_do_usuario
    , row_number() OVER (
      PARTITION BY (codigo_do_usuario) ORDER BY data_e_hora_da_transacao DESC
    ) AS ranking
  FROM {{ ref('ton_customers') }}
)

, cte_dim_user AS (
  SELECT
    codigo_do_usuario
    , estado_do_usuario
    , cidade_do_usuario
  FROM cte_dim_user_ranking
  WHERE ranking = 1
)

SELECT * FROM cte_dim_user
