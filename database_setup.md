# Patient Management System Database Setup

This guide will help you set up the MySQL database for the Patient Management System.

## Prerequisites

- MySQL Server 5.7+ installed
- MySQL client (or MySQL Workbench)
- Admin access to your MySQL server

## Setup Steps

1. **Login to MySQL**:
   ```bash
   mysql -u root -p
   ```
   Enter your MySQL root password when prompted.

2. **Create and Select Database**:
   ```sql
   CREATE DATABASE IF NOT EXISTS pms;
   USE pms;
   ```

3. **Import Schema**:
   You can import the schema in one of two ways:

   - **Direct Import** (recommended):
     ```bash
     mysql -u root -p pms < pms_schema.sql
     ```

   - **Manual Execution**:
     Copy and paste the contents of `pms_schema.sql` into your MySQL client or MySQL Workbench.

4. **Verify Setup**:
   Check that the tables were created correctly:
   ```sql
   SHOW TABLES;
   ```
   
   You should see the following tables:
   - `Admins`
   - `Diagnosis`
   - `Doctors`
   - `Nurses`
   - `UserDetails`
   - `Users`

## Default Credentials

The schema includes a default admin account:
- Username: `admin`
- Password: `admin123`

It also includes sample users for testing:
- Doctor: `doctor1` / `admin123`
- Nurse: `nurse1` / `admin123`
- Patient: `patient1` / `admin123`

## Connecting Your Application

Update the database connection settings in your application if necessary. The default connection details in the application are:

- Database URL: `jdbc:mysql://localhost:3306/pms?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC`
- Username: `root`
- Password: `Dedecedric@1`

If your MySQL credentials are different, update the `DBConnection.java` file with your settings.

## Troubleshooting

If you encounter connection issues:

1. Ensure the MySQL server is running
2. Verify your username and password are correct
3. Check that the database name is `pms`
4. Make sure your MySQL user has appropriate permissions

For any other issues, refer to the MySQL documentation or contact your database administrator. 