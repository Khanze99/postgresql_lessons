create function sqr_in(IN a numeric) returns numeric
 as $$
    BEGIN
        return a*a;
    END;
    $$ language plpgsql immutable;

create function reverse_for(line text) returns text
as $$
    DECLARE
        line_length CONSTANT int := length(line);
        retval text := '';
    BEGIN
        FOR i in 1 .. line_length
        LOOP
            retval := substr(line, i, 1) || retval;
        end loop;
        return retval;
    END;
$$ language plpgsql immutable strict;

select reverse_for('SALAM ALEKUM');

create function do_something() returns void
as $$
    BEGIN
        RAISE NOTICE 'Что-то сделалось!';
    end;
$$ language plpgsql;

do $$BEGIN PERFORM do_something(); end;$$;


create table test(n integer);

create procedure foo()
as $$
    BEGIN
        insert into test values (1);
        commit;
        insert into test values (2);
        rollback;
    end;
$$ language plpgsql;

call foo();

select * from test;