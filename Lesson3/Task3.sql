1. Расширение таблиц
	1.1 communities (добавить поля тип(с ссылкой на таблицу типов), количество участников)
		CREATE TABLE communities (
			id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
			name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
			community_type INT UNSIGNED NOT NULL COMMENT "Ссылка на тип группы",
			participants_value INT UNSIGNED NOT NULL COMMENT "Количество участников группы",
			created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
			updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
		) COMMENT "Группы";
	
	1.2 media_types (добавить поле формат)
		CREATE TABLE media_types (
			id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
			name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
			format VARCHAR(50) NOT NULL COMMENT "Название формата",
			created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
			updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
		) COMMENT "Типы медиафайлов";
		
2. Добавление таблиц
	
	2.1 Добавление по связи с communities таблицы community_types
		
		CREATE TABLE community_types (
			id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
			name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название типа (группа, сообщество, паблик)",
			created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
			updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
		) COMMENT "Типы групп";
		
3. Предложения по переформированию таблиц

	3.1 Таблицу messages изменить создать таблицы dialogs, dialogs_users, добавить дополнительные поля, переделать текущие
		CREATE TABLE dialogs (
			id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
			--dialog_profile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на профиль диалога",
			name VARCHAR(150) NOT NULL COMMENT "Название диалога",
			created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
			updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
		) COMMENT "Диалоги";
		
		CREATE TABLE dialogs_users (
			user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя", 
			dialog_id INT UNSIGNED NOT NULL COMMENT "Ссылка на диалог",
			created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
			updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
			PRIMARY KEY (dialog_id, user_id) COMMENT "Составной первичный ключ"
		) COMMENT "Профили диалогов, связь между участниками диалогов и диалогами";
		
		CREATE TABLE messages (
			id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
			dialog_id INT UNSIGNED NOT NULL COMMENT "Ссылка на диалог",
			body TEXT NOT NULL COMMENT "Текст сообщения",
			is_important BOOLEAN COMMENT "Признак важности",
			is_delivered BOOLEAN COMMENT "Признак доставки",
			created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
			updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
		) COMMENT "Сообщения";