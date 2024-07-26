CREATE DATABASE movie_db;

\c movie_db

CREATE TABLE Country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE File (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    key VARCHAR(255) UNIQUE NOT NULL,
    url VARCHAR(255) NOT NULL,
    is_public BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE User (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (avatar_id) REFERENCES File(id)
);

CREATE TABLE Person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(50) NOT NULL,
    country_id INT,
    primary_photo_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES Country(id),
    FOREIGN KEY (primary_photo_id) REFERENCES File(id)
);

CREATE TABLE Person_Photo (
    id SERIAL PRIMARY KEY,
    person_id INT NOT NULL,
    file_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE,
    FOREIGN KEY (file_id) REFERENCES File(id) ON DELETE CASCADE
);

CREATE TABLE Character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('leading', 'supporting', 'background'))
);

CREATE TABLE Movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    budget NUMERIC NOT NULL,
    release_date DATE NOT NULL,
    duration INT NOT NULL,
    director_id INT,
    country_id INT,
    poster_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (director_id) REFERENCES Person(id),
    FOREIGN KEY (country_id) REFERENCES Country(id),
    FOREIGN KEY (poster_id) REFERENCES File(id)
);

CREATE TABLE Movie_Genre (
    id SERIAL PRIMARY KEY,
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES Movie(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genre(id) ON DELETE CASCADE
);

CREATE TABLE Movie_Character_Actor (
    id SERIAL PRIMARY KEY,
    movie_id INT NOT NULL,
    character_id INT NOT NULL,
    actor_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES Movie(id) ON DELETE CASCADE,
    FOREIGN KEY (character_id) REFERENCES Character(id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES Person(id) ON DELETE CASCADE
);

CREATE TABLE Favorite_Movie (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movie(id) ON DELETE CASCADE
);

CREATE INDEX idx_person_country ON Person(country_id);
CREATE INDEX idx_person_photo ON Person(primary_photo_id);
CREATE INDEX idx_movie_director ON Movie(director_id);
CREATE INDEX idx_movie_country ON Movie(country_id);
CREATE INDEX idx_movie_poster ON Movie(poster_id);
CREATE INDEX idx_movie_genre_movie ON Movie_Genre(movie_id);
CREATE INDEX idx_movie_genre_genre ON Movie_Genre(genre_id);
CREATE INDEX idx_movie_character_actor_movie ON Movie_Character_Actor(movie_id);
CREATE INDEX idx_movie_character_actor_character ON Movie_Character_Actor(character_id);
CREATE INDEX idx_movie_character_actor_actor ON Movie_Character_Actor(actor_id);
CREATE INDEX idx_favorite_movie_user ON Favorite_Movie(user_id);
CREATE INDEX idx_favorite_movie_movie ON Favorite_Movie(movie_id);

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_updated_at
BEFORE UPDATE ON File
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();