{% macro get_max_yearmonth(table_var, column_var) %}
    {%- set sql_query -%}
        select
            CONCAT(MAX(EXTRACT(YEAR FROM {{ column_var }})), LPAD(CAST(MAX(EXTRACT(MONTH FROM {{ column_var }})) AS STRING), 2, '0')) as max_value
        from {{ table_var }}
    {%- endset %}
    {% set max_value = run_query(sql_query) %}
    {%- if max_value and max_value.rows|length %}
        {% set max_yearmonth_value = max_value.rows[0]['max_value'] %}
        {{ return(max_yearmonth_value|string) }}
    {%- else %}
        {{ return('') }}
    {%- endif %}
{% endmacro %}