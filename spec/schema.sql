-- DROP TABLE users, properties, users_properties;

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
  user_id int,
  property_id int,
  date date,
  constraint fk_user foreign key(user_id) references users(id) on delete cascade,
  constraint fk_property foreign key(property_id) references properties(id) on delete cascade,
  PRIMARY KEY (user_id, property_id)
);
