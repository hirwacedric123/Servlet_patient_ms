Write-Host "Searching for Maven installation..." -ForegroundColor Cyan

$mavenPaths = @(
    "C:\apache-maven*",
    "C:\Program Files\apache-maven*",
    "C:\Program Files (x86)\apache-maven*",
    "C:\maven*",
    "C:\Users\$env:USERNAME\Downloads\apache-maven*",
    "C:\Users\$env:USERNAME\Desktop\apache-maven*"
)

$mavenHome = $null

foreach ($pattern in $mavenPaths) {
    $possiblePaths = Get-ChildItem -Path $pattern -Directory -ErrorAction SilentlyContinue
    foreach ($path in $possiblePaths) {
        if (Test-Path "$($path.FullName)\bin\mvn.cmd") {
            $mavenHome = $path.FullName
            Write-Host "Found Maven at $mavenHome" -ForegroundColor Green
            break
        }
    }
    if ($mavenHome) { break }
}

if (-not $mavenHome) {
    Write-Host "Maven not found in common locations." -ForegroundColor Yellow
    Write-Host "Please enter the full path to your Maven installation directory:" -ForegroundColor Yellow
    $mavenHome = Read-Host
}

if (-not (Test-Path "$mavenHome\bin\mvn.cmd")) {
    Write-Host "Invalid Maven installation directory. Executable not found." -ForegroundColor Red
    exit 1
}

Write-Host "Using Maven from $mavenHome" -ForegroundColor Green

# Add Maven to the PATH for this session
$env:PATH = "$mavenHome\bin;$env:PATH"

Write-Host "Maven has been added to PATH for this PowerShell session." -ForegroundColor Green
Write-Host "You can now use 'mvn' commands directly." -ForegroundColor Green
Write-Host "For example, try 'mvn -version'" -ForegroundColor Cyan

# Show current project
$projectPath = Get-Location
Write-Host "`nCurrent project: $projectPath" -ForegroundColor Magenta
if (Test-Path "$projectPath\pom.xml") {
    Write-Host "Found pom.xml in the current directory." -ForegroundColor Green
    Write-Host "You can build your project with: mvn clean package" -ForegroundColor Cyan
} else {
    Write-Host "No pom.xml found in the current directory. Make sure you're in the root of your Maven project." -ForegroundColor Yellow
}

# Keep the session open
Write-Host "`nMaven environment prepared! You can now run Maven commands." -ForegroundColor Green 