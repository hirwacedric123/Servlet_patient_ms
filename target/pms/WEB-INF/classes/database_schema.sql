-- Database schema for the Patient Management System

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS pms;
USE pms;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    UserType ENUM('Admin', 'Doctor', 'Nurse', 'Patient') NOT NULL
);

-- Create doctors table
CREATE TABLE IF NOT EXISTS doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT UNIQUE NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address TEXT,
    HospitalID INT,
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE
);

-- Create nurses table
CREATE TABLE IF NOT EXISTS nurses (
    NurseID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT UNIQUE NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address TEXT,
    HospitalID INT,
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE CASCADE
);

-- Create patients table
CREATE TABLE IF NOT EXISTS patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    DateOfBirth DATE,
    ContactNumber VARCHAR(20) NOT NULL,
    Address TEXT,
    BloodGroup VARCHAR(10),
    NurseID INT,
    Symptoms TEXT,
    IsReferrable BOOLEAN DEFAULT FALSE,
    PImageLink VARCHAR(255),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES users(UserID) ON DELETE SET NULL,
    FOREIGN KEY (NurseID) REFERENCES nurses(NurseID) ON DELETE SET NULL
);

-- Create diagnosis table
CREATE TABLE IF NOT EXISTS diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Diagnosis TEXT NOT NULL,
    Treatment TEXT,
    DiagnosisDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES patients(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES doctors(DoctorID) ON DELETE CASCADE
);

-- Create hospitals table
CREATE TABLE IF NOT EXISTS hospitals (
    HospitalID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address TEXT NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- Add foreign key constraints for HospitalID
ALTER TABLE doctors ADD FOREIGN KEY (HospitalID) REFERENCES hospitals(HospitalID) ON DELETE SET NULL;
ALTER TABLE nurses ADD FOREIGN KEY (HospitalID) REFERENCES hospitals(HospitalID) ON DELETE SET NULL;

-- Insert default admin user (password: admin123)
INSERT INTO users (Username, Password, UserType) 
VALUES ('admin', '$2a$12$FxzZCJcfdyZ6gr0127IL.7mJFk0SVeYZ5Va9NqHLrK4uqzLZVTsy', 'Admin')
ON DUPLICATE KEY UPDATE Username = 'admin';

-- Insert sample hospital
INSERT INTO hospitals (Name, Address, ContactNumber, Email)
VALUES ('General Hospital', '123 Main Street, Cityville', '123-456-7890', 'info@generalhospital.com')
ON DUPLICATE KEY UPDATE Name = 'General Hospital'; 