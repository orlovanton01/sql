-- справочники

create table people(
p_id int,
p_surname varchar(30),
p_name varchar(30),
p_patronymic varchar(30)
);

insert into people values ('1','Ivanov','Alexander','Alexeyevich');
insert into people values ('2','Petrov','Sergey','Vasilievich');
insert into people values ('3','Sidirov','Dmitriy','Andreevich');
insert into people values ('4','Popov','Maxim','Mikhailovich');
insert into people values ('5','Smirnov','Victor','Vladimirovich');

create table d_posts(
d_p_id int,
d_post varchar(30),
d_salary int
);

insert into d_posts values ('1','director', 65000);--директор
insert into d_posts values ('2','consultant', 25000);--консультант
insert into d_posts values ('3','cashier', 20000);--кассир
insert into d_posts values ('4','storekeeper', 15000);--кладовщик

create table d_products(
d_pr_id int,
d_product varchar(30)
);

insert into d_products values (1,'T-shirt');--футболка
insert into d_products values (2,'sweatshirt');--толстовка
insert into d_products values (3,'trousers');--брюки(штаны)
insert into d_products values (4,'shirts');--шорты
insert into d_products values (5,'socks');--носки
insert into d_products values (6,'leggings');--легинсы
insert into d_products values (7,'jacket');--куртка
insert into d_products values (8,'windbreaker');--ветровка
insert into d_products values (9,'gloves');--перчатки
insert into d_products values (10,'sneakers');--кроссовки
insert into d_products values (11,'boots');--ботинки

create table manufacturers(
m_id int,
manufacturer varchar(30)
);

insert into manufacturers values (1,'Adidas');
insert into manufacturers values (2,'Columbia');
insert into manufacturers values (3,'Fila');
insert into manufacturers values (4,'Kappa');
insert into manufacturers values (5,'Nike');
insert into manufacturers values (6,'Puma');
insert into manufacturers values (7,'Reebok');
insert into manufacturers values (8,'Adidas');

-- сущности

create table workers(
w_id int primary key,
w_surname varchar(30),
w_name varchar(30),
w_patronymic varchar(30)
);

create table posts(
w_id int primary key,
p_id int,
post varchar(30),
salary varchar(30)
);

alter table posts add foreign key (w_id) references workers(w_id);

create table purchase(
ps_id int primary key,
c_id int,
w_id int,
dt varchar(30)
);

alter table purchase add foreign key (w_id) references workers(w_id);

create table products(
ps_id int primary key,
pr_name varchar(30),
pr_manufacturer varchar(30),
price int
);

alter table products add foreign key (ps_id) references purchase(ps_id);

--процедура

set term % ;

create procedure filling
as
declare i int=1;
declare s varchar(30);
declare n varchar(30);
declare p varchar(30);
declare p_i int;
declare pos int;
declare c_post varchar(30);
declare c_salary int;
declare c_i int;
declare w_i int;
declare y int;
declare m int;
declare d int;
declare m_v varchar(30);
declare dt_i varchar(30);
declare pr_i varchar(30);
declare m_i varchar(30);
declare pr_i_r int;
begin
 select floor(rand()*10)+1 from rdb$database into :pos;
 while (i<=10) do
 begin
  select p_surname from people where p_id=(select floor(rand()*5)+1 from rdb$database) into :s;
  select p_name from people where p_id=(select floor(rand()*5)+1 from rdb$database) into :n;
  select p_patronymic from people where p_id=(select floor(rand()*5)+1 from rdb$database) into :p;
  select floor(rand()*3)+2 from rdb$database into :p_i;
  if (:i=:pos) then
  begin
   insert into workers values (:i, :s, :n, :p);
   insert into posts values (:i, 1, 'director', 65000);
  end
  else
   begin
    select d_post from d_posts where d_p_id=:p_i into :c_post;
    select d_salary from d_posts where d_p_id=:p_i into :c_salary;
	insert into workers values (:i, :s, :n, :p);
    insert into posts values (:i, :p_i, :c_post, :c_salary);
   end
  i=i+1;
 end
 i=1;
 while (i<=100000) do
 begin
  select floor(rand()*1000)+1 from rdb$database into :c_i;
  select first 1* from (select w_id from posts where p_id=3 order by p_id) order by rand() into :w_i;
  select floor(rand()*24)+2000 from rdb$database into :y;
  select floor(rand()*12)+1 from rdb$database into :m;
  select floor(rand()*28)+1 from rdb$database into :d;
  if (:m>=1 and :m<=9) then
   begin
   m_v='0'||:m;
   dt_i=:d||'.'||:m_v||'.'||:y;
   end
  else
   dt_i=:d||'.'||:m||'.'||:y;
  insert into purchase values (:i, :c_i, :w_i, :dt_i);
  select d_product from d_products where d_pr_id=(select floor(rand()*11)+1 from rdb$database) into :pr_i;
  select manufacturer from manufacturers where m_id=(select floor(rand()*8)+1 from rdb$database) into :m_i;
  if (:pr_i='T-shirt') then
   select floor(rand()*11500)+500 from rdb$database into :pr_i_r;
  else if (:pr_i='sweatshirt') then
   select floor(rand()*23100)+900 from rdb$database into :pr_i_r;
  else if (:pr_i='trousers') then
   select floor(rand()*69300)+700 from rdb$database into :pr_i_r;
  else if (:pr_i='shirts') then
   select floor(rand()*13500)+500 from rdb$database into :pr_i_r;
  else if (:pr_i='socks') then
   select floor(rand()*5550)+150 from rdb$database into :pr_i_r;
  else if (:pr_i='leggings') then
   select floor(rand()*12400)+600 from rdb$database into :pr_i_r;
  else if (:pr_i='jacket' or :pr_i='windbreaker') then
   select floor(rand()*97500)+2500 from rdb$database into :pr_i_r;
  else if (:pr_i='gloves') then
   select floor(rand()*7450)+250 from rdb$database into :pr_i_r;
  else if (:pr_i='sneakers') then
   select floor(rand()*35300)+1700 from rdb$database into :pr_i_r;
  else if (:pr_i='boots') then
   select floor(rand()*22500)+3500 from rdb$database into :pr_i_r;
  insert into products values (:i, :pr_i, :m_i, :pr_i_r);
  i=i+1;
 end
end%

set term ; %

execute procedure filling;
commit;