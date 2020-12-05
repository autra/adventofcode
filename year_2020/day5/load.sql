drop table if exists day5;

create table day5(seat text);

\copy day5(seat) from './input'

vacuum analyse day5;
