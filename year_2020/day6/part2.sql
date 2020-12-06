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
-- count the number of person per group
grouped_counted as (
  select group_id, count(answer) over(partition by group_id) nb_person, answer from grouped
),
-- For each group, count the number of times each letter appears
-- then keep only those where this number is the same as the number of persons in the group
grouped_count_by_letter(letter, group_id) as (
  select l.l, g.group_id
  from letters l,
  lateral (
    select g.group_id,
           g.nb_person,
           count(*) filter (where answer like '%' || l || '%')
    from grouped_counted g
    group by group_id, g.nb_person
  ) g
  where nb_person=count
  order by group_id
),
-- count the number of letters by group
group_count(group_id, count) as (
  select group_id, count(letter) from grouped_count_by_letter group by group_id
)
-- and sum everything
select sum(count) from group_count;
