-- FLRB are actually a binary number representing up to 2^10
-- convert to binary then integer
with taken_seats(id) as (
  select
    -- F and L are 0, R and B are 1
    -- then use it as bit, then integer
    regexp_replace(
      regexp_replace(
        seat,
        'B|R',
        '1',
        'g'
      ),
      'F|L',
      '0',
      'g'
    )::bit(10)::integer
  from day5
),
-- need min/max to generate a serie
bounds as (
  select min(id), max(id) from taken_seats
)
select possible_seat.s
from bounds b,
-- LATERAL FTW \o/
lateral (select s from generate_series(b.min, b.max) s) possible_seat
where s not in (select id from taken_seats);

