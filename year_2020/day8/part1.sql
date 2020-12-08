with recursive parsed as (
  select row_number, split_part(rule, ' ', 1) as inst, split_part(rule, ' ', 2)::int as arg from day8
),
ordered_inst as (
  select row_number, 1 as exec_order, inst, arg, ARRAY[]::int[] as ancestors from parsed where row_number=1
  UNION
  select c.row_number, p.exec_order+1 as exec_order, c.inst, c.arg, p.ancestors || p.row_number as ancestors
  from parsed c
  join ordered_inst p
    -- and join it with jump logic
    on (p.inst='jmp' and c.row_number=p.row_number+p.arg or p.inst!='jmp' and c.row_number=p.row_number+1)
  where not(c.row_number = any (p.ancestors))
)
select sum(arg) from ordered_inst where inst='acc';
