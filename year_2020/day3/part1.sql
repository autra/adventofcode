-- easy peasy lemon squeezy
select count(*)
  from (
    -- a bit of complexity here because arrays are 1-based in postgresql
    -- that's a case where I'd definitely have preferred 0-based indexing
    -- but maybe it's because I'm more used to it?
    select iso[1 + ((line_number - 1) * 3) % (cardinality(iso))] = '#' ouch -- ouch !
    from day3
) as ouch_list
where ouch;
