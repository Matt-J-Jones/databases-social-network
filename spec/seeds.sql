TRUNCATE TABLE users, posts RESTART IDENTITY;

INSERT INTO users (username, email_address) VALUES 
('SparkleLioness', 'SparkleLioness1234@gmail.com'),
('NeonUnicorn12', 'NeonUnicorn12@yahoo.com'),
('ElectricPenguin', 'ElectricPenguin77@outlook.com'),
('CosmicKitten', 'CosmicKitten99@gmail.com'),
('TigerStripedFox', 'TigerStripedFox55@hotmail.com');

INSERT INTO posts (title, content, views, user_id) VALUES 
('Happy Friday!', 'TGIF everyone!', '254886', '1'),
('Travel Dreams', 'Wanderlust taking over my soul.', '12345', '2'),
('Yum!', 'Pizza and Netflix tonight', '987', '3'),
('Nature Walk', 'Breathing in fresh air', '5432', '4'),
('Fitness Journey', 'Day 1 of workout challenge', '12', '5');