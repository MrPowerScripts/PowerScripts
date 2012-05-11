   
 <#


Placing values in test.txt like this:

One=1
Two=2
Three=3

will allow you to call the values from powershell like this:

$ConfigKeys.One
$Configkeys.Two
$ConfigKeys.Three

to display the stored values

#>
  
#File with the stored data
$ConfigFile = "C:\SomeFile\test.txt"
#Creating an empty hash table
$ConfigKeys = @{}


#Pulling, separating, and storing the values in $ConfigKey
Get-Content $ConfigFile | ForEach-Object {

$Keys = $_ -split "="

$ConfigKey += @{$Keys[0]=$Keys[1]}

}    