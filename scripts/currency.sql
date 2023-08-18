create type currency as (
    amount numeric,
    code text
);


create table transactions(
    account_id integer,
    debit currency,
    credit currency,
    date_entered date default current_date
);

insert into transactions values (1, null, '(100,"RUB")');
insert into transactions values (2, null, ROW(80,'RUB'));
insert into transactions values (3, null, (20,'RUB'));

select * from transactions;