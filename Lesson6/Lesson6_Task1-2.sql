use vk;

show tables;

-- Task 1

-- Таблица лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');
 
 select * from target_types;

-- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;
 

-- Проверим
SELECT * FROM likes LIMIT 10;

-- Создадим таблицу постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Task 2

DESC profiles;
DESC user_statuses;


-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;
     
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_status_id_fk 
    FOREIGN KEY (user_status_id) REFERENCES user_statuses(id)
      ON DELETE SET NULL;

-- Изменяем тип столбца при необходимости
ALTER TABLE profiles DROP FOREIGN KEY profiles_user_status_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;
      
-- Для таблицы сообщений

-- Смотрим структуру таблицы
DESC messages;

-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id)
      ON DELETE RESTRICT;

-- Смотрим диаграмму отношений в DBeaver (ERDiagram)


-- Если нужно удалить
ALTER TABLE table_name DROP FOREIGN KEY constraint_name;



-- Смотрим структуру таблицы
DESC communities_users;

-- Добавляем внешние ключи
ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
     
     
-- Смотрим структуру таблицы
DESC friendships;

-- Добавляем внешние ключи
ALTER TABLE friendships
  ADD CONSTRAINT friendships_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT friendships_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT friendships_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
      ON DELETE RESTRICT;

     
DESC friendship_statuses;
select * from friendship_statuses;



-- Смотрим структуру таблицы
DESC likes;

-- Добавляем внешние ключи
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id)
      ON DELETE CASCADE;
     
     
-- Смотрим структуру таблицы
DESC media;

-- Добавляем внешние ключи
ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
      ON DELETE CASCADE;

     
 -- Смотрим структуру таблицы
DESC posts;

-- Добавляем внешние ключи
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT posts_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE SET NULL,
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
      ON DELETE CASCADE;