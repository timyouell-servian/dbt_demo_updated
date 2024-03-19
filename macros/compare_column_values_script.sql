{% set old_relation_query %}
    select * from dbt_tyouell_marts.snp_fct_events_agg_sum_amount_grp_by_lga_id
{% endset %}

{% set new_relation_query %}
    select * from {{ ref('fct_events_agg_sum_amount_grp_by_lga_id')}}
{% endset %}

{% set audit_query = compare_column_values_verbose(
    a_query=old_relation_query,
    b_query=new_relation_query,
    primary_key='lga_id',
    column_to_compare='total_event_amount',
    only_not_match=True
) %}

{{ audit_query }}