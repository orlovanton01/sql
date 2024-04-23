-- create role director;
-- create role consultant;
-- create role cashier;
-- create role storekeeper;
-- create role customer;
-- commit;

-- create user dir password 'dir';
-- create user cons password 'cons';
-- create user cash password 'cash';
-- create user store password 'store';
-- create user cus password 'cus';
-- commit;

grant all on workers to director;
grant all on posts to director;
grant select on purchase to director;
grant select on products to director;
commit;

grant director to dir;
commit;

grant select on products to consultant;
commit;

grant consultant to cons;
commit;

grant insert, delete, select on purchase to cashier;
grant insert, delete, select on products to cashier;
commit;

grant cashier to cash;
commit;

grant select on products to storekeeper;
commit;

grant storekeeper to store;
commit;

grant select on products to customer;
commit;

grant customer to cus;
commit;