# Patient Management System - Submission Guide

## Files to Include in Your Submission

1. **Source Code**:
   - `src/` directory (complete Java source code)
   - `pom.xml` (Maven project configuration)

2. **Compiled Application**:
   - `target/pms.war` (ready-to-deploy web application)

3. **Database Setup**:
   - `pms_database.sql` (consolidated database schema and initial data)
   - `DB_SETUP.md` (detailed database setup instructions)

4. **Documentation**:
   - `README.md` (project overview and basic instructions)
   - `BUILD_INSTRUCTIONS.md` (detailed build and deployment instructions)

5. **Remove These Files** (not needed for submission):
   - `.git/` directory (if present)
   - Any IDE-specific files (.idea/, .vscode/, etc.)
   - Temporary build files
   - Multiple database schema files that have been consolidated
   - Personal notes or files not related to the project

## Submission Process

1. Create a clean directory structure with only the required files listed above.

2. Make sure sensitive information is removed:
   - Changed database password in `src/main/java/com/pms/util/DBConnection.java` to a placeholder

3. ZIP the entire project directory:
   - Windows: Right-click > Send to > Compressed (zipped) folder
   - macOS: Right-click > Compress
   - Linux: `zip -r PatientManagementSystem.zip PatientManagementSystem/`

4. Verify the ZIP file can be extracted and the application can be built and run following the instructions.

## Key Points to Highlight to Your Lecturer

1. **Database Setup**:
   - The application uses a MySQL database named "pms" (lowercase)
   - All database tables have been defined in the consolidated schema file `pms_database.sql`
   - The lecturer needs to update the database password in `DBConnection.java`

2. **Application Features**:
   - User authentication with role-based access
   - Patient profile management
   - Diagnosis tracking and referrals
   - Responsive design using Bootstrap

3. **Technology Stack**:
   - Java Servlets & JSP for backend
   - MySQL for database
   - Bootstrap for frontend
   - Maven for build management
   - Tomcat for deployment

4. **Login Credentials**:
   - Admin: username `admin`, password `admin123`
   - Patient: username `cedric`, password `cedric123` 