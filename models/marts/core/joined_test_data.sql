{% set max_date_value = max_date('fct_events_agg_sum_amount_grp_by_lga_id', 'event_date') %}


{{ left_outer_join_and_diff(
    ref('fct_events_agg_sum_amount_grp_by_lga_id'),
    ref('clone_fct_events_agg_sum_amount_grp_by_lga_id'),
    primary_key='surrogate_key',
    comparison_column='total_event_amount',
    min_value=-5,
    max_value=5,
    replace_nulls_with="Null",
    strictly=False) }}