{{ 
    config(
        materialized='incremental',
        unique_key='ROW_ID'
        ) 
    }}

with source_data as (

    select *
    from {{ ref('superstore_stg_model') }}
    {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records arriving later on the same day as the last run of this model)
    --where date_day >= (select coalesce(max(date_day), '1900-01-01') from {{ this }})

    {% endif %}
)

select *
from source_data