CREATE DATABASE laravel_starter;
CREATE USER 'laravel_user'@'localhost' IDENTIFIED BY 'Laravel123!!!';
GRANT ALL PRIVILEGES ON laravel_starter.* TO 'laravel_user'@'localhost' IDENTIFIED BY 'Laravel123!!!';
FLUSH PRIVILEGES;