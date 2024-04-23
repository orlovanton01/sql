drop database if exists organization;
create database organization;

use organization;

create table dep(
 d_id int unsigned primary key,
 d_name varchar(30) not null
);

insert into dep values
(1, 'Sales'),
(2, 'Dev'),
(3, 'Testing');

use organization;

create table emp(
 e_id int unsigned primary key,
 e_name varchar(30) not null,
 salary float not null check (salary>0 and salary<=999999),
 d_id int unsigned not null,
 foreign key (d_id) references dep(d_id)
);

insert into emp values
(1, 'Ivanov', 10000, 1),
(2, 'Blinov', 20000, 2),
(3, 'Smirnov', 12000, 2),
(4, 'Rediskin', 14000, 3),
(5, 'Petrov', 14000, 3),
(6, 'Vodkin', 10000, 3);

select e_name, d_name, salary from dep d, emp e where d.d_id=e.d_id and salary>11000;
select d_name, avg(salary) as avg_salary, count(*) as cnt from dep d, emp e where d.d_id=e.d_id group by d_name;
select d_name
from
(
select d_name, count_salary
from
(select d_name, count(*) as count_salary from dep d, emp e where d.d_id=e.d_id group by d.d_id) id_count_salary
where
count_salary =
(select count_salary
from
(select count(*) as count_salary from dep d, emp e where d.d_id=e.d_id group by d.d_id desc limit 1) max_count_salary)
) name;
select e_id, e_name, salary-avg_salary as salary_diff from emp, (select avg(salary) as avg_salary from emp) name;