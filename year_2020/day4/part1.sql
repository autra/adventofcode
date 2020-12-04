-- Extra challenge : let's say I don't want to harcode the list of required field in the query
-- for example, because they come from an external source
-- (emulated with the with query)
-- otherwise it's really too simple :-D
--
-- also, I've chosen to keep the input in its raw form: I consider that
-- grouping password in one "line" is part of the challenge, not of the load
-- logic
-- (otherwise it becomes trivial)
with required_fields(field) as (
  values ('byr'), ('iyr'), ('eyr'), ('hgt'), ('hcl'), ('ecl'), ('pid')
),
-- we need to classify each line to group them later
-- doing this by counting the number of empty line before the current row
-- the class value will be the row_number of the next empty line
classified(passport, class) as (
  select
    passport,
    count(*) filter (where passport = '') over (order by row_number) as class
  from day4
),
-- aggregation according to class and we have one nice row per passport
agg(passport) as (
  select string_agg(passport, ' ') as passport
  from classified
  group by class
),
-- criteria applied...
valid_entry(valid) as (
  -- let's not forget the ':' to avoid false positive!
  select bool_and(a.passport like '%' || r.field || ':%') as valid
  from agg a, required_fields r
  group by a.passport
)
select count(*)
from valid_entry
where valid;
