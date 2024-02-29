{%- call statement('get_last_month_query', fetch_result=True) -%}
    select
      max(date_part(month, event_date))
     from {{env_var('DBT_DB')}}.{{env_var('DBT_SNP_SCHEMA')}}.events_snapshot
    {#from {{ ref('fct_orders_snapshot') }}#}
{%- endcall -%}

{%- set snapshot_month_value = load_result('get_last_month_query')['data'][0][0] -%}

with
    base_fct_orders as (
        {{
            compare_all_columns_with_baseline(
                a_relation=ref("fct_events"),
                b_relation=api.Relation.create(
                    database=env_var('DBT_DB'), schema=env_var('DBT_SNP_SCHEMA'), identifier="events_snapshot"
                ),
                primary_key="event_id",
                datetime_column_name="event_date",
                month_value=snapshot_month_value,
                exclude_columns=["lga_name"],
                timestamp_snapshot=true
            )
        }}
        where conflicting_values > 0
    )

select *
from base_fct_events

