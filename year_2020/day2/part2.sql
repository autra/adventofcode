select count(*) from (
  select
    substring(password from pos1 for 1) = letter as found1,
    substring(password from pos2 for 1) = letter as found2
  from day2_part2
) as foo
where (found1 or found2) and (not found1 or not found2)
