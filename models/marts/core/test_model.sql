-- select * from {{ ref('stg_test_model') }}
-- ORDER BY sum_id
select * from {{ ref("judicial", "judicial_test") }}
