# Patient Management System

## Overview
The Patient Management System is a Java web application built using Servlet/JSP technology. It provides functionality for managing patients, doctors, nurses, and diagnoses in a healthcare setting.

## Features
- User authentication and role-based access control
- Patient registration and profile management
- Doctor and nurse dashboards
- Diagnosis creation and management
- Responsive design for various device sizes

## Technology Stack
- **Backend**: Java Servlets, JSP
- **Frontend**: HTML, CSS, Bootstrap, JavaScript
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Apache Tomcat

## Getting Started
See the BUILD_INSTRUCTIONS.md file for detailed setup and deployment instructions.

## Database Setup
Use the consolidated database script to create all required tables in one step:
```
mysql -u root -p < pms_database.sql
```

For detailed database setup instructions, see the DB_SETUP.md file.