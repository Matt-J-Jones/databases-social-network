CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text,
  email_address text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);