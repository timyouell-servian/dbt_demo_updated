{% snapshot fct_orders_snapshot %}

{{
    config(
      target_schema='dev_eferreira',
      unique_key='order_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ ref('fct_orders') }}

{% endsnapshot %}