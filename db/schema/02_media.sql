DROP TABLE IF EXISTS media CASCADE;

CREATE TABLE media (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL UNIQUE,
  description TEXT NOT NULL,
  image TEXT, 
  imdb_id VARCHAR(255) NOT NULL
);