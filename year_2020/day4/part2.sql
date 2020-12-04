-- I give up my "extra challenge" of part1, because I feel I'd need pgplsql for
-- that. Maybe it's possible in pure sql?
--
-- we need to classify each line to group them later
-- doing this by counting the number of empty line before the current row
with classified(passport, class) as (
  select
    passport,
    count(*) filter (where passport = '') over (order by row_number) as class
  from day4
),
-- let's aggregate according to class and we have one nice row per passport
agg(passport) as (
  select string_agg(passport, ' ')
  from classified
  group by class
),
-- let's parse each row to create nice columns
parsed(byr, iyr, eyr, hgt, hgt_unit, hcl, ecl, pid) as (
  select
    -- byr is a 4 digit integer
    substring(passport, 'byr:(\d{4})')::integer as byr,
    -- iyr is a 4 digit integer
    substring(passport, 'iyr:(\d{4})')::integer as iyr,
    -- eyr is a 4 digit integer
    substring(passport, 'eyr:(\d{4})')::integer as eyr,
    substring(passport, 'hgt:(\d{2,3})(cm|in)')::integer as hgt,
    substring(passport, 'hgt:\d{2,3}(cm|in)') as hgt_unit,
    substring(passport, 'hcl:(#[a-f0-9]{6})') as hcl,
    substring(passport, 'ecl:(amb|blu|brn|gry|grn|hzl|oth)') as ecl,
    substring(passport, 'pid:(\d*)') as pid
  from agg
)
-- count the row matching the criterias
select count(*)
from parsed
where
  byr between 1920 and  2002
  and iyr between 2010 and 2020
  and eyr between 2020 and 2030
  and (
    (hgt_unit = 'cm' and hgt between 150 and 193)
    or
    (hgt_unit = 'in' and hgt between 59 and 76)
  )
  and hcl != ''
  and ecl != ''
  and length(pid) = 9
;
