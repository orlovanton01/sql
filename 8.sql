drop table if exists audit;

drop function if exists workers_function, posts_function, purchase_function, products_function cascade;

create table audit(
c_name varchar(30),
c_time timestamp,
c_action varchar(30),
c_table varchar(30)
);

create function workers_function() returns trigger
language plpgsql
as $$
declare
 argument varchar(30);
begin
 foreach argument in array tg_argv loop
  insert into audit values (current_user, current_timestamp, argument, 'workers');
 end loop;
 return new;
end;
$$;

create trigger workers_insert before insert on workers for each statement execute function workers_function('insert');
create trigger workers_delete before delete on workers for each statement execute function workers_function('delete');
create trigger workers_update before update on workers for each statement execute function workers_function('update');

create function posts_function() returns trigger
language plpgsql
as $$
declare
 argument varchar(30);
begin
 foreach argument in array tg_argv loop
  insert into audit values (current_user, current_timestamp, argument, 'posts');
 end loop;
 return new;
end;
$$;

create trigger posts_insert before insert on posts for each statement execute function posts_function('insert');
create trigger posts_delete before delete on posts for each statement execute function posts_function('delete');
create trigger posts_update before update on posts for each statement execute function posts_function('update');

create function purchase_function() returns trigger
language plpgsql
as $$
declare
 argument varchar(30);
begin
 foreach argument in array tg_argv loop
  insert into audit values (current_user, current_timestamp, argument, 'purchase');
 end loop;
 return new;
end;
$$;

create trigger purchase_insert before insert on purchase for each statement execute function purchase_function('insert');
create trigger purchase_delete before delete on purchase for each statement execute function purchase_function('delete');

create function products_function() returns trigger
language plpgsql
as $$
declare
 argument varchar(30);
begin
 foreach argument in array tg_argv loop
  insert into audit values (current_user, current_timestamp, argument, 'products');
 end loop;
 return new;
end;
$$;

create trigger products_insert before insert on products for each statement execute function products_function('insert');
create trigger products_delete before delete on products for each statement execute function products_function('delete');

grant select on public.audit to director;
grant insert on public.audit to director;

grant select on public.audit to cashier;
grant insert on public.audit to cashier;