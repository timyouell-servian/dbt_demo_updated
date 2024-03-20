{{
  config(
    materialized='table'
  )
}}

{{ custom_sql('macros/threshold_check.sql') }}