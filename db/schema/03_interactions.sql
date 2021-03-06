DROP TABLE IF EXISTS interactions CASCADE;

CREATE TABLE interactions (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  media_id INTEGER REFERENCES media(id) ON DELETE CASCADE,
  rating VARCHAR(255) CHECK (rating IN ('like','dislike','meh', 'interest')) DEFAULT NULL,
  created DATE DEFAULT CURRENT_DATE NOT NULL,
  modified DATE DEFAULT CURRENT_DATE NOT NULL,
  UNIQUE(user_id, media_id)
);