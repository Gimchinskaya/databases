-- Task 1

-- Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.

-- Поиск пользователей по имени, фамилии
CREATE INDEX users_first_name_last_name_idx ON users (first_name, last_name);

-- Поиск медиафайлов по названию и типу
CREATE INDEX media_filename_media_type_id_idx ON media (filename, media_type_id);

-- Поиск пользователей по городу и дате рождения
CREATE INDEX profiles_city_birthday_idx ON profiles (city, birthday);

-- Поиск сообщения по содержимому
CREATE INDEX messages_body_idx ON messages(body);


-- Task 2

/* Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
- имя группы
- среднее количество пользователей в группах
- самый молодой пользователь в группе
- самый старший пользователь в группе
- общее количество пользователей в группе
- всего пользователей в системе
- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100 */

SELECT DISTINCT communities.name AS communities_name, 
	COUNT(communities_users.user_id) OVER() / (SELECT COUNT(*) FROM communities) AS avg_users_in_communities,
	FIRST_VALUE(communities_users.user_id) OVER(PARTITION BY communities.id ORDER BY profiles.birthday DESC) AS the_youngest_user,
	FIRST_VALUE(communities_users.user_id) OVER(PARTITION BY communities.id ORDER BY profiles.birthday) AS oldest_user,
	COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) AS all_users_in_community,
	COUNT(profiles.user_id) OVER() AS total_users,
	COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) / COUNT(profiles.user_id) OVER() * 100 AS "%%"
		FROM communities
      	  JOIN communities_users
            ON communities.id = communities_users.community_id
          JOIN profiles
          	ON communities_users.user_id = profiles.user_id;