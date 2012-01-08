

#Using get member to find out information about the get-process cmdlet
Get-Process | Get-Member

#after finding out the Get-Process Cmdlet has a Company property we can use it with other Cmdlets to refine results
Get-Process | Sort-Object Company | Where {$_.Company -ne $Null}

$Variable = "String"

#finding more information about our variable with Get-Member
$Variable | Get-Member

#Using the ToLower() method to change the characters in our string to lower case
$Variable.ToLower()