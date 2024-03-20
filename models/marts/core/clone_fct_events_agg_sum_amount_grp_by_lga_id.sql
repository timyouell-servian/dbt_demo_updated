{{
    config(
        materialized='table',
        tags=['clone_model']
    )
}}

select 
    *,
    '{{ env_var("DBT_CLOUD_RUN_ID", "manual") }}' as audit_run_id,
    '{{ run_started_at.astimezone(modules.pytz.timezone("Australia/Sydney")) }}' as run_started_est
from {{ ref('fct_events_agg_sum_amount_grp_by_lga_id') }}
