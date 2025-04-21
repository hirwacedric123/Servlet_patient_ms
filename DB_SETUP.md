# Patient Management System - Database Setup Instructions

## Overview
The Patient Management System uses a MySQL database named `pms` with several tables to store user information, patient records, and diagnosis data.

## Prerequisites
- MySQL Server 8.0 or higher
- MySQL client or MySQL Workbench

## Database Setup Steps

### Step 1: Install MySQL
If you don't have MySQL installed:
- Download from: https://dev.mysql.com/downloads/mysql/
- Follow the installation instructions for your operating system
- Make note of the root password you set during installation

### Step 2: Create and Setup the Database
There are two ways to set up the database:

#### Option 1: Using the Consolidated Schema File (Recommended)
This single file contains all necessary database tables and initial data:

1. Open a command prompt/terminal
2. Navigate to the project directory
3. Run the following command (replace `your_password` with your MySQL root password):
   ```
   mysql -u root -p < pms_database.sql
   ```
4. Enter your MySQL password when prompted

#### Option 2: Manual Database Creation
If the above method doesn't work, you can create the database manually:

1. Log in to MySQL:
   ```
   mysql -u root -p
   ```
2. Create the database:
   ```
   CREATE DATABASE pms;
   USE pms;
   ```
3. Exit MySQL and run the schema file:
   ```
   mysql -u root -p pms < pms_database.sql
   ```

### Step 3: Verify Database Setup
To verify that the database has been set up correctly:

1. Log in to MySQL:
   ```
   mysql -u root -p
   ```
2. Select the database:
   ```
   USE pms;
   ```
3. List all tables:
   ```
   SHOW TABLES;
   ```
4. You should see the following tables:
   - users
   - userdetails
   - admins
   - doctors
   - nurses
   - diagnosis

### Step 4: Update Database Connection in Application
Before running the application, make sure to update the database connection settings:

1. Open the file: `src/main/java/com/pms/util/DBConnection.java`
2. Update the following values to match your MySQL setup:
   ```java
   private static final String JDBC_URL = "jdbc:mysql://localhost:3306/pms?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
   private static final String USERNAME = "root"; // Your MySQL username
   private static final String PASSWORD = "your-password-here"; // Your MySQL password
   ```

## Default Login Credentials
After setting up the database, you can log in using these default credentials:

- **Admin User**:
  - Username: `admin`
  - Password: `admin123`

- **Patient User**:
  - Username: `cedric`
  - Password: `cedric123`

## Troubleshooting

### Common Issues and Solutions

#### Connection Refused Error
- Make sure MySQL service is running
- Verify the port number in the JDBC URL (default is 3306)

#### Access Denied Error
- Check that the username and password in DBConnection.java match your MySQL credentials
- Ensure the MySQL user has proper permissions for the pms database

#### Table Not Found Error
- Verify that all tables were created successfully using `SHOW TABLES;`
- Check for any error messages during database setup
- Run the schema file again if needed

For any further issues, please check the application logs or contact the development team. 