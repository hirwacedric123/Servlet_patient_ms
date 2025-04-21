-- Use the pms database
USE pms;

-- Check if the hospitals table has any entries
SELECT COUNT(*) FROM hospitals;

-- If hospitals table is empty, add a sample hospital
INSERT INTO hospitals (Name, Address, ContactNumber, Email)
SELECT 'General Hospital', '123 Main Street, Cityville', '123-456-7890', 'info@generalhospital.com'
WHERE NOT EXISTS (SELECT 1 FROM hospitals LIMIT 1);

-- Get the hospital ID (should be 1 if this is the first hospital)
SET @hospital_id = (SELECT HospitalID FROM hospitals LIMIT 1);

-- Check if the doctor already exists
SELECT * FROM doctors WHERE UserID = 4;

-- If doctor doesn't exist, insert a new doctor record for user cedric (UserID = 4)
INSERT INTO doctors (UserID, FirstName, LastName, Specialization, ContactNumber, Email, Address, HospitalID) 
SELECT 4, 'Cedric', 'Smith', 'Cardiology', '123-456-7890', 'cedric.smith@example.com', '123 Medical Ave, Cityville', @hospital_id
WHERE NOT EXISTS (SELECT 1 FROM doctors WHERE UserID = 4);

-- Verify the insertion
SELECT * FROM doctors WHERE UserID = 4; 