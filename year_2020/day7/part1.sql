with recursive
parsed(arr) as (
  select regexp_matches(rule, '^([\w ]+) bag[s]? contain (.*)')
         -- , string_to_array(regexp_match(rule, '^.*contain ([^.]*)$'), ' ') as contained_str
  from day7
),
splitted(container, number, item) as (
  select arr[1], part[1], part[2]
  from parsed,
  lateral (
    select regexp_match(s, '^(\d) ([\w ]+) bag[s]?\.?$') part from regexp_split_to_table(arr[2], ', ') s
  ) part
),
tree(container, item) as (
  select container, item from splitted
  UNION
  select s.container, t.item from tree t
  join splitted s on t.container=s.item

)
select count (distinct container)
from tree
where item='shiny gold'
;
