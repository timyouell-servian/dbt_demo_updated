{% macro get_string(string_var) %} 
    'CAST(lga_id AS STRING) = ' & ‘{{ string_var }}’ 
{% endmacro %} 