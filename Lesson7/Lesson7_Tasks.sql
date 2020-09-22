show databases;

use example;

show tables;

-- Task_1

-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select * from users;


-- Создадим таблицу заказов
CREATE TABLE orders (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  product VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT into orders (user_id, product) values 
					(3, 'Table'),
					(5, 'Water');
					
SELECT * from orders;

-- Результирующий запрос

SELECT o.user_id, u.name, o.product from users u join orders o on u.id = o.id ORDER by user_id;



-- Task_2

-- Выведите список товаров products и разделов catalogs, который соответствует товару.


select * from catalogs;

UPDATE catalogs set value = 1 where value = 0;


-- Создадим таблицу продукции
CREATE TABLE products as select * from catalogs;
drop table products;

select * from products;

-- Создадим таблицу каталога, где поделим товары на скоропортящиеся (perishable) и долгого хранения (long storage)
DROP table catalogs;
CREATE TABLE catalogs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_id INT UNSIGNED NOT NULL,
  product_type VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT into catalogs (product_id, product_type) values 
					(2, 'long storage'),
					(4, 'perishable'),
					(3, 'perishable'),
					(1, 'long storage'),
					(6, 'perishable'),
					(5, 'long storage');
				
delete from catalogs;
				

-- Результирующий запрос
				
SELECT p.name, p.value, c.product_type from products p join catalogs c on p.id = c.product_id ORDER by product_type, name, value;


-- Task_3 (+)

-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

drop table flights;
drop table cities;

CREATE TABLE flights (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `from` VARCHAR(255),
  `to` VARCHAR(255)
);


CREATE TABLE cities (
  label VARCHAR(255),
  name VARCHAR(255)
);

INSERT into flights (`from`, `to`) values 
					('moskow', 'omsk'),
					('novgorod', 'kazan'),
					('irkutsk', 'moskow'),
					('omsk', 'irkutsk'),
					('moskow', 'kazan');
				
INSERT into cities (label, name) values 
					('moskow', 'Москва'),
					('irkutsk', 'Иркутск'),
					('novgorod', 'Новгород'),
					('kazan', 'Казань'),
					('omsk', 'Омск');
				
SELECT * from flights;
SELECT * from cities;


-- Результирующий запрос

SELECT f.id, c1.name as `from`, c2.name as `to`
FROM flights f 
  JOIN cities c1 ON f.`from`= c1.label
  JOIN cities c2 ON f.`to`= c2.label
ORDER BY id;