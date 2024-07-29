select
    *
from {{ source('jaffle_shop', 'events') }}