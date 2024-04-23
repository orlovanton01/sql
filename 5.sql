create table audit(
c_name varchar(30),
c_time timestamp,
c_action varchar(30),
c_table varchar(30)
);

set term % ;

create trigger workers_insert for workers before insert
as begin
insert into audit values(current_user, current_timestamp, 'insert', 'workers');
end%
create trigger workers_update for workers before update
as begin
insert into audit values(current_user, current_timestamp, 'update', 'workers');
end%
create trigger workers_delete for workers before delete
as begin
insert into audit values(current_user, current_timestamp, 'delete', 'workers');
end%

create trigger posts_insert for posts before insert
as begin
insert into audit values(current_user, current_timestamp, 'insert', 'posts');
end%
create trigger posts_update for posts before update
as begin
insert into audit values(current_user, current_timestamp, 'update', 'posts');
end%
create trigger posts_delete for posts before delete
as begin
insert into audit values(current_user, current_timestamp, 'delete', 'posts');
end%

create trigger purchase_insert for purchase before insert
as begin
insert into audit values(current_user, current_timestamp, 'insert', 'purchase');
end%
create trigger purchase_delete for purchase before delete
as begin
insert into audit values(current_user, current_timestamp, 'delete', 'purchase');
end%

create trigger products_insert for products before insert
as begin
insert into audit values(current_user, current_timestamp, 'insert', 'products');
end%
create trigger products_delete for products before delete
as begin
insert into audit values(current_user, current_timestamp, 'delete', 'products');
end%

set term ; %

grant select on audit to director;
grant insert on audit to director;
commit;

grant select on audit to cashier;
grant insert on audit to cashier;
commit;