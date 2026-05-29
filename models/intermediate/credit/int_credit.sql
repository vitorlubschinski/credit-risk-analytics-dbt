select *
from {{ ref('stg_credit') }}
limit 10