with source as (
    select *
    from {{ source('raw', 'credit_raw') }}
),

cleaned as (
    select
        ROW_NUMBER() OVER ()                        as customer_id,
        SeriousDlqin2yrs                            as is_default_2y,
        RevolvingUtilizationOfUnsecuredLines        as credit_utilization,
        age                                         as customer_age,
        `NumberOfTime30-59DaysPastDueNotWorse`      as dpd_30_59,
        DebtRatio                                   as debt_ratio,
        SAFE_CAST(MonthlyIncome AS FLOAT64)         as monthly_income,
        NumberOfOpenCreditLinesAndLoans             as open_credit_lines,
        NumberOfTimes90DaysLate                     as dpd_90_plus,
        NumberRealEstateLoansOrLines                as real_estate_loans,
        `NumberOfTime60-89DaysPastDueNotWorse`      as dpd_60_89,
        NumberOfDependents                          as num_dependents,

        -- flag de dado suspeito
        CASE
            WHEN age < 18 OR age > 100          THEN TRUE
            WHEN SAFE_CAST(
                MonthlyIncome AS FLOAT64) < 0   THEN TRUE
            ELSE FALSE
        END                                         as is_suspicious

    from source
)

select * from cleaned