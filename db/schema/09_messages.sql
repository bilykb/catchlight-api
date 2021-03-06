DROP TABLE IF EXISTS messages CASCADE;

CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  conversation_id INTEGER REFERENCES conversations(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  deleted BOOLEAN DEFAULT FALSE,
  created TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
)