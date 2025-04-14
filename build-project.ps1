# Run the Maven setup script first
. .\setup-maven.ps1

Write-Host "`n=== Building Project ===" -ForegroundColor Cyan

# Build the project
mvn clean package

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed. See errors above." -ForegroundColor Red
    exit 1
}

Write-Host "`n=== Build Successful ===" -ForegroundColor Green

# Check if Tomcat directory is provided as an argument
$tomcatDir = $args[0]
if (-not $tomcatDir) {
    Write-Host "`nTo deploy to Tomcat, please enter the Tomcat installation directory:" -ForegroundColor Yellow
    $tomcatDir = Read-Host
}

if (-not (Test-Path "$tomcatDir\webapps")) {
    Write-Host "Invalid Tomcat directory. Webapps folder not found." -ForegroundColor Red
    exit 1
}

Write-Host "`n=== Deploying to Tomcat ===" -ForegroundColor Cyan

# Stop Tomcat if it's running
if (Test-Path "$tomcatDir\bin\shutdown.bat") {
    Write-Host "Stopping Tomcat..." -ForegroundColor Yellow
    & "$tomcatDir\bin\shutdown.bat"
    Start-Sleep -Seconds 5
}

# Copy the WAR file to Tomcat's webapps directory
$warFile = "target\patient-management-system-1.0-SNAPSHOT.war"
if (Test-Path $warFile) {
    Write-Host "Copying WAR file to Tomcat webapps..." -ForegroundColor Yellow
    Copy-Item $warFile -Destination "$tomcatDir\webapps\pms.war" -Force
    Write-Host "WAR file deployed as 'pms.war'" -ForegroundColor Green
} else {
    Write-Host "WAR file not found at expected location: $warFile" -ForegroundColor Red
    exit 1
}

# Start Tomcat
if (Test-Path "$tomcatDir\bin\startup.bat") {
    Write-Host "Starting Tomcat..." -ForegroundColor Yellow
    & "$tomcatDir\bin\startup.bat"
    
    Write-Host "`n=== Deployment Complete ===" -ForegroundColor Green
    Write-Host "Your application should be available at: http://localhost:8080/pms" -ForegroundColor Cyan
    Write-Host "Database test page: http://localhost:8080/pms/dbtest" -ForegroundColor Cyan
}

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 