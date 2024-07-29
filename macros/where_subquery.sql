{% macro get_where_subquery(relation) -%}
    {% set where = config.get('where') %}
    {% if where %}
        {% if "__last_run_date__" in where %}
            {# replace placeholder string with result of custom macro #}
            {% set last_run = env_var("DBT_ENV_CUSTOM_ENV_LOOKBACK_REF_DATE") %}
            {% set where = where | replace("__last_run_date__", last_run) %}
        {% endif %}
        {%- set filtered -%}
            (select * from {{ relation }} where {{ where }}) dbt_subquery
        {%- endset -%}
        {% do return(filtered) %}
    {%- else -%}
        {% do return(relation) %}
    {%- endif -%}
{%- endmacro %}