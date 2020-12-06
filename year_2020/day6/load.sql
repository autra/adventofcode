drop table if exists day6;

create table day6(row_number serial, answer text);

\copy day6(answer) from './input'

vacuum analyse day6;
