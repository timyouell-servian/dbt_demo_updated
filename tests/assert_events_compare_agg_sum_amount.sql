--  compare_column_values_between_views(a_relation, b_relation, primary_key, exclude_columns=[], summarize=true )
with
    base_fct_events as (
        {{
            compare_column_values_between_views(
                a_relation=ref("fct_events_agg_sum_amount_grp_by_lga_id"),
                b_relation=api.Relation.create(
                    database=env_var('DBT_DB'), schema=env_var('DBT_SNP_SCHEMA'), identifier="fct_events_agg_sum_amount_grp_by_lga_id"
                ),
                primary_key="lga_id",
                exclude_columns=[],
                summarize=True
            )
        }}
        where conflicting_values > 0
    )

select *
from base_fct_events



