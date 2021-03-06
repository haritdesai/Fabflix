DELIMITER $$

CREATE PROCEDURE add_movie(IN movie_title VARCHAR(100), IN movie_year INT, IN movie_director VARCHAR(100), 
	IN movie_banner_url VARCHAR(200), IN movie_trailer_url VARCHAR(200),
	IN star_first VARCHAR(50), IN star_last VARCHAR(50), 
	IN genre_name VARCHAR(32))

BEGIN
	
	DECLARE in_movies INT DEFAULT 0;
	DECLARE in_stars INT DEFAULT 0;
	DECLARE in_genres INT DEFAULT 0;
	DECLARE in_stars_in_movies INT DEFAULT 0;
	DECLARE in_genres_in_movies INT DEFAULT 0;

	DECLARE _movie_id INT;
	DECLARE _star_id INT;
	DECLARE _genre_id INT;

	SELECT COUNT(*) INTO in_movies FROM movies WHERE title = movie_title;
	SELECT COUNT(*) INTO in_stars FROM stars WHERE first_name = star_first AND last_name = star_last;
	SELECT COUNT(*) INTO in_genres FROM genres WHERE name = genre_name;
    
	IF (in_movies < 1) THEN
		INSERT INTO movies (title,year,director,banner_url,trailer_url) VALUES (movie_title,movie_year,movie_director,movie_banner_url,movie_trailer_url);
	ELSE
		IF (movie_year != -1) THEN
			UPDATE movies SET year = movie_year WHERE title = movie_title;
		END IF;
		IF (movie_director != '') THEN
			UPDATE movies SET director = movie_director WHERE title = movie_title;
		END IF;
        IF (movie_banner_url != '') THEN
			UPDATE movies SET banner_url = movie_banner_url WHERE title = movie_title;
		END IF;
        IF (movie_trailer_url != '') THEN
			UPDATE movies SET trailer_url = movie_trailer_url WHERE title = movie_title;
		END IF;
	END IF;

	IF (in_stars < 1) THEN
		IF (star_first != '' OR star_last != '') THEN
			IF (star_first != '' AND star_last = '') THEN
				INSERT INTO stars (last_name) VALUES (first_name);
			ELSE
				INSERT INTO stars (first_name,last_name) VALUES (star_first, star_last);
			END IF;
		END IF;
	END IF;

	IF (in_genres < 1) THEN
		IF (genre_name != '') THEN
			INSERT INTO genres (name) VALUES (genre_name);
		END IF;
	END IF;

	SELECT id INTO _movie_id FROM movies WHERE title = movie_title;
	IF (star_first != '' OR star_last != '') THEN
		SELECT id INTO _star_id FROM stars WHERE first_name = star_first AND last_name = star_last;
		SELECT COUNT(*) INTO in_stars_in_movies FROM stars_in_movies WHERE star_id = _star_id AND movie_id = _movie_id;
		IF (in_stars_in_movies < 1) THEN
			INSERT INTO stars_in_movies (star_id,movie_id) VALUES (_star_id, _movie_id);
		END IF;
    END IF;
    IF (genre_name != '') THEN
		SELECT id INTO _genre_id FROM genres WHERE name = genre_name;
		SELECT COUNT(*) INTO in_genres_in_movies FROM genres_in_movies WHERE genre_id = _genre_id AND movie_id = _movie_id;
		IF (in_genres_in_movies < 1) THEN
			INSERT INTO genres_in_movies (genre_id,movie_id) VALUES (_genre_id, _movie_id);
		END IF;
	END IF;
END $$

DELIMITER ;
