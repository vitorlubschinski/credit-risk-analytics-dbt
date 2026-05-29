with source as (
    select *
    from {{ source('raw', 'credit_raw') }}
),

renamed as (
    select
        SeriousDlqin2yrs as default_last_2y,
        RevolvingUtilizationOfUnsecuredLines as credit_utilization_ratio,
        age as age,
        `NumberOfTime30-59DaysPastDueNotWorse` as late_payments_30_59_days,
        `NumberOfTime60-89DaysPastDueNotWorse` as late_payments_60_89_days,
        NumberOfTimes90DaysLate as late_payments_90_plus_days,
        DebtRatio as debt_to_income_ratio,
        MonthlyIncome as monthly_income,
        NumberOfOpenCreditLinesAndLoans as total_credit_lines,
        NumberRealEstateLoansOrLines as real_estate_loans_count,
        NumberOfDependents as dependents_count
    from source
),

cleaned as (
    select
        ROW_NUMBER() OVER () as customer_id,
        default_last_2y,
        credit_utilization_ratio,

        CASE
            WHEN age <= 0 THEN NULL
            ELSE age
        END as age,
        
        CASE 
            WHEN late_payments_30_59_days < 0 THEN NULL
            ELSE late_payments_30_59_days
        END as late_payments_30_59_days,

        CASE 
            WHEN late_payments_60_89_days < 0 THEN NULL
            ELSE late_payments_60_89_days
        END as late_payments_60_89_days,
        
        CASE 
            WHEN late_payments_90_plus_days < 0 THEN NULL
            ELSE late_payments_90_plus_days
        END as late_payments_90_plus_days,

        debt_to_income_ratio,

        CASE
            WHEN SAFE_CAST(monthly_income AS FLOAT64) < 0 THEN NULL
            ELSE SAFE_CAST(monthly_income AS FLOAT64)
        END as monthly_income,

        CASE
            WHEN total_credit_lines < 0 THEN NULL
            ELSE total_credit_lines
        END as total_credit_lines,

        CASE
            WHEN real_estate_loans_count < 0 THEN NULL
            ELSE real_estate_loans_count
        END as real_estate_loans_count,
        
        CASE
            WHEN SAFE_CAST(NULLIF(dependents_count, 'NA') AS INT64) < 0 THEN NULL
            ELSE SAFE_CAST(NULLIF(dependents_count, 'NA') AS INT64)
        END as dependents_count

    from renamed
)

select * from cleaned 