{%- test expect_column_value_difference_between_tables(model, clone_table, primary_key, column_name, row_condition, min_value, max_value, replace_nulls_with, strictly) -%}
{%- if execute -%}

    with base_compare_table as (
        {{
            left_outer_join_and_diff(
                model_table=model,
                clone_table=clone_table,
                primary_key=primary_key,
                comparison_column=column_name,
                row_condition=row_condition,
                min_value=min_value,
                max_value=max_value,
                replace_nulls_with=replace_nulls_with,
                strictly=strictly
                )
        }}
    )

    select * from base_compare_table
    where is_between_min_max = False
 
{%- endif -%}
{%- endtest -%}