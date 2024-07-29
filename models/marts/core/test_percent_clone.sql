select * from {{ ref('stg_test_percent_clone') }}
ORDER BY ab_id
