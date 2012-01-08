cls
#Special characters start with a ` and are interpreted within "" as well as $Variables
Write-Host "`t This line starts with a tab"
Write-Host '`t This line is interpreted literally'
Write-Host "`r"
Write-Host "-------------------------------"
Write-Host "Before new line special character`nAfter new line character"
Write-Host "`r"
Write-Host 'Before new line special character`nNew line character is not interpreted'
Write-Host "`r"
Write-Host "-------------------------------"
$Variable = "Powershell3"

Write-Host "We're talking about $Variable"
Write-Host "`r"
Write-Host 'Were talking about $Variable'