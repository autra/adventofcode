drop table if exists day4;

create table day4(row_number serial, passport text);

\copy day4(passport) from './input'

vacuum analyse day4;
