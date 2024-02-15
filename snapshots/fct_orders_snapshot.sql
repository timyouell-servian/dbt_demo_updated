{% snapshot fct_orders_snapshot %}

{{
    config(
      target_schema=env_var('DBT_SNP_SCHEMA'),
      unique_key='order_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ ref('fct_orders') }}

{% endsnapshot %}