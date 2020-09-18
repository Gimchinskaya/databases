use vk;

-- Task 3
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT CASE 
		 WHEN
	      (SELECT COUNT(user_id) from likes where user_id in (SELECT user_id from profiles where gender = 'm')) > 
	      (SELECT COUNT(user_id) from likes where user_id in (SELECT user_id from profiles where gender = 'f'))
	     THEN 'man' else 'woman' END AS winner;


-- Task 4
-- Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).

SELECT COUNT(id) 
  FROM likes where user_id in (SELECT * FROM 
     (SELECT user_id
        FROM profiles
        order by birthday DESC
        LIMIT 10) as t);