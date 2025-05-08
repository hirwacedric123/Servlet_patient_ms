# Patient Management System

## Project Overview
The Patient Management System is a web-based application developed using Java Servlets and JSP. It provides functionality for managing patients, doctors, nurses, and diagnoses in a healthcare setting. The system follows the Model-View-Controller (MVC) architecture and is designed to be responsive across different devices.

## Key Features

### User Management
- Role-based authentication (Admin, Doctor, Nurse, Patient)
- Secure login and session management
- User profile management

### Patient Features
- Patient registration and profile management
- View medical diagnoses and history
- Track diagnosis status (Referrable, Not Referrable, Pending)

### Healthcare Provider Features
- Doctors can view and manage assigned patients
- Nurses can create initial diagnoses and refer patients to doctors
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
- **Authentication**: Password hashing with jBCrypt
- **File Uploads**: Apache Commons FileUpload

## Project Structure
- `src/main/java/com/pms/controller/` - Servlet controllers
- `src/main/java/com/pms/model/` - Data models
- `src/main/java/com/pms/dao/` - Data Access Objects
- `src/main/java/com/pms/util/` - Utility classes
- `src/main/webapp/WEB-INF/views/` - JSP views
- `src/main/webapp/css/` - Stylesheets
- `src/main/webapp/images/` - Image resources

## Getting Started
- For setup instructions, see [BUILD.md](BUILD.md)
- For database configuration, see [DATABASE.md](DATABASE.md)

## Default Login Credentials
After setup, you can use these default accounts:

- **Admin**
  - Username: `admin`
  - Password: `admin123`

- **Patient**
  - Username: `cedric`
  - Password: `cedric123`

## Screenshots
The application includes several key screens:
- Login and Registration
- Patient Dashboard
- Doctor Dashboard
- Patient Profile Management
- Diagnosis Management

## License
This project is for educational purposes.