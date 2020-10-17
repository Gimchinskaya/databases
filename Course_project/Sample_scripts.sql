-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы)


-- Определить какого типа жильё чаще бронируют  
SELECT 
	(SELECT 
		(SELECT name FROM stays_types WHERE id = stays.type_stays_id) FROM stays WHERE id = booking.stays_id) AS stays_type, 
	COUNT(*) AS total_bookings 
	FROM booking
	GROUP BY stays_type
	ORDER BY total_bookings DESC 
	LIMIT 1;


-- Определить число броней десятка самого дорогого жилья
SELECT SUM(bookings) FROM
	(SELECT 
		(SELECT COUNT(*) FROM booking WHERE stays_id = stays.id) AS bookings 
		FROM stays 
		ORDER BY price 
		DESC LIMIT 10) AS total_bookings;


-- Вывести имена и фамилии пользователей, которые забронировали жилье
SELECT u.first_name, u.last_name, b.stays_id
	FROM users u
		JOIN booking b 
			ON u.id = b.user_id;



-- Вывести список 5-звездочных отелей, расположенных на 1 линии
SELECT s.id, s.name AS hotel_name, s.city, s.star_rating, dtob.distance_type
	FROM stays s 
		JOIN stays_types st 
			ON s.type_stays_id = st.id
		JOIN main_settings ms 
			ON s.main_settings_id = ms.id 
			JOIN distance_type_of_beach dtob 
				ON ms.distance_to_beach_id = dtob.id
	WHERE st.name = 'hotel' AND s.star_rating = 5 AND dtob.distance_type = '1 line';



-- Вывести количество броней каждого жилья
SELECT s.id, s.name AS hotel_name, COUNT(b.created_at) AS total_bookings
  FROM stays s 
    LEFT JOIN booking b 
      ON s.id = b.stays_id
  GROUP BY s.id
  ORDER BY total_bookings DESC;
 
 
-- Вывести количество отелей с типом питания FB
SELECT count(*) AS number_of_stays FROM 
(SELECT s.id AS id, s.name AS stays_name, f.food_type AS food_type
	FROM stays s 
		JOIN main_settings ms 
			ON s.main_settings_id = ms.id 
		JOIN food f 
			ON ms.food_id = f.id
	 WHERE f.food_type = 'FB'
	GROUP BY s.id) t;
 

