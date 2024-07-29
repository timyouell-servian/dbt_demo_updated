SELECT * FROM {{ source('jaffle_shop', 'test_percent_clone') }}
ORDER BY ab_id