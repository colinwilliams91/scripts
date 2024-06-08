# Experimenting with Win Buttons

# Load System.Windows.Forms assembly (needed?)
Add-Type -AssemblyName PresentationFramework

$CurrentDir = (Get-Location).Path
$LogsDir = "$CurrentDir\logs"

# Create the 'logs' directory if it doesn't already exist
if (-not (Test-Path -Path $LogsDir)) {
    New-Item -ItemType Directory -Path $LogsDir
}

# Start current session log file
Start-Transcript -OutputDirectory "$CurrentDir"

$Button = [Windows.MessageBoxButton]::YesNoCancel

# Stop current session log file
Stop-Transcript