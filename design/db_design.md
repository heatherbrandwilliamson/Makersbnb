## 1. Extract nouns from the user stories or specification

### Guest

1. As a guest so I can reserve a space, I would like to register a account.

2. As a guest, when I register I would include an email address

3. As a guest, when I register I would include a phone number

4. As a guest so that I can book a space, I want to be able to request a booking for one night.

----

5. As a guest, I want to be able to see that spaces are only available for a given date.

6. As a guest, I want to receive an approval from the host for a request for booking.


### Host

1. As a host so I list a space, I would like register an account.

2. As a host when I register I would include an email address

3. As a host, when I register I would include a phone number

4. As a host so I can list my spaces, I would like to register multiple spaces.

5. As a host so that I can list my space, I would like to name my space.

6. As a host so that I can describe my space, I would like to add a description for my space.

7. As a host so that I can describe my space, I would like to add a price per a night.

----

8. As a host so that I can offer a range of dates, I would like to specify available dates.

9. As a host so that I can manage my bookings, I want to be able to approve guest bookings.

10. As a host I want to approve a guests request for a booking.


Nice haves:

Come back.

```
Nouns from user stories:

guest, host, phone number, email address, properties, property description, price per night, dates available, booking
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| users                 | name, email, password, phone number
| properties            | property name, description, location, price per night
| bookings              | user id, property id, date

1. Name of the first table (always plural): `users` 

    Column names: `name`, `email`, `password`, `phone_number`

2. Name of the second table (always plural): `properties` 

    Column names: `property_name`, `location`, `price`

<!-- 2. Name of the second table (always plural): `properties` 

Column names: `property_name`, `location`, `price` -->

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```

Table: users
id: SERIAL
name: text
email: text
password: text
phone_number: int

Table: properties
id: SERIAL
property_name: text
description: text
location: text
price: text
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one Host have many Properties? (Yes)
2. Can one Property have many Host? (Np)

You'll then be able to say that:

1. **Host has many Properties**
2. And on the other side, **properties belongs to User**
3. In that case, the foreign key is in the table `properties`

## 4. Write the SQL.

```sql
-- file: spec/table_shemas.sql

-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  password text,
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

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 makersbnb < spec/schema.sql
psql -h 127.0.0.1 makersbnb_test < spec/schema.sql
```
