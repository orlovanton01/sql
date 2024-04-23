drop database if exists shop;
create database shop;

drop table if exists people, d_posts, d_products, manufacturers, workers, posts, purchase, products;

drop procedure if exists filling;

-- справочники

create table people(
p_id int,
p_surname varchar(30),
p_name varchar(30),
p_patronymic varchar(30)
);

insert into people values 
('1','Ivanov','Alexander','Alexeyevich'),
('2','Petrov','Sergey','Vasilievich'),
('3','Sidirov','Dmitriy','Andreevich'),
('4','Popov','Maxim','Mikhailovich'),
('5','Smirnov','Victor','Vladimirovich');

create table d_posts(
d_p_id int,
d_post varchar(30),
d_salary int
);

insert into d_posts values 
('1','director', 65000),--директор
('2','consultant', 25000),--консультант
('3','cashier', 20000),--кассир
('4','storekeeper', 15000);--кладовщик

create table d_products(
d_pr_id int,
d_product varchar(30)
);

insert into d_products values 
(1,'T-shirt'),--футболка
(2,'sweatshirt'),--толстовка
(3,'trousers'),--брюки(штаны)
(4,'shirts'),--шорты
(5,'socks'),--носки
(6,'leggings'),--легинсы
(7,'jacket'),--куртка
(8,'windbreaker'),--ветровка
(9,'gloves'),--перчатки
(10,'sneakers'),--кроссовки
(11,'boots');--ботинки

create table manufacturers(
m_id int,
manufacturer varchar(30)
);

insert into manufacturers values 
(1,'Adidas'),
(2,'Columbia'),
(3,'Fila'),
(4,'Kappa'),
(5,'Nike'),
(6,'Puma'),
(7,'Reebok'),
(8,'Adidas');

-- сущности

create table workers(
w_id int primary key,
w_surname varchar(30),
w_name varchar(30),
w_patronymic varchar(30)
);

create table posts(
w_id int primary key references workers(w_id),
p_id int,
post varchar(30),
salary varchar(30)
);

create table purchase(
ps_id int primary key,
c_id int,
w_id int references workers(w_id),
dt varchar(30)
);

create table products(
ps_id int primary key references purchase(ps_id),
pr_name varchar(30),
pr_manufacturer varchar(30),
price int
);

-- процедура

create procedure filling()
language plpgsql
as $$
declare 
i int=1;
s varchar(30);
n varchar(30);
p varchar(30);
p_i int;
pos int;
c_post varchar(30);
c_salary int;
c_i int;
w_i int;
y int;
m int;
d int;
m_v varchar(30);
dt_i varchar(30);
pr_i varchar(30);
m_i varchar(30);
pr_i_r int;
begin
 select floor(random()*10)+1 into pos;
 while (i<=10) loop
  select p_surname from people where p_id=(select floor(random()*5)+1) into s;
  select p_name from people where p_id=(select floor(random()*5)+1) into n;
  select p_patronymic from people where p_id=(select floor(random()*5)+1 ) into p;
  select floor(random()*3)+2 into p_i;
  if (i=pos) then
   insert into workers values (i, s, n, p);
   insert into posts values (i, 1, 'director', 65000);
  else
    select d_post from d_posts where d_p_id=p_i into c_post;
    select d_salary from d_posts where d_p_id=p_i into c_salary;
	insert into workers values (i, s, n, p);
    insert into posts values (i, p_i, c_post, c_salary);
  end if;
  i=i+1;
 end loop;
 i=1;
 while (i<=100000) loop
  select floor(random()*1000)+1 into c_i;
  select * from (select w_id from posts where p_id=3 order by p_id) as q order by random() limit 1 into w_i;
  select floor(random()*24)+2000 into y;
  select floor(random()*12)+1 into m;
  select floor(random()*28)+1 into d;
  if (m>=1 and m<=9) then
   m_v='0'||m;
   dt_i=d||'.'||m_v||'.'||y;
  else
   dt_i=d||'.'||m||'.'||y;
  end if;
  insert into purchase values (i, c_i, w_i, dt_i);
  select d_product from d_products where d_pr_id=(select floor(random()*11)+1) into pr_i;
  select manufacturer from manufacturers where m_id=(select floor(random()*8)+1 ) into m_i;
  if (pr_i='T-shirt') then
   select floor(random()*11500)+500 into pr_i_r;
  elsif (pr_i='sweatshirt') then
   select floor(random()*23100)+900 into pr_i_r;
  elsif (pr_i='trousers') then
   select floor(random()*69300)+700 into pr_i_r;
  elsif (pr_i='shirts') then
   select floor(random()*13500)+500 into pr_i_r;
  elsif (pr_i='socks') then
   select floor(random()*5550)+150 into pr_i_r;
  elsif (pr_i='leggings') then
   select floor(random()*12400)+600 into pr_i_r;
  elsif (pr_i='jacket' or pr_i='windbreaker') then
   select floor(random()*97500)+2500 into pr_i_r;
  elsif (pr_i='gloves') then
   select floor(random()*7450)+250 into pr_i_r;
  elsif (pr_i='sneakers') then
   select floor(random()*35300)+1700 into pr_i_r;
  elsif (pr_i='boots') then
   select floor(random()*22500)+3500 into pr_i_r;
  end if;
  insert into products values (i, pr_i, m_i, pr_i_r);
  i=i+1;
 end loop;
end $$;

call filling();