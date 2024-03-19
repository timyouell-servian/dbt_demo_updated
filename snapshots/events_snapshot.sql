{% snapshot events_snapshot %}

    {{
        config(
            target_schema=env_var("DBT_SNP_SCHEMA"),
            unique_key="event_id",
            strategy="timestamp",
            updated_at="event_date",
        )
    }}

    select * 
    from {{ ref("fct_events") }}

{% endsnapshot %}
