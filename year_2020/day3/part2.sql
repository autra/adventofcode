-- easy peasy lemon squeezy (2) (but a bit less than part 1, let's be honest)

-- I pity the reader (me in approx 1 week), let's do a CTE this time
\set bound 9
-- first generate the possible "move", down and right
-- hardcoding them is against all my principles
with move as (
  select s % (:bound - 1) as right, 1+ (s / :bound) as down
  from generate_series(1, :bound, 2) s
)
-- mult doesn't exist in postgres, it is created in load.sql
select mult("Bruise count") as "Answer!!!"
from move
-- lateral FTW
join lateral (
  select count(*) as "Bruise count"
    from (
      -- a bit of complexity here because arrays are 1-based in postgresql
      -- that's a case where I'd definitely have preferred 0-based indexing
      -- but maybe it's because I'm more used to it?
      select iso[1 + ((line_number - 1) * move.right) % (cardinality(iso))] = '#' "Ouch!!"-- ouch !
      from day3
      -- this only select 1 lines every "down" line
      where line_number % move.down = 0
  ) as ouch_list
  -- count only when "ouch!"
  where "Ouch!!"
) as ouch_count_per_move on true;
