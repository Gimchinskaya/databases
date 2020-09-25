use vk;

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT profiles.gender, COUNT(*) AS total
	FROM profiles JOIN likes
		ON profiles.user_id = likes.user_id
	GROUP BY profiles.gender
	ORDER BY total DESC
    LIMIT 1;
	
	
-- 4. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT SUM(total_likes) 
  FROM(
  SELECT profiles.user_id, COUNT(likes.target_id) AS total_likes
    FROM profiles 
	  LEFT JOIN likes
		ON profiles.user_id = likes.target_id
			AND likes.target_type_id = 2
    GROUP BY profiles.user_id 
    ORDER BY profiles.birthday DESC 
    LIMIT 10)
   AS user_likes;	
   
   
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT CONCAT(first_name, ' ', last_name) AS user, COUNT(CONCAT(first_name, ' ', last_name)) as total
   FROM users 
   	JOIN likes
   		ON likes.user_id = users.id
   	JOIN media
   		ON media.user_id = users.id
   	JOIN messages
   		ON messages.from_user_id = users.id
   GROUP BY user   	
   ORDER BY total
   LIMIT 10;