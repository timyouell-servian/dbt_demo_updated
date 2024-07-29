select
    ab_id,
    column_a,
    column_b,
    (column_a/column_b) AS div,

from {{ source('jaffle_shop', 'percent_testing') }}
WHERE ab_id = 12
ORDER BY ab_id
