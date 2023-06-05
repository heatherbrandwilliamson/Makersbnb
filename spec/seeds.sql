TRUNCATE TABLE users, properties, users_properties RESTART IDENTITY; -- replace with your own table name.

INSERT INTO users (name, email, phone_number, password) VALUES ('Jane', 'jane@example.com', '07700123456', 'pass');

INSERT INTO properties (property_name, price, location, description, user_id) VALUES ('Beach House', 100, 'Cornwall', 'Lovely sea views.', 1);


--Seeds file created for both users and properties