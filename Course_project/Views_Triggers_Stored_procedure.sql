-- представления (минимум 2)
-- хранимые процедуры / триггеры

-- Представления

-- Представление, которое выводит название жилья и его тип
CREATE VIEW stays_stays_types AS SELECT s.name AS stays_name, st.name AS type_stays 
	FROM stays s 
		JOIN stays_types st 
			ON s.type_stays_id = st.id
	ORDER BY s.id;

SELECT * FROM stays_stays_types;

-- Представление, которое выводит название жилья и все его параметры
CREATE VIEW stays_and_parameters AS SELECT s.name AS stays_name, food.food_type, dtoc.distance_type AS distance_to_center, dtob.distance_type AS distance_to_beach, f.transfer, f.parking, f.wi_fi, f.pool 
	FROM stays s 
		JOIN main_settings ms 
			ON s.main_settings_id = ms.id 
		JOIN food
			ON ms.food_id = food.id
		JOIN distance_type_of_beach dtob 
			ON ms.distance_to_beach_id = dtob.id 
		JOIN distance_type_of_center dtoc 
			ON ms.distance_to_center_id = dtoc.id 
		JOIN facilities f 
			ON s.facilities_id = f.id;
		
SELECT * FROM stays_and_parameters;

-- Триггер обязательного заполнения поля email в таблице users

DELIMITER //

CREATE TRIGGER validate_email_insert BEFORE INSERT ON users
FOR EACH ROW BEGIN
  IF NEW.email IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Enter email!';
  END IF;
END//

DELIMITER ;

-- Пример срабатывания триггера
INSERT INTO users (first_name, last_name, email, phone) VALUES ('John', 'Jones', NULL, '123-123-345'); -- SQL Error [1644] [45000]: Enter email!



-- Хранимая процедура, выдающая все свободное жилье в городе на указанные даты

DELIMITER // 
CREATE PROCEDURE free_stays (city VARCHAR(100), check_in date, check_out date)
BEGIN
SELECT s.id, s.name, s.city, b.check_in_date, b.check_out_date 
	FROM stays s
		LEFT JOIN booking b
			ON s.id = b.stays_id
			where (check_in not BETWEEN b.check_in_date and b.check_out_date 
and check_out not BETWEEN b.check_in_date and b.check_out_date) and s.city = city
		ORDER BY s.id;
END //
DELIMITER ;


-- Вызов процедуры
CALL free_stays('New Bryon', '2016-05-10', '2016-05-15');

