drop table if exists day1;

-- XXX is there an index that can speed up stuff?
create table day1(expense integer);

\copy day1 from './input'

create index on day1(expense);

vaccuum analyze day1;
