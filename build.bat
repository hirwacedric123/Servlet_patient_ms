@echo off
echo Using Maven from C:\Program Files\Apache Software Foundation\Maven\apache-maven-3.9.9

set MAVEN_HOME=C:\Program Files\Apache Software Foundation\Maven\apache-maven-3.9.9
set PATH=%MAVEN_HOME%\bin;%PATH%

echo Building project with UI improvements...
"%MAVEN_HOME%\bin\mvn" clean package

if %ERRORLEVEL% NEQ 0 (
    echo Build failed. See errors above.
    pause
    exit /b 1
)

echo Build successful! UI improvements have been applied.

set /p TOMCAT_PATH=Enter your Tomcat installation path (e.g. C:\Program Files\Apache Software Foundation\Tomcat): 

if not exist "%TOMCAT_PATH%\webapps" (
    echo Invalid Tomcat directory. Webapps folder not found.
    pause
    exit /b 1
)

echo Stopping Tomcat...
call "%TOMCAT_PATH%\bin\shutdown.bat"
timeout /t 5

echo Copying WAR file to Tomcat webapps...
copy "target\patient-management-system-1.0-SNAPSHOT.war" "%TOMCAT_PATH%\webapps\pms.war"

echo Starting Tomcat...
call "%TOMCAT_PATH%\bin\startup.bat"

echo Deployment complete! Your application with the improved UI should be available at:
echo http://localhost:8080/pms
echo Database test page: http://localhost:8080/pms/dbtest

pause 