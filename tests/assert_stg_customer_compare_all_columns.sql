with
    base_stg_customer as (
        {{
            audit_helper.compare_all_columns(
                a_relation=ref("stg_customers"),
                b_relation=api.Relation.create(
                    database=env_var('DBT_DB'), schema="prod", identifier="stg_customers"
                ),
                exclude_columns=["updated_at"],
                primary_key="customer_id",
            )
        }}
        where not perfect_match
    )

select *
from base_stg_customer
