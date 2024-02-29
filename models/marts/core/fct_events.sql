with 
    events as (select * from {{ ref('stg_events') }})

select * from events where extract(month from event_date) <= 4    