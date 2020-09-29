-- Практическое задание по теме “Транзакции, переменные, представления”

-- Task 1
-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

CREATE database sample;

use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';


START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;


-- Task 2
-- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW prod_cat AS SELECT products.name, catalogs.name as catalog_name
  FROM products 
    JOIN catalogs
      ON products.catalog_id = catalogs.id;
     
SELECT * FROM prod_cat;



-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- Task 1
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
delimiter //
CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			RETURN 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			RETURN 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			RETURN 'Добрый вечер';
		ELSE
			RETURN 'Доброй ночи';
	END CASE;
END //
delimiter ;
	
SELECT hello();


-- Task 2
-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS not_null;
delimiter //

CREATE TRIGGER not_null BEFORE INSERT ON products
FOR EACH ROW BEGIN
  IF (NEW.name IS NULL AND NEW.description IS NULL) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The fields "name" and "description" cannot be null at the same time!';
  END IF;
END//
delimiter ;

INSERT INTO products (name, description) VALUES (NULL, NULL); -- SQL Error [1644] [45000]: The fields "name" and "description" cannot be null at the same time!
INSERT INTO products (name, description) VALUES (NULL, 'Процессор для настольных персональных компьютеров, основанных на платформе Intel'); -- +