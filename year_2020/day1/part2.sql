-- time: roughly 400ms
-- a lot slower than part1!
select
  d1.expense as e1,
  d2.expense as e2,
  d3.expense as e3,
  d1.expense + d2.expense + d3.expense as "Sum just to check",
  d1.expense * d2.expense * d3.expense as "Answer!!"
from day1 d1, day1 d2, day1 d3
where
  -- speed up query by 10!
  d1.expense + d2.expense < 2020
  and d1.expense + d2.expense + d3.expense = 2020
    -- let's exclude permutation
    -- here, I actually gain ~100ms doing these tests
    -- (apart from not getting duplicates)
  and d1.expense >= d2.expense
  and d2.expense >= d3.expense
