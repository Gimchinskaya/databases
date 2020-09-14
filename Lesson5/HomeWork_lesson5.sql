show databases;
use example;

show tables;

Drop table users;

-- lesson5 part 1

-- Task 1

create table users (
id serial,
name varchar(50) not null,
birthday date not null,
create_dt datetime,
update_dt datetime
);

insert into users values (null,'Bob', '1997-08-08', null, null),
						 (null,'John', '1999-05-10', null, null),
						 (null,'Ulya', '2010-03-15', null, null),
						 (null,'Jack', '2005-11-23', null, null),
						 (null,'Nastya', '1993-10-09', null, null);
						 

SELECT * from users;

UPDATE users set create_dt = now(), update_dt = now();


-- Task 2


create table users (
id serial,
name varchar(50) not null,
birthday date not null,
create_dt varchar(50),
update_dt varchar(50)
);

insert into users values (null,'Bob', '1997-08-08', '08.08.1997 8:10', '08.08.1997 8:13'),
						 (null,'John', '1999-05-10', '10.05.1999 12:40', '10.05.1999 12:45'),
						 (null,'Ulya', '2010-03-15', '15.03.2010 15:30', '15.03.2010 15:37'),
						 (null,'Jack', '2005-11-23', '23.11.2005 04:17', '23.11.2005 04:23'),
						 (null,'Nastya', '1993-10-09', '09.10.1993 23:22', '09.10.1993 23:28');

SELECT name, STR_TO_DATE(create_dt,'%d.%m.%Y %H:%i') AS create_dt FROM users;
UPDATE users set create_dt = STR_TO_DATE(create_dt,'%d.%m.%Y %H:%i'), update_dt = STR_TO_DATE(update_dt,'%d.%m.%Y %H:%i');

ALTER TABLE users MODIFY create_dt datetime;
ALTER TABLE users MODIFY update_dt datetime;

desc users;
SELECT * from users;


-- Task 3

Drop table storehouses_products;

create table storehouses_products (
	id serial,
	name varchar(70) not null,
	value int unsigned
);

insert into storehouses_products values 
					(null, 'sold', 0),
					(null, 'oil', 12),
					(null, 'kefir', 0),
					(null, 'milk', 5),
					(null, 'chocolate', 7),
					(null, 'bread', 0)
					;
				
				
select * from storehouses_products;
select * from storehouses_products order by case when value = 0 then 1 else 0 end, value;


-- Task 4 (+)

SELECT * from users where MONTHNAME(birthday) RLIKE 'August|May';

-- Task 5 (+)

Drop table if exists catalogs;

create table catalogs (
	id serial,
	name varchar(70) not null,
	value int unsigned
);

insert into catalogs values 
					(null, 'sold', 0),
					(null, 'oil', 12),
					(null, 'kefir', 0),
					(null, 'milk', 5),
					(null, 'chocolate', 7),
					(null, 'bread', 0)
					;
				
				
select * from catalogs;


SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id,5,1,2);

-- lesson5 part 2



-- Task 1

SELECT ROUND(AVG((TO_DAYS(NOW())-TO_DAYS(birthday)))/365.242199) as AVG_IN_AGE from users; -- in years

-- Task 2

SELECT name, birthday, DAYNAME(DATE_FORMAT(birthday, '2020-%m-%d')) AS weekday_now
from users; 

SELECT DAYNAME(DATE_FORMAT(birthday, '2020-%m-%d')) as now_birthday, count(DAYNAME(DATE_FORMAT(birthday, '2020-%m-%d'))) as count_dates
from users group by now_birthday ORDER BY count_dates;

-- Task 3 (+)

drop table numbers;

CREATE table numbers (
id serial,
value int
);


INSERT into numbers values (null, 1),
						   (null, 2),
						   (null, 3),
						   (null, 4),
						   (null, 5);
						  
SELECT exp(SUM(log(value))) as composition from numbers; 

