--cvar.sql
{% macro cvar(var_name) -%}

    {%- 
        set all_project_vars = {
            "test_var": var("test_var", "abc")
        }
    -%}
    
    {{ return(all_project_vars[var_name]) }}

{%- endmacro %}