select
    event_id,
    event_date,
    lga_id,
    lga_name,
    lga_code,
    event_amount
from {{ source('jaffle_shop', 'events') }}