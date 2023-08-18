create table test1(id integer, s text);

INSERT INTO test1 VALUES (1, 'Раз'), (2, 'Два'), (3, 'Три');


do
$$
    declare
    cur refcursor;
    begin
        open cur for select * from test1;
    end;
$$;


do $$
    DECLARE
        cur refcursor;
        rec record;
    begin
        open cur for select * from test1 order by id;
        move cur;
        fetch cur into rec;
        raise notice '%', rec;
        close cur;
    end;
$$


do $$
    DECLARE
        cur refcursor;
        rec record;
    begin
        open cur for select * from test1 order by id;
        loop
            fetch cur into rec;
            exit when NOT FOUND;
            raise notice '%', rec;
        end loop;
        close cur;
    end;
$$

do $$
    DECLARE
        cur CURSOR for select * from test1;
    begin
        for rec in cur loop
            raise notice '%', rec;
            end loop;
    end;
$$