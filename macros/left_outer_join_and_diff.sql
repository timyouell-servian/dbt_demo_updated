{% macro left_outer_join_and_diff(model_table, clone_table, primary_key, comparison_column, row_condition, min_value=None, max_value=None, replace_nulls_with='NULL', strictly=False) -%}

    {%- if min_value is none and max_value is none -%}
    {{ exceptions.raise_compiler_error(
        "You have to provide either a min_value, max_value or both."
    ) }}
    {%- endif -%}

    {%- set strict_operator = "" if strictly else "=" -%}

    {%- set expression_min_max %}
        
( 1=1
        {%- if min_value is not none %}
             and {{ comparison_column }}_diff >{{ strict_operator }} {{ min_value }}
        {% endif %}
        {%- if max_value is not none %}
             and {{ comparison_column }}_diff <{{ strict_operator }} {{ max_value }}
        {% endif %}
)
    {%- endset %}

WITH joined_tables AS (
    SELECT
        COALESCE(m.{{ primary_key }}, c.{{ primary_key }}) AS {{ primary_key }},
        m.{{ comparison_column }} AS {{ comparison_column }}_model,
        c.{{ comparison_column }} AS {{ comparison_column }}_clone,
        (COALESCE(m.{{ comparison_column }}, CAST({{ replace_nulls_with }} AS FLOAT64)) - COALESCE(c.{{ comparison_column }}, CAST({{ replace_nulls_with }} AS FLOAT64))) AS {{ comparison_column }}_diff
    FROM {{ model_table }} m
    FULL OUTER JOIN {{ clone_table }} c
    ON m.{{ primary_key }} = c.{{ primary_key }}
    {%- if row_condition %}
    WHERE m.{{ row_condition }}
    {%- endif %}
)

SELECT
    {{ primary_key }},
    {{ comparison_column }}_model,
    {{ comparison_column }}_clone,
    {{ comparison_column }}_diff,
    {{ expression_min_max }} AS is_between_min_max
FROM joined_tables
ORDER BY {{ primary_key }} ASC
{% endmacro %}
