select * from {{ ref('stg_test_model') }}
ORDER BY sum_id