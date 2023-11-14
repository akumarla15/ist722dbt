with f_order_fulfillment as (
    select * from {{ ref('fact_order_fulfillment') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_employee as (
    select * from {{ ref('dim_employee') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
)

select 
    d_customer.*,
    d_employee.*,
    d_date.*,
    f.quantity,
    f.extendedpriceamount,
    f.discountamount,
    f.soldamount
from {{ ref('fact_sales') }} as f  -- Assuming fact_sales is a dbt model, not a raw table
    left join d_customer on f.customerkey = d_customer.customerkey
    left join d_employee on f.employeekey = d_employee.employeekey
    left join d_date on f.orderdatekey = d_date.datekey
