{% macro left_outer_join_and_diff(model, compare_model, primary_key, comparison_column, row_condition, min_value=None, max_value=None, replace_nulls_with='NULL', strictly=False) -%}

    {%- if min_value is none and max_value is none -%}
    {{ exceptions.raise_compiler_error(
        "You have to provide either a min_value, max_value or both."
    ) }}
    {%- endif -%}

    {%- set strict_operator = "" if strictly else "=" -%}

    {%- set expression_min_max %}
        (1=1
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
        c.{{ comparison_column }} AS {{ comparison_column }}_comparison,
        (COALESCE(m.{{ comparison_column }}, CAST({{ replace_nulls_with }} AS FLOAT64)) - COALESCE(c.{{ comparison_column }}, CAST({{ replace_nulls_with }} AS FLOAT64))) AS {{ comparison_column }}_diff
    FROM (
        SELECT *
        FROM {{ model }}
    {%- if row_condition %}
        WHERE {{ row_condition }}
        {%- endif %}
    ) m
    FULL OUTER JOIN (
        SELECT *
        FROM {{ compare_model }}
    {%- if row_condition %}
        WHERE {{ row_condition }}
        {%- endif %}
    ) c
    ON m.{{ primary_key }} = c.{{ primary_key }}
)

SELECT
    {{ primary_key }},
    {{ comparison_column }}_model,
    {{ comparison_column }}_comparison,
    {{ comparison_column }}_diff,
    {{ expression_min_max }} AS is_between_min_max
FROM joined_tables
ORDER BY {{ primary_key }} ASC
{% endmacro %}
