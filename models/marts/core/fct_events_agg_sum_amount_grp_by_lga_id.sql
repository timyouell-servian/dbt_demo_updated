{{
    config(
        materialized='view',
        labels = {'month_2_month': 'yes'}
    )
}}

with 
    events as (select event_id, event_date, lga_id, lga_name, lga_code,
    case when event_id = 1001 then 1
    else event_amount end as new_event_amount
    from {{ ref('fct_events') }})

select 
    event_date,
    lga_id,
    SUM(new_event_amount) AS total_event_amount,
    from events
    group by event_date, lga_id
    order by event_date, lga_id
