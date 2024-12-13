
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

   select 
        `Row ID` ROW_ID,
        left(`Order Date`,7) MONTH ,
        ROW_NUMBER() OVER (PARTITION BY `Row ID` ORDER BY `Order Date` DESC) ROW_NUM
    from read_files('abfss://datalake@pocdatabrickdev.dfs.core.windows.net/bronze/*')

)

select *
from source_data
where ROW_NUM = 1

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
