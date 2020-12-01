drop table if exists day1;

-- XXX is there an index that can speed up stuff?
create table day1(expense integer);

\copy day1 from './input'
