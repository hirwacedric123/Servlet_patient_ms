-- Create database
CREATE DATABASE IF NOT EXISTS PMS;
USE PMS;

-- Users table
CREATE TABLE IF NOT EXISTS Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    UserType ENUM('Admin', 'Nurse', 'Doctor', 'Patient') NOT NULL
);

-- Patients table
CREATE TABLE IF NOT EXISTS Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Telephone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255),
    PImageLink VARCHAR(255),
    CreatedBy INT,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- Nurses table
CREATE TABLE IF NOT EXISTS Nurses (
    NurseID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Telephone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255),
    HealthCenter VARCHAR(100),
    UserID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Doctors table
CREATE TABLE IF NOT EXISTS Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Telephone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255),
    HospitalName VARCHAR(100),
    UserID INT UNIQUE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Diagnosis table
CREATE TABLE IF NOT EXISTS Diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    NurseID INT NOT NULL,
    DoctorID INT,
    DiagnoStatus ENUM('Referrable', 'Not Referrable') NOT NULL,
    Result VARCHAR(1000) DEFAULT 'Pending',
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (NurseID) REFERENCES Nurses(NurseID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Insert admin user
INSERT INTO Users (Username, Password, UserType) VALUES ('admin', 'admin123', 'Admin'); 