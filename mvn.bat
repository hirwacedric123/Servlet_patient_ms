@echo off
echo Searching for Maven installation...

set MAVEN_HOME=
for /d %%i in (C:\Program Files\Apache Software Foundation\Maven\apache-maven* C:\Program Files\apache-maven* C:\Program Files (x86)\apache-maven* C:\maven* C:\Users\%USERNAME%\Downloads\apache-maven* C:\Users\%USERNAME%\Desktop\apache-maven*) do (
    if exist "%%i\bin\mvn.cmd" (
        set MAVEN_HOME=%%i
        echo Found Maven at %%i
        goto found
    )
)

echo Maven not found in common locations.
echo Please enter the full path to your Maven installation directory:
set /p MAVEN_HOME=

:found
if not defined MAVEN_HOME (
    echo Maven installation directory not provided. Exiting.
    exit /b 1
)

if not exist "%MAVEN_HOME%\bin\mvn.cmd" (
    echo Invalid Maven installation directory. Executable not found.
    exit /b 1
)

echo Using Maven from %MAVEN_HOME%

rem Execute Maven with all arguments passed to this script
"%MAVEN_HOME%\bin\mvn.cmd" %* 