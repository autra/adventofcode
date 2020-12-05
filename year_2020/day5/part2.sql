-- Alternative solution I really like
-- https://github.com/xocolatl/advent-of-code/blob/master/2020/dec05.sql

-- FLRB are actually a binary number representing up to 2^10
-- convert to binary then integer
with taken_seats(id) as (
  select
    -- F and L are 0, R and B are 1
    -- then use it as bit, then integer
    translate(seat, 'FLBR', '0011')::bit(10)::integer
  from day5
),
-- need min/max to generate a serie
bounds as (
  select min(id), max(id) from taken_seats
)
select possible_seat.s "This is my seat \o/"
from bounds b,
-- LATERAL FTW \o/
lateral (select s from generate_series(b.min, b.max) s) possible_seat
where s not in (select id from taken_seats);

