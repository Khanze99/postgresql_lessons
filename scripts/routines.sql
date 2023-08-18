create table t3(a float);

create procedure fill()
as $$
    truncate t3;
    insert into t3 select random() from generate_series(1, 3);
    $$ language sql;

call fill();

create function fill_avg() returns void
as $$
    truncate t3;
    insert into t3 select random() from generate_series(1, 3)
    $$ language sql;

select fill_avg();

select *
from t3;

drop procedure fill();


create procedure fill(nrows integer)
as $$
    truncate t3;
    insert into t3 select random() from generate_series(1, nrows);
    $$ language sql;

call fill(nrows := 5);

drop procedure fill(nrows integer);


create procedure fill(IN nrows integer, INOUT average float)
as $$
    truncate t3;
    insert into t3 select random() from generate_series(1, nrows);
    select avg(a) from t3;
    $$ language sql;

call fill(nrows := 5, average := Null);

create function maximum(a integer, b integer) returns integer
as $$
    select case when a > b then a else b end;
    $$ language sql;

select maximum(1, 2);

create function maximum(a integer, b integer, c integer) returns integer
as $$
    select case when a > b then maximum(a, c) else maximum(b, c) end;
    $$ language sql;

select maximum(1,2,3);
drop function maximum(a integer, b integer);
drop function maximum(a integer, b integer, c integer);


create function maximum(a anyelement, b anyelement) returns anyelement
as $$
    SELECT CASE WHEN a > b THEN a ELSE b END;
    $$ language sql;

select maximum('A', 'B');
select maximum('A'::text, 'B'::text);
select maximum(now(), now() + interval '1 day');

CREATE FUNCTION maximum(
    a anyelement,
    b anyelement,
    c anyelement DEFAULT NULL
) RETURNS anyelement
AS $$
SELECT CASE
        WHEN c IS NULL THEN
            x
        ELSE
            CASE WHEN x > c THEN x ELSE c END
    END
FROM (
    SELECT CASE WHEN a > b THEN a ELSE b END
) max2(x);
$$ LANGUAGE sql;

select maximum(10, 20), maximum(10, 20, 30);

drop function maximum(a anyelement, b anyelement);