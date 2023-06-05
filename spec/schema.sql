CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  phone_number int
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

CREATE TABLE users_properties (
  user_id int,
  property_id int,
  constraint fk_user foreign key(user_id) references users(id) on delete cascade,
  constraint fk_property foreign key(property_id) references properties(id) on delete cascade,
  PRIMARY KEY (user_id, property_id)
);