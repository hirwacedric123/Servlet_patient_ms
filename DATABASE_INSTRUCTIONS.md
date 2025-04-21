# Database Setup Instructions

## Prerequisites
- MySQL Server 8.0 or higher
- MySQL Workbench (optional, but helpful for running scripts)

## Setup Steps

### 1. Install MySQL Server
If you don't have MySQL installed:
- Download from: https://dev.mysql.com/downloads/mysql/
- Follow the installation wizard
- Remember the root password you set during installation

### 2. Create the Database
- Open MySQL command line:
  ```
  mysql -u root -p
  ```
- When prompted, enter your MySQL root password
- Run the following command to create the database:
  ```
  CREATE DATABASE IF NOT EXISTS PMS;
  ```
- Exit the MySQL command line:
  ```
  exit
  ```

### 3. Run the Setup Script
- From the command line, navigate to the project directory
- Run the database setup script:
  ```
  mysql -u root -p PMS < database_setup.sql
  ```
- This will create all necessary tables and initial data

### 4. Verify Database Configuration in the Application
- Open the file: `src/main/java/com/pms/util/DBConnection.java`
- Ensure the database connection properties match your setup:
  ```java
  private static final String JDBC_URL = "jdbc:mysql://localhost:3306/pms?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
  private static final String USERNAME = "root";
  private static final String PASSWORD = "your-mysql-password"; // Change this to your MySQL password
  ```
- Update the PASSWORD value to match your MySQL root password

### 5. Test Database Connection
- After deploying the application
- Access the database test page at: http://localhost:8080/pms/dbtest
- This page will verify that the application can connect to the database

## Troubleshooting
- If you encounter connection issues, ensure:
  - MySQL service is running
  - The password in DBConnection.java matches your MySQL password
  - The port number is correct (default is 3306)
  - The database name is "PMS" (case-sensitive)