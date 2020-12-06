-- generate a group 1d for each line
with grouped(group_id, answer) as (
  select * from (
    select count(answer) filter (where answer='') over(order by row_number), answer from day6
  ) as _
  where answer != ''
),
-- generate the alphabet
letters(l) as (
  select chr(s) from generate_series(97,122) s
),
grouped_count_by_letter(letter_count, group_id) as (
  -- for each letter and each group, count the number of time a letter appears
  -- so we have a line group_id | letter | count
  -- and count the number of these lines where count > 0
  select count(l.l), g.group_id
  from letters l,
  lateral (
    select g.group_id,
           count(*) filter (where answer like '%' || l || '%')
    from grouped g
    group by group_id
  ) g
  where g.count > 0
  group by group_id
  order by group_id
)
-- then sum everything
select sum(count) from grouped_count_by_letter;
