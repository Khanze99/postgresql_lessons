DO $$
DECLARE
    foo text;
    bar text := 'World';
BEGIN
    foo := 'Hello';
    RAISE NOTICE '%, %', foo, bar;
end;
$$;

DO $$
    <<outer_block>>
    DECLARE
     foo text := 'Hello';
    BEGIN
       <<inner_block>>
        DECLARE
           foo text := 'World';
        BEGIN
            RAISE NOTICE '%, %', outer_block.foo, inner_block.foo;
            RAISE NOTICE 'Без метки внутренняя переменная: %', foo;
        END inner_block;
    END outer_block;
$$