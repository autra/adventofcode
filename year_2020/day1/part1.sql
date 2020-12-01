-- first possibility
-- approx time on my machine: 10ms (very rough estimate, can vary from 5 to 30)
-- indexes are useless here I think
select
  d1.expense as e1,
  d2.expense as e2,
  d1.expense + d2.expense as "Sum just to check",
  d1.expense * d2.expense as "Answer!!"
from day1 d1
join day1 d2
  on d1.expense+d2.expense=2020
  -- let's exclude permutation
  and d1.expense <= d2.expense;

-- another possibility with lateral join.
-- usually people say "lateral join are faster"
-- but this dataset is not big enough to check this here
-- (time is roughly the same. Not really surprising for such a small ds)
--
-- select
--    d1.expense, d2.expense,
--    d1.expense + d2.expense as "Sum just to check",
--    d1.expense * d2.expense as "Answer!"
-- from day1 d1
-- join lateral (
--    select expense from day1 d where d1.expense+d.expense=2020
-- ) as d2 on d1.expense <= d2.expense;
