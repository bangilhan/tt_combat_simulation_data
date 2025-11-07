# Starts a simple local HTTP server so that index.html can load its assets properly.
# Usage: right-click this file and choose "Run with PowerShell" or execute from a PowerShell window.

$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectDir

Write-Host "Starting local server at http://localhost:5500" -ForegroundColor Cyan
Write-Host "Press Ctrl + C to stop the server." -ForegroundColor Yellow

if (Get-Command python -ErrorAction SilentlyContinue) {
    python -m http.server 5500
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    py -m http.server 5500
} elseif (Get-Command node -ErrorAction SilentlyContinue) {
    npx serve . --listen 5500
} else {
    Write-Host "No suitable runtime (Python or Node.js) found." -ForegroundColor Red
    Write-Host "Install Python from https://www.python.org/downloads/ or Node.js from https://nodejs.org/en/download/" -ForegroundColor Red
    pause
}
