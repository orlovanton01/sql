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

drop user 'user1'@'localhost';
drop user 'user2'@'localhost'; 

create user 'user1'@'localhost';
create user 'user2'@'localhost';

create table rights(
 users varchar(30),
 p_id int #номер отдела, к которому пользователь имеет доступ
);

insert into rights values
 ('user1', 1),
 ('user2', 1),
 ('user2', 2),
 ('user2', 3);

create view users_dep as select d.* from dep d, rights r where r.p_id=d.d_id and r.users=left(user(), 5);

grant select on organization.users_dep to 'user1'@'localhost';
grant select on organization.users_dep to 'user2'@'localhost';

flush privileges;