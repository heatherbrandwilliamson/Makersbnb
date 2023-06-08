DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  phone_number text,
  password text
);

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  property_name text,
  location text,
  description text,
  price float,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  user_id int,
  property_id int,
  date date,
  approved boolean,
  host_id int,
  constraint fk_user foreign key(user_id) references users(id) on delete cascade,
  constraint fk_property foreign key(property_id) references properties(id) on delete cascade
);
