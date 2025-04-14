@echo off
REM Build script for Patient Management System

REM Set Maven home path
set MAVEN_HOME=C:\Program Files\Apache Software Foundation\Maven\apache-maven-3.9.9
echo Using Maven from %MAVEN_HOME%

REM Add Maven bin to PATH
set PATH=%MAVEN_HOME%\bin;%PATH%

REM Clean and package the application
echo Building Patient Management System...
call "%MAVEN_HOME%\bin\mvn.cmd" clean package

if %ERRORLEVEL% NEQ 0 (
    echo Build failed!
    exit /b %ERRORLEVEL%
)

echo.
echo Build successful! WAR file created at: target\pms.war
echo.
echo Deployment Instructions:
echo 1. Copy target\pms.war to your Tomcat webapps directory
echo 2. Restart Tomcat if it's not set to auto-deploy
echo 3. Access the application at http://localhost:8080/pms/
echo.

REM Ask for Tomcat directory if CATALINA_HOME is not set
if "%CATALINA_HOME%" == "" (
    set /p TOMCAT_PATH=Enter your Tomcat installation directory (or press Enter to skip deployment): 
    if not "%TOMCAT_PATH%" == "" (
        if exist "%TOMCAT_PATH%\webapps" (
            echo Copying WAR file to Tomcat webapps directory...
            copy /Y target\pms.war "%TOMCAT_PATH%\webapps\"
            echo Deployment complete!
            
            set /p restart=Do you want to restart Tomcat now? (Y/N): 
            if /i "%restart%" == "Y" (
                echo Stopping Tomcat...
                call "%TOMCAT_PATH%\bin\shutdown.bat"
                timeout /t 5
                echo Starting Tomcat...
                call "%TOMCAT_PATH%\bin\startup.bat"
                echo Tomcat restarted. Your application should be available at http://localhost:8080/pms/
            )
        ) else (
            echo Invalid Tomcat directory. Webapps folder not found at %TOMCAT_PATH%\webapps
        )
    )
) else (
    echo CATALINA_HOME is set to: %CATALINA_HOME%
    echo.
    set /p deploy=Do you want to deploy to Tomcat now? (Y/N): 
    if /i "%deploy%" == "Y" (
        echo Copying WAR file to Tomcat webapps directory...
        copy /Y target\pms.war "%CATALINA_HOME%\webapps\"
        echo Deployment complete!
        
        set /p restart=Do you want to restart Tomcat now? (Y/N): 
        if /i "%restart%" == "Y" (
            echo Stopping Tomcat...
            call "%CATALINA_HOME%\bin\shutdown.bat"
            timeout /t 5
            echo Starting Tomcat...
            call "%CATALINA_HOME%\bin\startup.bat"
            echo Tomcat restarted. Your application should be available at http://localhost:8080/pms/
        )
    )
)

echo.
echo You can now access your application at http://localhost:8080/pms/
echo.
pause

exit /b 0 