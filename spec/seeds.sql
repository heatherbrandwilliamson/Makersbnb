TRUNCATE TABLE users, properties, bookings RESTART IDENTITY;

INSERT INTO users (name, email, phone_number, password) VALUES ('Jane', 'jane@example.com', '07700123456', '$2a$12$rLQrmak9yjPTU8/O0YKARu3oq2MHLkZZAIMh/U9l6ztjRQfnDf2gi');
INSERT INTO users (name, email, phone_number, password) VALUES ('Bob', 'bob@example.com', '07712345657', '$2a$12$rLQrmak9yjPTU8/O0YKARu3oq2MHLkZZAIMh/U9l6ztjRQfnDf2gi');

INSERT INTO properties (property_name, price, location, description, user_id) VALUES ('Beach House', 100, 'Cornwall', 'Lovely sea views.', 1);
INSERT INTO properties (property_name, price, location, description, user_id) VALUES ('Mountain Cabin', 125, 'Scotland', 'Alpine landscapes.', 2);

INSERT INTO bookings (user_id, property_id, date, approved, host_id) VALUES (1, 1, '10 June 2023', false, 1);
INSERT INTO bookings (user_id, property_id, date, approved, host_id) VALUES (1, 1, '12 June 2023', true, 1);
INSERT INTO bookings (user_id, property_id, date, approved, host_id) VALUES (1, 1, '14 June 2023', false, 2);
