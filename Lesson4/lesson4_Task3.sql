-- Предложения по формированию лайков и постов

/* Таблица лайков; 
 * В случае установки лайка в дальнейшем предполагается создание строки в таблице лайков, 
 * в случае удаления пользователем своего лайка - установка признака дизлайк
   Данный подход позволяет меньше тратить времени на удаление уже имеющегося лайка, 
   в случае его повторной установки просто изменится значение флага is_positive 
*/
CREATE TABLE likes (
  content_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента(медиа, сообщения, посты)",
  content_id INT UNSIGNED NOT NULL COMMENT "Ссылка на идентификатор контента в группе своего типа",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, установившего лайк",
  is_positive BOOLEAN COMMENT "Признак лайка(возможные значения 0 и 1, где 0 - дизлайк своего лайка)",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, content_id, content_type_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица лайков";


-- Вспомогательная таблица контента; содержит следующие типы: 'message','media','post' - помечаемые лайками
CREATE TABLE content_types ( 
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  content_type_name VARCHAR(20) NOT NULL UNIQUE COMMENT "Название типа контента",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица типов контента";

-- Таблица постов;
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  post_body TEXT NOT NULL COMMENT "Текст поста",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, написавшего пост",
  is_groups BOOLEAN DEFAULT false COMMENT "Признак принадлежности поста(возможные значения 0 и 1, где 0 - пост на стене, 1 - пост в сообществе(группе))",
  group_id INT UNSIGNED DEFAULT 0 COMMENT "Ссылка на группу, в которой находится пост, заполняется положительными значениями в случае принадлежности к сообщестсву(группе), иначе имеет значение 0",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица постов";