-- Alternative solution I really
-- like https://github.com/xocolatl/advent-of-code/blob/master/2020/dec05.sql
-- part2 is really better there :-)

-- FLRB are actually a binary number representing up to 2^10
-- convert to binary then integer
select max(translate(seat, 'FLBR', '0011')::bit(10)::integer) "Highest seat id" from day5
