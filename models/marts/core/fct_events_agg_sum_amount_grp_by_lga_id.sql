--models/marts/core/fct_events_agg_sum_amount_grp_by_lga_id.sql
{{
    config(
        materialized='view',
        labels = {'visable_to_users': 'false'}   
    )
}}
--BigQuery is set to hide where false and display when true. 
--Note: could be possible but not currently implemented.

{% set relation = ref('fct_events') %}
{% set subquery = get_where_subquery(relation) %}

select
    {{ dbt_utils.generate_surrogate_key(['event_date', 'lga_id']) }} AS surrogate_key,
    event_date,
    lga_id,
    null_test_col,
    SUM(event_amount) AS total_event_amount
    from {{ ref('fct_events') }}
    --from {{ subquery }}
    group by event_date, lga_id, null_test_col
    order by event_date, lga_id
