
select * from {{ ref('stg_test_percent_model') }}
ORDER BY ab_id