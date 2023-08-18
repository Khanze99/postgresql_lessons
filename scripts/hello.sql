create function hello_world()
returns text
as $$ select 'Hello world!' $$
language sql;

select hello_world();

create function hello(name text)
returns text as $$
    select 'Hello ' || name || '!';
    $$
language sql;

select hello('Anvar');
drop function hello(text);

create function hello(text)
returns text as $$
    select 'Hello ' || $1 || '!';
    $$
language sql;


create function hello(IN name text, IN title text DEFAULT 'Mr')
returns text as $$
    select 'Hello ' || title || ' ' || name || '!';
    $$
language sql;

select hello('Anvar');
select hello('Alice', title := 'Mrs');
drop function hello(name text, title text);


create function hello(IN name text, IN title text DEFAULT 'Mr')
returns text as $$
    select 'Hello ' || title || ' ' || name || '!';
    $$
language sql STRICT;


select hello('Alice', Null);

drop function hello(name text, title text);

create function hello(in name text, out text)
as $$
    select 'Hello, ' || name || '!';
    $$
language sql;

select hello('Anvar');