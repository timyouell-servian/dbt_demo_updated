{{ left_outer_join_and_diff(
    ref('test_model'),
    ref('test_clone'),
    primary_key='sum_id',
    comparison_column='sum_a_amount',
    min_value=-5,
    max_value=5,
    row_condition='sum_a_amount> -200',
    replace_nulls_with='NULL',
    strictly=False) }}