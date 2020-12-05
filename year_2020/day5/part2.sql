  -- convert to binary then integer
with taken_seats(id) as (
  select
    -- I'm SURE there's a better way
    replace(
      replace(
          replace(
            replace(
              seat,
              'R', '1'
            ),
            'L', '0'),
        'B', '1'),
      'F', '0')::bit(10)::integer
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

