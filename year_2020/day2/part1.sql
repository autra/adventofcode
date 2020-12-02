select count(*)
from (
  select
    char_length(password) - char_length(replace(password, letter, '')) as cardinality,
    min,
    max
  from day2
) foo
where min <= cardinality and cardinality <= max
