-- Patient Management System Database Schema
-- Create database
CREATE DATABASE IF NOT EXISTS pms;
USE pms;

-- Drop existing tables (in the correct order to avoid foreign key constraint issues)
DROP TABLE IF EXISTS Diagnosis;
DROP TABLE IF EXISTS Nurses;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS UserDetails;
DROP TABLE IF EXISTS Admins;
DROP TABLE IF EXISTS Users;

-- Users table
CREATE TABLE IF NOT EXISTS Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL, -- 'Admin', 'Doctor', 'Nurse', 'Patient'
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    ContactNumber VARCHAR(20),
    Address VARCHAR(255),
    ProfileImage VARCHAR(255)
);

-- UserDetails table for additional user information
CREATE TABLE IF NOT EXISTS UserDetails (
    UserID INT PRIMARY KEY,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    BloodGroup VARCHAR(5),
    EmergencyContact VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Admins table
CREATE TABLE IF NOT EXISTS Admins (
    AdminID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Doctors table
CREATE TABLE IF NOT EXISTS Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100),
    Email VARCHAR(100),
    ContactNumber VARCHAR(20),
    Address VARCHAR(255),
    HospitalName VARCHAR(100),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Nurses table
CREATE TABLE IF NOT EXISTS Nurses (
    NurseID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    telephone VARCHAR(20),
    address VARCHAR(255),
    healthcenter VARCHAR(100),
    Department VARCHAR(100),
    RegisteredByDoctorID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (RegisteredByDoctorID) REFERENCES Doctors(DoctorID) ON DELETE SET NULL
);

-- Diagnosis table
CREATE TABLE IF NOT EXISTS Diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    NurseID INT NOT NULL,
    DoctorID INT,
    DiagnoStatus VARCHAR(20) NOT NULL, -- 'Referrable' or 'Not Referrable'
    Result VARCHAR(255), -- 'Pending' or result text
    Symptoms TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (NurseID) REFERENCES Nurses(NurseID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE SET NULL
);

-- Insert default admin user
INSERT INTO Admins (Username, Password, FirstName, LastName)
VALUES ('admin', '$2a$10$QXmYGmUa1Oj1kDqGTbC4YObSZ6fO1ZI2PuTDN09/jQh0tL1H9LJ8e', 'System', 'Administrator'); -- Password: admin123

-- Sample data for testing
-- Insert a sample Doctor user
INSERT INTO Users (Username, Password, Role, FirstName, LastName, Email, ContactNumber, Address)
VALUES ('doctor1', '$2a$10$QXmYGmUa1Oj1kDqGTbC4YObSZ6fO1ZI2PuTDN09/jQh0tL1H9LJ8e', 'Doctor', 'John', 'Doe', 'doctor1@example.com', '123-456-7890', '123 Main St');

-- Insert doctor details
INSERT INTO Doctors (UserID, FirstName, LastName, Specialization, Email, ContactNumber, Address, HospitalName)
VALUES (LAST_INSERT_ID(), 'John', 'Doe', 'Cardiology', 'doctor1@example.com', '123-456-7890', '123 Main St', 'General Hospital');

-- Insert a sample Nurse user
INSERT INTO Users (Username, Password, Role, FirstName, LastName, Email, ContactNumber, Address)
VALUES ('nurse1', '$2a$10$QXmYGmUa1Oj1kDqGTbC4YObSZ6fO1ZI2PuTDN09/jQh0tL1H9LJ8e', 'Nurse', 'Jane', 'Smith', 'nurse1@example.com', '123-456-7891', '456 Oak Ave');

-- Insert nurse details
INSERT INTO Nurses (UserID, FirstName, LastName, Email, telephone, address, healthcenter)
VALUES (LAST_INSERT_ID(), 'Jane', 'Smith', 'nurse1@example.com', '123-456-7891', '456 Oak Ave', 'Community Clinic');

-- Insert a sample Patient user
INSERT INTO Users (Username, Password, Role, FirstName, LastName, Email, ContactNumber, Address)
VALUES ('patient1', '$2a$10$QXmYGmUa1Oj1kDqGTbC4YObSZ6fO1ZI2PuTDN09/jQh0tL1H9LJ8e', 'Patient', 'Bob', 'Johnson', 'patient1@example.com', '123-456-7892', '789 Pine St');

-- Insert patient details
INSERT INTO UserDetails (UserID, DateOfBirth, Gender, BloodGroup)
VALUES (LAST_INSERT_ID(), '1985-05-15', 'Male', 'O+'); 