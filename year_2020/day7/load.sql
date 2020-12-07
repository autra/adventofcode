drop table if exists day7;

create table day7(row_number serial, rule text);

\copy day7(rule) from './input'

vacuum analyse day7;
