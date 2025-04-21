-- Create database
CREATE DATABASE IF NOT EXISTS pms;
USE pms;

-- Create Doctors table
CREATE TABLE IF NOT EXISTS Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Address TEXT NOT NULL,
    HospitalName VARCHAR(100) DEFAULT 'General Hospital',
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Create Nurses table
CREATE TABLE IF NOT EXISTS Nurses (
    NurseID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Department VARCHAR(100),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Create Patients table
CREATE TABLE IF NOT EXISTS Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    BloodGroup VARCHAR(5),
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Address TEXT NOT NULL,
    EmergencyContact VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
); 