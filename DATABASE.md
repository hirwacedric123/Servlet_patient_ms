# Patient Management System - Database Setup

This guide provides detailed instructions for setting up the database for the Patient Management System.

## Database Overview

The Patient Management System uses a MySQL database with several tables to store and manage:
- User accounts (admin, doctor, nurse, patient)
- User profiles and details
- Medical diagnoses
- Patient-doctor relationships

## Prerequisites

- MySQL Server 8.0 or higher
- MySQL client or MySQL Workbench (optional)
- MySQL JDBC driver (included in the project dependencies)

## Setup Instructions

### Step 1: Install MySQL

If you don't have MySQL installed:

1. Download MySQL from the [official website](https://dev.mysql.com/downloads/mysql/)
2. Follow the installation wizard
3. Make sure to note the root password you set during installation
4. Ensure the MySQL service is running

### Step 2: Create the Database

#### Option 1: Using the Consolidated Schema File (Recommended)

1. Open a command prompt/terminal
2. Navigate to the project directory
3. Run the following command:
   ```
   mysql -u root -p < pms_database.sql
   ```
4. Enter your MySQL root password when prompted

#### Option 2: Manual Database Creation

If the above method doesn't work, create the database manually:

1. Log in to MySQL:
   ```
   mysql -u root -p
   ```
2. Enter your password when prompted
3. Create the database:
   ```sql
   CREATE DATABASE pms;
   USE pms;
   ```
4. Exit MySQL:
   ```sql
   EXIT;
   ```
5. Import the schema:
   ```
   mysql -u root -p pms < pms_database.sql
   ```

### Step 3: Configure Database Connection

1. Open `src/main/java/com/pms/util/DBConnection.java`
2. Update the database connection settings:
   ```java
   private static final String JDBC_URL = "jdbc:mysql://localhost:3306/pms?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
   private static final String USERNAME = "root"; // Change if using a different MySQL user
   private static final String PASSWORD = "your-mysql-password"; // Replace with your actual MySQL password
   ```

### Step 4: Verify the Setup

To verify that the database has been set up correctly:

1. Log in to MySQL:
   ```
   mysql -u root -p
   ```
2. Select the database:
   ```sql
   USE pms;
   ```
3. List all tables:
   ```sql
   SHOW TABLES;
   ```
4. You should see the following tables:
   ```
   +---------------+
   | Tables_in_pms |
   +---------------+
   | admins        |
   | diagnosis     |
   | doctors       |
   | nurses        |
   | userdetails   |
   | users         |
   +---------------+
   ```
5. Check that the default users were created:
   ```sql
   SELECT Username, Role FROM users;
   ```

## Database Schema

### Key Tables

1. **users** - Stores all user accounts
   ```
   +---------------+--------------+------+-----+---------+----------------+
   | Field         | Type         | Null | Key | Default | Extra          |
   +---------------+--------------+------+-----+---------+----------------+
   | UserID        | int          | NO   | PRI | NULL    | auto_increment |
   | Username      | varchar(50)  | NO   | UNI | NULL    |                |
   | Password      | varchar(255) | NO   |     | NULL    |                |
   | Role          | varchar(20)  | NO   |     | NULL    |                |
   | FirstName     | varchar(50)  | YES  |     | NULL    |                |
   | LastName      | varchar(50)  | YES  |     | NULL    |                |
   | Email         | varchar(100) | YES  |     | NULL    |                |
   | ContactNumber | varchar(20)  | YES  |     | NULL    |                |
   | Address       | varchar(255) | YES  |     | NULL    |                |
   | ProfileImage  | varchar(255) | YES  |     | NULL    |                |
   +---------------+--------------+------+-----+---------+----------------+
   ```

2. **userdetails** - Stores additional user information
   ```
   +------------------+-------------+------+-----+---------+-------+
   | Field            | Type        | Null | Key | Default | Extra |
   +------------------+-------------+------+-----+---------+-------+
   | UserID           | int         | NO   | PRI | NULL    |       |
   | DateOfBirth      | date        | YES  |     | NULL    |       |
   | Gender           | varchar(10) | YES  |     | NULL    |       |
   | BloodGroup       | varchar(5)  | YES  |     | NULL    |       |
   | EmergencyContact | varchar(50) | YES  |     | NULL    |       |
   +------------------+-------------+------+-----+---------+-------+
   ```

3. **diagnosis** - Stores medical diagnoses
   ```
   +--------------+--------------+------+-----+-------------------+-----------------------------------------------+
   | Field        | Type         | Null | Key | Default           | Extra                                         |
   +--------------+--------------+------+-----+-------------------+-----------------------------------------------+
   | DiagnosisID  | int          | NO   | PRI | NULL              | auto_increment                                |
   | PatientID    | int          | NO   | MUL | NULL              |                                               |
   | NurseID      | int          | NO   | MUL | NULL              |                                               |
   | DoctorID     | int          | YES  | MUL | NULL              |                                               |
   | DiagnoStatus | varchar(20)  | NO   |     | NULL              |                                               |
   | Result       | varchar(255) | YES  |     | NULL              |                                               |
   | Symptoms     | text         | YES  |     | NULL              |                                               |
   | CreatedDate  | timestamp    | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
   | UpdatedDate  | timestamp    | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
   +--------------+--------------+------+-----+-------------------+-----------------------------------------------+
   ```

## Default Login Credentials

After setting up the database, you can log in with these default credentials:

- **Admin User**
  - Username: `admin`
  - Password: `admin123`

- **Patient User**
  - Username: `cedric`
  - Password: `cedric123`

## Troubleshooting

### Common Issues

#### Connection Refused
- Ensure MySQL service is running
- Check that port 3306 is not blocked by a firewall
- Verify the hostname in the JDBC URL

#### Access Denied
- Make sure you're using the correct MySQL username and password
- Check that the user has appropriate permissions

#### Table Not Found
- Verify the database was created successfully
- Check that all tables were created using `SHOW TABLES;`
- Run the schema file again if needed

#### Data Not Importing
- Check for SQL syntax errors in the schema file
- Ensure character set compatibility

### MySQL Commands Reference

Here are some useful MySQL commands for troubleshooting:

```sql
-- Check MySQL version
SELECT VERSION();

-- List all databases
SHOW DATABASES;

-- Use the PMS database
USE pms;

-- Show all tables
SHOW TABLES;

-- Describe table structure
DESCRIBE users;
DESCRIBE diagnosis;

-- Check user records
SELECT UserID, Username, Role FROM users;

-- Check for foreign key relationships
SELECT table_name, column_name, referenced_table_name, referenced_column_name
FROM information_schema.key_column_usage
WHERE referenced_table_name IS NOT NULL
AND table_schema = 'pms';
``` 