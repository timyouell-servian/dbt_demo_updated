{% macro get_max_int(table_var, column_var) %}
    {%- set sql_query -%}
        select
            max({{ column_var }}) as max_value
        from {{ table_var }}
    {%- endset %}
    {% set max_value = run_query(sql_query) %}
    {%- if max_value and max_value.rows|length %}
        {% set max_int_value = max_value.rows[0]['max_value'] %}
        {{ return(max_int_value|string) }}
    {%- else %}
        {{ return('') }}
    {%- endif %}
{% endmacro %}