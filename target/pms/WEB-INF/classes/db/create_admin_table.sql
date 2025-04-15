-- Create a separate admin table
CREATE TABLE IF NOT EXISTS Admins (
    AdminID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin (username: admin, password: admin123)
INSERT INTO Admins (Username, Password, FirstName, LastName)
VALUES ('admin', 'admin123', 'System', 'Administrator')
ON DUPLICATE KEY UPDATE Password = 'admin123'; 