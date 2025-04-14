# Patient Management System - Build & Deployment Instructions

## Prerequisites
- Java JDK 8 or higher
- Apache Maven
- Apache Tomcat
- MySQL Server

## Setup Scripts
We've created several helper scripts to make building and deploying easier:

1. **mvn.bat** - A batch file that finds Maven on your system and runs it
2. **setup-maven.ps1** - A PowerShell script that finds Maven and adds it to your PATH
3. **build-project.ps1** - A PowerShell script that builds and deploys the project

## Building the Project Manually

### Step 1: Set up Maven
If Maven is not in your PATH, you can use our setup script:

```powershell
.\setup-maven.ps1
```

This will find Maven on your system and add it to your PATH for the current PowerShell session.

### Step 2: Build the Project
In the project root directory (where pom.xml is located), run:

```powershell
mvn clean package
```

This will:
- Clean any previous build files
- Compile the Java code
- Package everything into a WAR file
- Place the WAR file in the `target` directory

### Step 3: Deploy to Tomcat
1. Stop Tomcat if it's running:
   ```
   C:\Path\to\Tomcat\bin\shutdown.bat
   ```

2. Copy the WAR file to Tomcat's webapps directory:
   ```
   copy target\patient-management-system-1.0-SNAPSHOT.war C:\Path\to\Tomcat\webapps\pms.war
   ```

3. Start Tomcat:
   ```
   C:\Path\to\Tomcat\bin\startup.bat
   ```

## Quick Build & Deploy
For a streamlined process, use our build script:

```powershell
.\build-project.ps1 [Tomcat_Directory_Path]
```

If you don't provide the Tomcat path as an argument, the script will prompt you for it.

## Testing the Application
1. Access the application at: http://localhost:8080/pms
2. Test the database connection at: http://localhost:8080/pms/dbtest

## Troubleshooting

### Maven Not Found
If you see "mvn is not recognized", try:
1. Open Command Prompt as administrator
2. Set Maven in your system PATH:
   ```
   setx PATH "%PATH%;C:\path\to\maven\bin" /M
   ```
3. Close and reopen your terminal

### Database Connection Issues
1. Make sure MySQL is running
2. Verify connection details in `src/main/java/com/pms/util/DBConnection.java`
3. Check that the PMS database exists and has been initialized with the SQL script

### Tomcat Deployment Issues
1. Make sure Tomcat is properly installed
2. Check Tomcat logs at `C:\Path\to\Tomcat\logs\catalina.out`
3. Verify that port 8080 is not being used by another application

## Development Workflow
After making code changes:
1. Run `mvn clean package` to rebuild
2. Deploy to Tomcat
3. Access the application to test your changes

For detailed logs during development, check:
- Application logs in Tomcat
- Database connection test page at `/dbtest` 