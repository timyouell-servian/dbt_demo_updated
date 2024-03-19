select * from {{ ref('stg_test_clone') }}
ORDER BY sum_id