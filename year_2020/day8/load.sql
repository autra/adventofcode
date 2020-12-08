drop table if exists day8;

create table day8(row_number serial, rule text);

\copy day8(rule) from './input'

vacuum analyse day8;
