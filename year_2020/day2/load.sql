drop table if exists day2;
drop table if exists day2_tmp;

create temporary table day2_tmp(minmax text, letter text, password text);

\copy day2_tmp from './input' csv delimiter ' ';

create table day2 as select
  cast(minmax_groups[1] as integer) as min,
  cast(minmax_groups[2] as integer) as max,
  letter[1] as letter,
  password
from (
  select
    regexp_match(minmax, '^(\d*)-(\d*)$') as minmax_groups,
    regexp_match(letter, '^([a-z]):$') as letter,
    password
  from day2_tmp
) as parsed;

-- just nicer naming
create view day2_part2 as
  select min as pos1,
         max as pos2,
         *
  from day2;

