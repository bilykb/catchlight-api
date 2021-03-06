DROP TABLE IF EXISTS friends CASCADE;

CREATE TABLE friends (
  id SERIAL PRIMARY KEY,
  sending_user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  recieving_user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  friendship BOOLEAN DEFAULT FALSE,
  friendship_pending BOOLEAN DEFAULT TRUE,
  created DATE DEFAULT CURRENT_DATE,
  modified DATE DEFAULT CURRENT_DATE,
  UNIQUE(sending_user_id, recieving_user_id)
);