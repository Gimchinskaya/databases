-- Cкрипты создания структуры БД (с первичными ключами, индексами, внешними ключами) (часть 2)

-- Внешние ключи

DESC profiles;
DESC users;
DESC photo_profiles;


ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES photo_profiles(id)
      ON DELETE SET NULL;
      
DESC booking;

ALTER TABLE booking
  ADD CONSTRAINT booking_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT booking_stays_id_fk
    FOREIGN KEY (stays_id) REFERENCES stays(id)
      ON DELETE CASCADE;
      
DESC main_settings;

ALTER TABLE main_settings
  ADD CONSTRAINT main_settings_food_id_fk 
    FOREIGN KEY (food_id) REFERENCES food(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT main_settings_distance_to_center_id_fk
    FOREIGN KEY (distance_to_center_id) REFERENCES distance_type_of_center(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT main_settings_distance_to_beach_id_fk
    FOREIGN KEY (distance_to_beach_id) REFERENCES distance_type_of_beach(id)
      ON DELETE CASCADE;
     
DESC media_stays;

ALTER TABLE media_stays
  ADD CONSTRAINT media_stays_stays_id_fk
    FOREIGN KEY (stays_id) REFERENCES stays(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT media_stays_media_type_id_fk
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
      ON DELETE CASCADE;

DESC photo_profiles;

ALTER TABLE photo_profiles
  ADD CONSTRAINT photo_profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE RESTRICT;
     
DESC reviews_and_rating;

ALTER TABLE reviews_and_rating
  ADD CONSTRAINT reviews_and_rating_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE RESTRICT,
  ADD CONSTRAINT reviews_and_rating_stays_id_fk
    FOREIGN KEY (stays_id) REFERENCES stays(id)
      ON DELETE CASCADE;

     
DESC stays;

ALTER TABLE stays
  ADD CONSTRAINT stays_type_stays_id_fk
    FOREIGN KEY (type_stays_id) REFERENCES stays_types(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT stays_reviews_id_fk
    FOREIGN KEY (reviews_id) REFERENCES reviews_and_rating(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT stays_main_settings_id_fk
    FOREIGN KEY (main_settings_id) REFERENCES main_settings(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT stays_facilities_id_fk
    FOREIGN KEY (facilities_id) REFERENCES facilities(id)
      ON DELETE CASCADE;


	  
-- Индексы

-- Поиск по городу
CREATE INDEX stays_city_idx ON stays (city);

-- Поиск по городу и цене
CREATE INDEX stays_city_price_idx ON stays (city, price);

-- Поиск по удаленности от ценра/пляжа
CREATE INDEX main_settings_distance_to_center_id_idx ON main_settings (distance_to_center_id);
CREATE INDEX main_settings_distance_to_beach_id_idx ON main_settings (distance_to_beach_id);

-- Поиск по типу питания и удаленности от пляжа
CREATE INDEX main_settings_food_id_distance_to_beach_id_idx ON main_settings (food_id, distance_to_beach_id);

-- Поиск по названию жилья
CREATE INDEX stays_name_idx ON stays (name);

-- Поиск по городу и количеству звезд
CREATE INDEX stays_city_star_rating_idx ON stays (city, star_rating);

-- Поиск по городу и типу жилья
CREATE INDEX stays_city_type_stays_id_idx ON stays (city, type_stays_id);