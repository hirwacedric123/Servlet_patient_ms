-- Drop existing tables if they exist
DROP TABLE IF EXISTS diagnosis;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS nurses;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS hospitals;

-- Create database
CREATE DATABASE IF NOT EXISTS PMS;
USE PMS;

-- Users table - consolidated table for all user types
CREATE TABLE IF NOT EXISTS Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    ContactNumber VARCHAR(20),
    Address VARCHAR(255),
    ProfileImage VARCHAR(255),
    Role ENUM('Admin', 'Nurse', 'Doctor', 'Patient') NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLogin TIMESTAMP NULL
);

-- User details table - for role-specific information
CREATE TABLE IF NOT EXISTS UserDetails (
    DetailID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    -- Patient specific fields
    DateOfBirth DATE NULL,
    Gender VARCHAR(10) NULL,
    BloodGroup VARCHAR(5) NULL,
    EmergencyContact VARCHAR(100) NULL,
    -- Healthcare provider specific fields
    Institution VARCHAR(100) NULL,
    Department VARCHAR(100) NULL,
    Specialization VARCHAR(100) NULL,
    LicenseNumber VARCHAR(50) NULL,
    -- Common fields
    Notes TEXT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Diagnosis table
CREATE TABLE IF NOT EXISTS Diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    NurseID INT NOT NULL,
    DoctorID INT NULL,
    Symptoms TEXT NULL,
    DiagnoStatus ENUM('Referrable', 'Not Referrable') NOT NULL,
    Result VARCHAR(1000) DEFAULT 'Pending',
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Users(UserID),
    FOREIGN KEY (NurseID) REFERENCES Users(UserID),
    FOREIGN KEY (DoctorID) REFERENCES Users(UserID)
);

-- Insert admin user
INSERT INTO Users (Username, Password, FirstName, LastName, Role) 
VALUES ('admin', '$2a$12$FxzZCJcfdyZ6gr0127IL.7mJFk0SVeYZ5Va9NqHLrK4uqzLZVTsy', 'System', 'Administrator', 'Admin');

-- Migrate existing user
INSERT INTO Users (Username, Password, FirstName, LastName, Role)
VALUES ('cedric', '$2a$12$b3etmFKYb4DwvtPdwKAr5eQCdJiyUKkPwtC9IrMCHA64JM1cs/312', 'Cedric', 'Patient', 'Patient');

-- Create indexes for performance
CREATE INDEX idx_user_role ON Users(Role);
CREATE INDEX idx_diagnosis_patient ON Diagnosis(PatientID);
CREATE INDEX idx_diagnosis_nurse ON Diagnosis(NurseID);
CREATE INDEX idx_diagnosis_doctor ON Diagnosis(DoctorID);
CREATE INDEX idx_diagnosis_status ON Diagnosis(DiagnoStatus); 