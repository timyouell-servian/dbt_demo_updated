select *
from {{ source('jaffle_shop', 'condition_testing') }}