-- Insert admin user with BCrypt hashed password (Admin@123)
INSERT INTO Users (Username, Password, Role, FirstName, LastName) 
VALUES ('admin', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewqtXezPJhwqvxK2', 'Admin', 'System', 'Administrator')
ON DUPLICATE KEY UPDATE Password = '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewqtXezPJhwqvxK2';

-- Grant all necessary permissions to admin
UPDATE Users SET Role = 'Admin' WHERE Username = 'admin'; 