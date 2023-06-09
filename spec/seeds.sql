TRUNCATE TABLE users, properties, bookings RESTART IDENTITY;

INSERT INTO users (name, email, phone_number, password) VALUES ('Jane', 'jane@example.com', '07700123456', '$2a$12$rLQrmak9yjPTU8/O0YKARu3oq2MHLkZZAIMh/U9l6ztjRQfnDf2gi');
INSERT INTO users (name, email, phone_number, password) VALUES ('Bob', 'bob@example.com', '07712345657', '$2a$12$rLQrmak9yjPTU8/O0YKARu3oq2MHLkZZAIMh/U9l6ztjRQfnDf2gi');

INSERT INTO properties (property_name, price, location, description, image_url, user_id) VALUES ('Beach House', 100, 'Cornwall', 'Lovely sea views.', 'https://images.unsplash.com/photo-1615571022219-eb45cf7faa9d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80', 1);
INSERT INTO properties (property_name, price, location, description, image_url, user_id) VALUES ('Mountain Cabin', 125, 'Scotland', 'Alpine landscapes.', 'https://images.unsplash.com/photo-1609349093648-51d2ceb5a72a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2062&q=80', 2);

INSERT INTO bookings (user_id, property_id, date, approved, host_id) VALUES (1, 1, '10 June 2023', false, 1);
INSERT INTO bookings (user_id, property_id, date, approved, host_id) VALUES (1, 1, '12 June 2023', true, 1);
INSERT INTO bookings (user_id, property_id, date, approved, host_id) VALUES (1, 1, '14 June 2023', false, 2);
