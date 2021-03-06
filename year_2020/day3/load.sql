drop table if exists day3_input;
drop table if exists day3;

-- also generating line_numbers here, as SGBD generally doesn't guarantee row orders in select queries
-- PostgreSQL DOES guarantee the order in copy queries though, that's why it works
create temporary table day3_input(line_number serial, iso text);

\copy day3_input(iso) from './input';

create table day3 as
    select line_number, string_to_array(iso, NULL) as iso from day3_input;

-- OOOHH NO, postgresqsl does not have multiply aggregate function /o\
-- sad!
-- well, no big deal in fact
create or replace aggregate mult(bigint) ( SFUNC = int8mul, STYPE=bigint );
