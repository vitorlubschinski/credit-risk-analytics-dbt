select *
from {{ ref('int_credit') }}
limit 10