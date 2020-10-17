-- Cкрипты создания структуры БД (с первичными ключами, индексами, внешними ключами) (часть 1)

CREATE DATABASE booking;

use booking;

-- Создаём таблицу пользователей
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

-- Таблица профилей
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя",
  birthday DATE COMMENT "Дата рождения",
  photo_id INT UNSIGNED COMMENT "Ссылка на фотографию пользователя",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

-- Таблица фотографий профилей пользователей
CREATE TABLE photo_profiles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Фото пользователей";

-- Таблица жилья
CREATE TABLE stays (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  type_stays_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип жилья",
  name VARCHAR(100) NOT NULL COMMENT "Название",
  city VARCHAR(100) NOT NULL COMMENT "Город расположения",
  reviews_id INT UNSIGNED COMMENT "Ссылка на отзывы",
  rating DECIMAL (4,1) COMMENT "Общий рейтинг жилья",
  star_rating INT UNSIGNED COMMENT "Количество звезд",
  main_settings_id INT UNSIGNED COMMENT "Ссылка на основные параметры",
  facilities_id INT UNSIGNED COMMENT "Ссылка на удобства",
  price DECIMAL (11,2) COMMENT "Цена в сутки",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "Жилье";
  
-- Таблица типов жилья
CREATE TABLE stays_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(100) NOT NULL COMMENT "Название типа жилья",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы жилья";

-- Таблица медиафайлов жилья
CREATE TABLE media_stays (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  stays_id INT UNSIGNED NOT NULL COMMENT "Ссылка на жилье, к которому относится файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы жилья";

-- Таблица типов медиафайлов жилья
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

-- Таблица отзывов и рейтингов
CREATE TABLE reviews_and_rating (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_name VARCHAR(100) NOT NULL COMMENT "Ссылка на имя пользователя, который написал отзыв",
  stays_id INT UNSIGNED NOT NULL COMMENT "Ссылка на жилье, к которому относится отзыв",
  body TEXT NOT NULL COMMENT "Текст отзыва",
  rating INT NOT NULL COMMENT "Рейтинг",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "Отзывы и рейтинги";

-- Таблица бронирования
CREATE TABLE booking (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  stays_id INT UNSIGNED NOT NULL COMMENT "Ссылка на жилье",
  check_in_date DATE COMMENT "Дата заезда",
  check_out_date DATE COMMENT "Дата выезда",
  price DECIMAL (11,2) COMMENT "Цена за время пребывания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "Бронирование";
 
-- Таблица удобств
CREATE TABLE facilities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  transfer VARCHAR(255) NOT NULL COMMENT "Наличие трансфера",
  wi_fi VARCHAR(255) NOT NULL COMMENT "Наличие вайфая",
  parking VARCHAR(255) NOT NULL COMMENT "Наличие парковки",
  pool VARCHAR(255) NOT NULL COMMENT "Наличие бассейна",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Наличие удобств";

-- Таблица типов питания
CREATE TABLE food (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  food_type VARCHAR(255) NOT NULL UNIQUE COMMENT "Тип питания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы питания";

-- Таблица типов удаленности от центра
CREATE TABLE distance_type_of_center (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  distance_type VARCHAR(255) NOT NULL UNIQUE COMMENT "Тип удаленности",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Удаленность от центра";

-- Таблица типов удаленности от пляжа
CREATE TABLE distance_type_of_beach (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  distance_type VARCHAR(255) NOT NULL UNIQUE COMMENT "Тип удаленности",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Удаленность от пляжа";

-- Таблица основных параметров
CREATE TABLE main_settings (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  food_id INT UNSIGNED NOT NULL COMMENT "Тип питания",
  distance_to_center_id INT UNSIGNED NOT NULL COMMENT "Тип удаленности от центра",
  distance_to_beach_id INT UNSIGNED NOT NULL COMMENT "Тип удаленности от пляжа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Основные параметры";


-- Работа с таблицей users
SELECT * FROM users;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;

-- Работа с таблицей profiles
SELECT * FROM profiles;
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;

-- Работа с таблицей booking
SELECT * FROM booking;
UPDATE booking SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE booking SET check_out_date = check_in_date + INTERVAL FLOOR(1 + (RAND() * 20)) DAY;
UPDATE booking SET price = DATEDIFF(check_out_date, check_in_date) * (SELECT price FROM stays WHERE stays_id = stays.id);

-- Работа с таблицей distance_type_of_beach
SELECT * FROM distance_type_of_beach;
UPDATE distance_type_of_beach SET updated_at = NOW() WHERE updated_at < created_at;

-- Работа с таблицей distance_type_of_center
SELECT * FROM distance_type_of_center;
UPDATE distance_type_of_center SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE distance_type_of_center SET distance_type = REPLACE (distance_type, '&lt;', '<');

-- Работа с таблицей facilities
SELECT * FROM facilities;
UPDATE facilities SET updated_at = NOW() WHERE updated_at < created_at;

-- Работа с таблицей food
SELECT * FROM food;
UPDATE food SET updated_at = NOW() WHERE updated_at < created_at;

-- Работа с таблицей photo_profiles
SELECT * FROM photo_profiles;
UPDATE photo_profiles SET updated_at = NOW() WHERE updated_at < created_at;

CREATE TEMPORARY TABLE extensions (name VARCHAR(20));
INSERT INTO extensions VALUES ('jpeg'), 
							  ('png');
SELECT * FROM extensions;

UPDATE photo_profiles SET filename = CONCAT(
  'https://dropbox.net/booking/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

UPDATE photo_profiles SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');


-- Работа с таблицей reviews_and_rating
SELECT * FROM reviews_and_rating;
UPDATE reviews_and_rating SET updated_at = NOW() WHERE updated_at < created_at;

ALTER TABLE reviews_and_rating ADD COLUMN user_id INT UNSIGNED NOT NULL AFTER id;
UPDATE reviews_and_rating SET user_id = FLOOR(1 + (RAND() * 100));
UPDATE reviews_and_rating SET user_name_id = (SELECT first_name FROM users WHERE reviews_and_rating.user_id = users.id);

-- Работа с таблицей stays
SELECT * FROM stays;
UPDATE stays SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE stays SET star_rating = NULL WHERE type_stays_id = 1 or type_stays_id = 4;
UPDATE stays SET rating = (select distinct AVG(rating) OVER(PARTITION BY stays_id) FROM reviews_and_rating where stays_id = stays.id);

-- Работа с таблицей stays_types
SELECT * FROM stays_types;
UPDATE stays_types SET updated_at = NOW() WHERE updated_at < created_at;

-- Работа с таблицей main_settings
SELECT * FROM main_settings;
UPDATE main_settings SET updated_at = NOW() WHERE updated_at < created_at;

-- Работа с таблицей media_stays
SELECT * FROM media_stays;
UPDATE media_stays SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE media_stays SET metadata = CONCAT('{"owner":"', 
  (SELECT name FROM stays WHERE id = stays_id),
  '"}');
  
  
  
-- Наполнение таблиц данными

anastasiya@anastasiya-VirtualBox:~$ mysql booking < dump_booking.sql  

  
 
