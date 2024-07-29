{{ left_outer_join_and_percent_diff(
    ref('test_percent_model'),
    ref('test_percent_clone'),
    primary_key='ab_id',
    comparison_column='sum_a_amount',
    min_value=-0.5,
    max_value=0.5,
    row_condition='sum_a_amount is null',
    replace_nulls_with='NULL',
    strictly=False) }}
