#Environment variables can be called upon from the reserved variable $env:
$env:HOMEPATH
$env:CLASSPATH
$env:Path

#Displays all environment variables
Get-ChildItem env:

#Variables in Powershell are evaluated first when inside " "
Write-Host "$env:HOMEPATH\desktop"



