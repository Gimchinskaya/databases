-- Практическое задание по теме “Оптимизация запросов”

-- Task 1
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, 
-- название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;

CREATE TABLE logs (
	created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
	table_name VARCHAR(255),
	primary_key_id INT NOT NULL,
	field_name_content VARCHAR(255)) ENGINE=Archive;
	
	
	
DROP TRIGGER IF EXISTS users_update;
delimiter //

CREATE TRIGGER users_update AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO logs values (NOW(), 'users', NEW.id, NEW.name);
END//

delimiter ;



DROP TRIGGER IF EXISTS catalogs_update;
delimiter //

CREATE TRIGGER catalogs_update AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
  INSERT INTO logs values (NOW(), 'catalogs', NEW.id, NEW.name);
END//

delimiter ;



DROP TRIGGER IF EXISTS products_update;
delimiter //

CREATE TRIGGER products_update AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO logs values (NOW(), 'products', NEW.id, NEW.name);
END//

delimiter ;