-- easy peasy lemon squeezy (2)
-- I pity the reader (me in approx 1 week), let's do a CTE this time
-- hardcoding the different paths is against all my principles
\set bound 9
with path as (
  select s % (:bound - 1) as right, 1+ (s / :bound) as down from generate_series(1, :bound, 2) s
)
select mult("Bruise count") as "Answer!!!"
from path
-- lateral FTW
join lateral (
  select count(*) as "Bruise count"
    from (
      -- a bit of complexity here because arrays are 1-based in postgresql
      -- that's a case where I'd definitely have preferred 0-based indexing
      -- but maybe it's because I'm more used to it?
      select iso[1 + ((line_number - 1) * path.right) % (cardinality(iso))] = '#' "Ouch!!"-- ouch !
      from day3
      -- this only select 1 lines every "down" line
      where line_number % path.down = 0
  ) as ouch_list
  -- count only when "ouch!"
  where "Ouch!!"
) as ouch_count_path on true;
