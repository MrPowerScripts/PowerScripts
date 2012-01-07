#Environment variables can be called upon from the reserved variable $env:
$env:NUMBER_OF_PROCESSORS
$env:HOMEPATH
$env:COMPUTERNAME
$env:OS


#Variables in Powershell are evaluated first when inside " "
Write-Host "$env:HOMEPATH\desktop"

#Displays all environment variables
Get-ChildItem env:





