cls
#Test path returns a true or false result
#Test-Path C:\Users\Fer

#Use test path within a logic statement
#if (Test-Path C:\users\fer) {Write-Host "The folder exists!"}

#Check if a path doesn't exist
#if (!(Test-Path C:\users\fer)) {Write-Host "The folder doesn't exist!"}

#Test the path of a file
#Test-Path -Path C:\Users\Fern\Desktop\Notepad+.lnk

#Test paths of the registry as well
#Test-Path -Path HKCU:\software\Microsoft
#Test-Path -Path HKCU:\software\Microhard

#Create a folder if it doesn't exist
<#
if (!(Test-Path C:\users\fern\desktop\test)) {

New-Item C:\users\fern\desktop\test -ItemType directory
New-Item C:\users\Fern\Desktop\test -Name RandomFile.exe -ItemType file

New-Item C:\users\fern\desktop\test\testing -ItemType directory
New-Item C:\users\Fern\Desktop\test\testing -Name RandomFile.xls -ItemType file
}
#>

#Check for specific item type with PathType Parameter
#Get-ChildItem C:\users\fern\Desktop -Filter *.exe
#Test-Path -Path C:\Users\Fern\Desktop\what.exe -PathType leaf

#Check if specific items exist in folder , or do not exist
#Test-Path C:\users\fern\Desktop\test\* -Exclude *.exe -PathType Leaf

#Only in powershell 3
#Check if path existed before or after date

#Test-Path -Path C:\Windows -OlderThan "10/27/2002"