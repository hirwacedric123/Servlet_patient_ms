# Patient Management System - Build & Deployment Instructions

This guide provides step-by-step instructions for building and deploying the Patient Management System.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Java Development Kit (JDK) 8 or higher**
   - Download: [Oracle JDK](https://www.oracle.com/java/technologies/javase-downloads.html) or [OpenJDK](https://adoptopenjdk.net/)
   - Verify installation: `java -version`

2. **Apache Maven**
   - Download: [Maven](https://maven.apache.org/download.cgi)
   - Install: [Installation Instructions](https://maven.apache.org/install.html)
   - Verify installation: `mvn -version`

3. **Apache Tomcat 9.x**
   - Download: [Tomcat 9](https://tomcat.apache.org/download-90.cgi)
   - Extract to a directory of your choice

4. **MySQL 8.0**
   - Download: [MySQL](https://dev.mysql.com/downloads/mysql/)
   - Installation: Follow the wizard and note your root password
   - See [DATABASE.md](DATABASE.md) for database setup

## Building the Project

### Option 1: Using Maven Command Line

1. Open a terminal/command prompt
2. Navigate to the project root directory (where `pom.xml` is located)
3. Run the build command:
   ```
   mvn clean package
   ```
4. Maven will download dependencies, compile the code, and create a WAR file
5. The WAR file will be created at `target/pms.war`

### Option 2: Using the Provided Scripts (Windows)

For Windows users, a build script is provided:

1. Open Command Prompt as administrator
2. Navigate to the project directory
3. Run:
   ```
   build.bat
   ```

## Deploying to Tomcat

### Method 1: Manual Deployment

1. Stop Tomcat if it's running:
   - Windows: `%TOMCAT_HOME%\bin\shutdown.bat`
   - Linux/Mac: `$TOMCAT_HOME/bin/shutdown.sh`

2. Copy the WAR file to Tomcat's webapps directory:
   ```
   copy target\pms.war %TOMCAT_HOME%\webapps\
   ```
   or
   ```
   cp target/pms.war $TOMCAT_HOME/webapps/
   ```

3. Start Tomcat:
   - Windows: `%TOMCAT_HOME%\bin\startup.bat`
   - Linux/Mac: `$TOMCAT_HOME/bin/startup.sh`

4. The application will be deployed at: http://localhost:8080/pms

### Method 2: Using Tomcat Manager (Optional)

1. Configure Tomcat user:
   - Edit `%TOMCAT_HOME%\conf\tomcat-users.xml`
   - Add:
     ```xml
     <role rolename="manager-gui"/>
     <role rolename="manager-script"/>
     <user username="admin" password="admin" roles="manager-gui,manager-script"/>
     ```

2. Restart Tomcat

3. Access Tomcat Manager: http://localhost:8080/manager/html

4. Upload and deploy the WAR file using the web interface

## Testing the Application

1. Access the application at: http://localhost:8080/pms

2. Log in with the default credentials:
   - Admin: username `admin`, password `admin123`
   - Patient: username `cedric`, password `cedric123`

3. Test various features like registration, login, and viewing dashboards

## Troubleshooting

### Common Issues

#### Application Not Starting
- Check Tomcat logs at `%TOMCAT_HOME%\logs\catalina.out`
- Verify Tomcat is running: http://localhost:8080

#### Database Connection Problems
- Verify MySQL is running
- Check database connection settings in `src/main/java/com/pms/util/DBConnection.java`
- Ensure the database has been properly set up (see [DATABASE.md](DATABASE.md))

#### Build Failure
- Ensure Maven is correctly installed and in your PATH
- Check you have the correct JDK version
- Verify all dependencies are available

#### Deployment Issues
- Make sure port 8080 is not already in use
- Check Tomcat has sufficient permissions to deploy the application
- Verify the WAR file was created correctly

## Additional Configuration (Optional)

### Changing the Application Context Path

To deploy the application at a different context path:

1. Rename the WAR file before deployment (e.g., `myapp.war` will deploy at `/myapp`)

2. Or edit Tomcat's `server.xml` to specify a different path:
   ```xml
   <Context path="/mypath" docBase="pms" />
   ```

### Memory Settings

If your application needs more memory:

1. Set Tomcat's JVM options:
   - Windows: Edit `%TOMCAT_HOME%\bin\catalina.bat`
   - Add: `set "JAVA_OPTS=%JAVA_OPTS% -Xms512m -Xmx1024m"`
   
   - Linux/Mac: Edit `$TOMCAT_HOME/bin/catalina.sh`
   - Add: `JAVA_OPTS="$JAVA_OPTS -Xms512m -Xmx1024m"` 