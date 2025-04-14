-- Check if the doctor already exists
SELECT * FROM doctors WHERE UserID = 4;

-- Insert a new doctor record for user cedric (UserID = 4) if it doesn't exist
INSERT INTO doctors (UserID, FirstName, LastName, Specialization, ContactNumber, Email, Address) 
SELECT 4, 'Cedric', 'Smith', 'Cardiology', '123-456-7890', 'cedric.smith@example.com', '123 Medical Ave, Cityville'
WHERE NOT EXISTS (SELECT 1 FROM doctors WHERE UserID = 4);

-- Verify the insertion
SELECT * FROM doctors WHERE UserID = 4; 