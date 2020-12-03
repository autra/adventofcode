-- easy peasy lemon squeezy
select count(*) as "Bruise count"
from day3
-- a bit of complexity here because arrays are 1-based in postgresql
-- that's a case where I'd definitely have preferred 0-based indexing
-- but maybe it's because I'm more used to it?
where iso[1 + ((line_number - 1) * 3) % (cardinality(iso))] = '#' -- ouch !!;
