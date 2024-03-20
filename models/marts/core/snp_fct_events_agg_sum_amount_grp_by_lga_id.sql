{{
    config(
        materialized='view',
        labels = {'month_2_month': 'yes'}
    )
}}

with 
    events as (select 
    event_date,
    lga_id,
    SUM(event_amount) AS total_event_amount,
    from {{ ref('fct_events') }}
    group by event_date, lga_id
    order by event_date, lga_id
    )

select * from events
order by event_date, lga_id


