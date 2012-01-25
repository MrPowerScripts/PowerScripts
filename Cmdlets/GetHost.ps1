Get-Host


$Ver = Get-Host | Select-Object Version
cls
If ($Ver -imatch "3.0") { Write-Host "This is powershell 3.0!"}
Elseif  ($Ver -imatch "2.0") {  Write-Host "This is powershell 2.0!" }
Elseif  ($Ver -imatch "1.0") {  Write-Host "This is powershell 1.0!" }
