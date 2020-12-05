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
) select max(id) from taken_seats;
