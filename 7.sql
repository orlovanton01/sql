revoke all on database shop from director, consultant, cashier, storekeeper, customer;
revoke all privileges on all tables in schema public from director, consultant, cashier, storekeeper, customer, dir, cons, cash, store, cus;
revoke usage on schema public from director, consultant, cashier, storekeeper, customer, dir, cons, cash, store, cus;

drop role if exists director, consultant, cashier, storekeeper, customer;

drop user if exists dir, cons, cash, store, cus;

create role director login;
create role consultant login;
create role cashier login;
create role storekeeper login;
create role customer login;

create user dir with password 'dir';
create user cons with password 'cons';
create user cash with password 'cash';
create user store with password 'store';
create user cus with password 'cus';

grant usage on schema public to director;
grant all on public.workers to director;
grant all on public.posts to director;
grant select on public.purchase to director;
grant select on public.products to director;

grant director to dir;

grant usage on schema public to consultant;
grant select on public.products to consultant;

grant consultant to cons;

grant usage on schema public to cashier;
grant insert, delete, select on public.purchase to cashier;
grant insert, delete, select on public.products to cashier;

grant cashier to cash;

grant usage on schema public to storekeeper;
grant select on public.products to storekeeper;

grant storekeeper to store;

grant usage on schema public to customer;
grant select on public.products to customer;

grant customer to cus;