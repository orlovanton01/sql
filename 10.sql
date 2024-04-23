drop database if exists parking;
create database parking;

use parking;

create table cars(
 c_num varchar(30) primary key,
 c_brand varchar(30),
 c_model varchar(30),
 c_owner varchar(30)
);

insert into cars values
("A000AA", "BMW", "X5", "Ivanov Ivan Ivanivoch"),
("B000BB", "Audi", "Q6", "Pupkin Vasiliy Vasilievich"),
("C000CC", "Toyota", "RAV4", "Pupkin Vasiliy Vasilievich"),
("S111SS", "Audi", "Q6", "Petrov Petr Ivanovich");

use parking;

create table pays(
 p_month int unsigned,
 p_year int unsigned,
 c_num varchar(30),
 p_sum int unsigned,
 p_payed_sum int unsigned,
 primary key(p_month, p_year, p_sum),
 foreign key (c_num) references cars(c_num)
);

insert into pays values
(11, 2020, "A000AA", 228, 228),
(11, 2020, "B000BB", 123, 120),
(11, 2020, "C000CC", 456, 400),
(11, 2020, "S111SS", 200, 300);

select sum(p_sum-p_payed_sum) as sum_debt from cars c, pays p where c.c_num=p.c_num and c.c_owner="Pupkin Vasiliy Vasilievich";