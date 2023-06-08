TRUNCATE TABLE users, properties, bookings RESTART IDENTITY;

INSERT INTO users (name, email, phone_number, password) VALUES ('Jane', 'jane@example.com', '07700123456', '$2a$12$rLQrmak9yjPTU8/O0YKARu3oq2MHLkZZAIMh/U9l6ztjRQfnDf2gi');

INSERT INTO properties (property_name, price, location, description, user_id) VALUES ('Beach House', 100, 'Cornwall', 'Lovely sea views.', 1);

INSERT INTO bookings (user_id, property_id, date, approved) VALUES (1, 1, '27 May 2023', false);
INSERT INTO bookings (user_id, property_id, date, approved) VALUES (1, 1, '12 June 2023', false);
INSERT INTO bookings (user_id, property_id, date, approved) VALUES (1, 1, '6 August 2023', false);
