do
$$
    DECLARE
        cmd constant text := 'create table city_msk(name text, architect text, founder integer)';
    begin
        execute cmd;
    end;
$$

do
$$
    declare
        rec record;
        cnt bigint;
    begin
        execute 'INSERT INTO city_msk (name, architect, founder) VALUES
                 (''Пашков дом'', ''Василий Баженов'', 1784),
                 (''Музей Пушкина'', ''Роман Клейн'', 1898),
                 (''ЦУМ'', ''Роман Клейн'', 1908)
             RETURNING name, architect, founder'
        into rec;
        raise notice '%', rec;
        get diagnostics cnt = ROW_COUNT ;
        raise notice 'Добавлено строк: %', cnt;

    end;
$$

create function sel_msk(architect text, founder integer default null) returns setof text
as $$
    declare
        cmd text := 'select name FROM city_msk WHERE architect = $1 AND ($2 IS NULL OR founder = $2)';
    begin
        return query
            execute cmd using architect, founder;
    end;
$$ language plpgsql;

SELECT * FROM sel_msk('Роман Клейн');