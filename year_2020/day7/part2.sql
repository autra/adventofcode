with recursive
parsed(arr) as (
  select regexp_matches(rule, '^(\w* \w*) bags contain (.*)')
  from day7
),
splitted(container, number, item) as (
  select arr[1], part[1]::bigint, part[2]
  from parsed,
  lateral (
    select regexp_match(s, '^(\d) (\w* \w*) bag[s]?\.?$') part from regexp_split_to_table(arr[2], ', ') s
  ) part
),
tree(container, number, item) as (
  select container, number, item from splitted
  UNION ALL
  select s.container, t.number * s.number, t.item from tree t
  join splitted s on t.container=s.item

)
--select * from tree
--where container='shiny gold';
select sum(number)
from tree
where container='shiny gold'
;
