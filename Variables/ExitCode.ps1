
Invoke-Expression -Command "C:\users\fern\exitCode.ps1"
cls
if ($LastExitCode -eq "12") {Write-Host "ErrorCodeCaught!"}