SELECT * FROM {{ source('jaffle_shop', 'test_percent_model') }}
ORDER BY ab_id