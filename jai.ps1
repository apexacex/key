$exe = "$env:USERPROFILE\Downloads\OneDrive.exe"
$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

$ws = New-Object -ComObject WScript.Shell
$shortcut = $ws.CreateShortcut("$startup\OneDrive.lnk")
$shortcut.TargetPath = $exe
$shortcut.WorkingDirectory = Split-Path $exe
$shortcut.Save()
