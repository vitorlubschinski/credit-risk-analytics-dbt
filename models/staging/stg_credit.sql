with source as (
    select *
    from {{ source('raw', 'credit_raw') }}
),

renamed as (
    select
        int64_field_0                               as customer_id,
        SeriousDlqin2yrs                            as is_default_2y,
        RevolvingUtilizationOfUnsecuredLines        as credit_utilization,
        age                                         as customer_age,
        `NumberOfTime30-59DaysPastDueNotWorse`      as dpd_30_59,
        DebtRatio                                   as debt_ratio,
        MonthlyIncome                               as monthly_income_raw,
        NumberOfOpenCreditLinesAndLoans             as open_credit_lines,
        NumberOfTimes90DaysLate                     as dpd_90_plus,
        NumberRealEstateLoansOrLines                as real_estate_loans,
        `NumberOfTime60-89DaysPastDueNotWorse`      as dpd_60_89,
        NumberOfDependents                          as num_dependents,
    from source
),

cleaned as (
    select 
        ROW_NUMBER() OVER () as customer_id,
        is_default_2y,
        customer_age,
        dpd_30_59,
        debt_ratio,
        open_credit_lines,
        dpd_90_plus,
        real_estate_loans,
        dpd_60_89,
        num_dependents,

        CASE
            WHEN credit_utilization < 0 THEN NULL
            ELSE credit_utilization
        END                                    as credit_utilization,

        SAFE_CAST(monthly_income_raw AS FLOAT64) as monthly_income,

    from renamed

)

select * from cleaned 