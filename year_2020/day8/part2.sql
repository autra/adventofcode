with recursive parsed as (
  select row_number, split_part(rule, ' ', 1) as inst, split_part(rule, ' ', 2)::int as arg from day8
),
ordered_inst(row_number, inst, arg, ancestors, has_changed) as (
  -- let's follow execution
  -- a row represent a "line to be executed" (the pointer is just before)
  select
    row_number,
    inst,
    arg,
    -- we need to keep the list of ancestors to prevent infinite loop
    ARRAY[]::int[] as ancestors,
    -- did we already use our "joker" (swap between nop and jmp) in this path?
    false as has_changed
    from parsed p
    -- start with line 1 :-)
    where row_number=1
  UNION ALL
  select
    c.row_number,
    c.inst,
    c.arg,
    -- update the execution path
    p.ancestors || p.row_number as ancestors,
    -- calculate if this path has used its joker
    p.has_changed
      or (p.inst='jmp' and c.row_number=p.row_number+1)
      or (p.inst='nop' and c.row_number=p.row_number+p.arg) as has_changed
  from ordered_inst p
    -- and join back with parsed to find next possible lines
  join parsed c
    on (
        -- a jmp can be a jmp in all cases, but also a nop if the joker hasn't been used yet
        p.inst='jmp' and (c.row_number=p.row_number+p.arg or (not p.has_changed and c.row_number=p.row_number+1))
        -- reverse for nop
        or p.inst='nop' and (c.row_number=p.row_number+1 or (not p.has_changed and c.row_number=p.row_number+p.arg))
        -- and acc just goes to next line
        or p.inst='acc' and c.row_number=p.row_number+1
      )
  -- stop following if we enter an infinite loop
  where not(c.row_number = any (p.ancestors))
)
select s.sum
from ordered_inst o,
  -- we need the adresse of halt
  lateral (select max(row_number) + 1 as halt  from parsed) m,
  -- and we sum all the acc in the ancestor list
  lateral (select sum(arg) from parsed where row_number = any (o.ancestors) and inst='acc') s
where
  -- more or less the same jump logic as inside the recursive query.
  -- in real production env, I'd have a function for that
  o.inst='jmp' and (m.halt=o.row_number+o.arg or (not o.has_changed and m.halt=o.row_number+1))
  or o.inst='nop' and (m.halt=o.row_number+1 or (not o.has_changed and m.halt=o.row_number+o.arg))
  or o.inst='acc' and m.halt=o.row_number+1
