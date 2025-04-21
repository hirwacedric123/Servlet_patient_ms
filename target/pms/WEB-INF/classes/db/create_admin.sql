-- First, delete existing admin user if exists
DELETE FROM Users WHERE Username = 'admin';

-- Insert admin user with BCrypt hashed password (password: admin123)
INSERT INTO Users (Username, Password, Role, FirstName, LastName) 
VALUES ('admin', '$2a$12$0OmqkNNP.tGtGxPtxz1CC.sSNtqh.0lE.m7BHsWkb5m6Y6Bh5r7Aq', 'Admin', 'System', 'Administrator');

-- Make sure admin has correct role
UPDATE Users SET Role = 'Admin' WHERE Username = 'admin'; 