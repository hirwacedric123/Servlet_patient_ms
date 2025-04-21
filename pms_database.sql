-- Patient Management System (PMS) - Consolidated Database Schema
-- This file contains all required database schema definitions and initial data

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS pms;
USE pms;

-- Drop existing tables if they exist (in the correct order to avoid foreign key constraints)
DROP TABLE IF EXISTS diagnosis;
DROP TABLE IF EXISTS nurses;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS userdetails;
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS users;

-- Create Users table - consolidated table for all user types
CREATE TABLE IF NOT EXISTS users (
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

-- Create UserDetails table - for additional user information
CREATE TABLE IF NOT EXISTS userdetails (
    UserID INT PRIMARY KEY,
    DateOfBirth DATE NULL,
    Gender VARCHAR(10) NULL,
    BloodGroup VARCHAR(5) NULL,
    EmergencyContact VARCHAR(50) NULL,
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE
);

-- Create Admins table
CREATE TABLE IF NOT EXISTS admins (
    AdminID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Create Doctors table
CREATE TABLE IF NOT EXISTS doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100),
    Email VARCHAR(100),
    ContactNumber VARCHAR(20),
    Address VARCHAR(255),
    HospitalName VARCHAR(100),
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE
);

-- Create Nurses table
CREATE TABLE IF NOT EXISTS nurses (
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
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (RegisteredByDoctorID) REFERENCES doctors(DoctorID) ON DELETE SET NULL
);

-- Create Diagnosis table
CREATE TABLE IF NOT EXISTS diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    NurseID INT NOT NULL,
    DoctorID INT,
    DiagnoStatus VARCHAR(20) NOT NULL, -- 'Referrable' or 'Not Referrable'
    Result VARCHAR(255), -- 'Pending' or result text
    Symptoms TEXT,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (NurseID) REFERENCES nurses(NurseID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES doctors(DoctorID) ON DELETE SET NULL
);

-- Create indexes for performance optimization
CREATE INDEX idx_user_role ON users(Role);
CREATE INDEX idx_diagnosis_patient ON diagnosis(PatientID);
CREATE INDEX idx_diagnosis_nurse ON diagnosis(NurseID);
CREATE INDEX idx_diagnosis_doctor ON diagnosis(DoctorID);

-- Insert default admin user with BCrypt hashed password (password: admin123)
INSERT INTO users (Username, Password, Role, FirstName, LastName) 
VALUES ('admin', '$2a$12$FxzZCJcfdyZ6gr0127IL.7mJFk0SVeYZ5Va9NqHLrK4uqzLZVTsy', 'Admin', 'System', 'Administrator');

-- Insert a sample patient user (username: cedric, password is hashed)
INSERT INTO users (Username, Password, Role, FirstName, LastName, Email, ContactNumber, Address)
VALUES ('cedric', '$2a$12$b3etmFKYb4DwvtPdwKAr5eQCdJiyUKkPwtC9IrMCHA64JM1cs/312', 'Patient', 'Cedric', 'Patient', 'cedric@example.com', '0790250425', 'Gahanga Kicukiro');

-- You may add sample data below for testing purposes
-- Note: These are commented out for production, uncomment if needed for testing

/*
-- Insert a sample Doctor
INSERT INTO users (Username, Password, Role, FirstName, LastName, Email, ContactNumber, Address)
VALUES ('doctor1', '$2a$12$FxzZCJcfdyZ6gr0127IL.7mJFk0SVeYZ5Va9NqHLrK4uqzLZVTsy', 'Doctor', 'John', 'Doe', 'doctor1@example.com', '123-456-7890', '123 Main St');

INSERT INTO doctors (UserID, FirstName, LastName, Specialization, Email, ContactNumber, Address, HospitalName)
VALUES (LAST_INSERT_ID(), 'John', 'Doe', 'Cardiology', 'doctor1@example.com', '123-456-7890', '123 Main St', 'General Hospital');

-- Insert a sample Nurse
INSERT INTO users (Username, Password, Role, FirstName, LastName, Email, ContactNumber, Address)
VALUES ('nurse1', '$2a$12$FxzZCJcfdyZ6gr0127IL.7mJFk0SVeYZ5Va9NqHLrK4uqzLZVTsy', 'Nurse', 'Jane', 'Smith', 'nurse1@example.com', '123-456-7891', '456 Oak Ave');

INSERT INTO nurses (UserID, FirstName, LastName, Email, telephone, address, healthcenter)
VALUES (LAST_INSERT_ID(), 'Jane', 'Smith', 'nurse1@example.com', '123-456-7891', '456 Oak Ave', 'Community Clinic');

-- Add patient details for Cedric (if needed)
INSERT INTO userdetails (UserID, DateOfBirth, Gender, BloodGroup)
VALUES (2, '2010-01-20', 'Male', 'O+');
*/ 