# Patient Management System - Project Overview

## Group Information

**Group Number**: 5

**Team Members**:
- Student Name 1 (Registration Number: xxxxx)
- Student Name 2 (Registration Number: xxxxx)
- Student Name 3 (Registration Number: xxxxx)
- Student Name 4 (Registration Number: xxxxx)
<!-- Add all team members with their registration numbers -->

**Course**: [Course Code] - [Course Name]

**Submission Date**: April 21, 2025

**Instructor**: [Instructor's Name]

## Introduction

The Patient Management System (PMS) is a comprehensive web-based application developed using Java Servlets and JSP. It provides a platform for managing healthcare processes including patient registration, diagnosis tracking, and medical staff management. The system follows the Model-View-Controller (MVC) architecture and features a responsive design that works across different devices.

## Quick Start Guide

1. **Database Setup**: 
   - Install MySQL 8.0+
   - Run `mysql -u root -p < pms_database.sql`
   - Configure database connection in `src/main/java/com/pms/util/DBConnection.java`

2. **Build & Deploy**:
   - Install JDK 8+, Maven, and Tomcat 9
   - Run `mvn clean package`
   - Deploy `target/pms.war` to Tomcat

3. **Access Application**:
   - Visit `http://localhost:8080/pms`
   - Login with default credentials:
     - Admin: `admin` / `admin123`
     - Patient: `cedric` / `cedric123`

## Key Features

### User Management
- Role-based authentication (Admin, Doctor, Nurse, Patient)
- Secure login and session management
- User profile management with image upload

### Patient Features
- Patient registration and profile management
- View and track medical diagnoses 
- Status tracking (Referrable, Not Referrable, Pending)

### Healthcare Provider Features
- Doctors can view assigned patients and update diagnoses
- Nurses can create initial diagnoses and refer patients
- Medical staff can update patient records

### Administrative Features
- User account management
- System monitoring and configuration

## Technology Stack

- **Backend**: Java Servlets, JSP (JavaServer Pages)
- **Frontend**: HTML5, CSS3, Bootstrap 5, JavaScript
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Application Server**: Apache Tomcat 9.x

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── pms/
│   │           ├── controller/ - Servlet controllers
│   │           ├── dao/ - Data Access Objects 
│   │           ├── model/ - Data models
│   │           └── util/ - Utility classes
│   ├── webapp/
│   │   ├── WEB-INF/
│   │   │   └── views/ - JSP view templates
│   │   ├── css/ - Stylesheets
│   │   └── images/ - Image resources
│   └── resources/ - Configuration files
```

## Database Schema

The database (`pms`) consists of 6 main tables:

- **users** - Stores all user accounts with roles
- **userdetails** - Additional patient information
- **admins** - Admin-specific data
- **doctors** - Doctor profiles and specializations
- **nurses** - Nurse information and departments
- **diagnosis** - Patient diagnoses and medical data

## Detailed Documentation

For more detailed information, refer to:

- [README.md](README.md) - Complete project overview
- [BUILD.md](BUILD.md) - Detailed build and deployment instructions
- [DATABASE.md](DATABASE.md) - Comprehensive database setup guide

## Troubleshooting

### Common Issues

#### Application
- Check Tomcat logs at `%TOMCAT_HOME%\logs\catalina.out`
- Verify Tomcat is running at http://localhost:8080
- Ensure port 8080 is not already in use

#### Database
- Verify MySQL service is running
- Check connection settings match your environment
- Make sure the database and tables exist

## Team Contributions

| Team Member | |Reg No
|-------------|---------------|
| Senzele Benjamine | •  |
| KEZA UWINEZA Keren | •  |
| RUYANGA Merci | • |
| HIRWA Cyuzuzo Cedric |223013417 |
| NAMBAJIMANA Patrick | |
| UWAMAHORO Jean Chretien|223013313|
| BYIRINGIRO Olivier |223008225 |
| MUKAMFIZI Gisele |223017533 |
<!-- Adjust based on actual contributions -->

## License

This project is for educational purposes.

---

*This overview summarizes the three documentation files. For complete instructions, please refer to the detailed documentation files.* 