
#Variables start with a $ in Powershell

#These are valid variables
$Variable
$ThisIsAVariableToo
$ThisIsAlsoAVariable

#You can also set variables like this
Set-Variable -Name Variablename -Value VariableValue

#Or like this - you don't need to declare types in powershell
$Variable = 3
$ThisIsAVariableToo = "it's true"
$ThisIsAlsoAVariable = $True

#Or even like this
[String]$Season = "Winter"
[int]$Month = "1"
[bool]$TrueFalse = $False
[array]$Things = ("1thing","2thing","3thing")

cls #Clears the host

#Write the values of our assigned variables to the host
Write-Host $Variable
Write-Host $ThisIsAVariableToo
Write-Host $ThisIsAlsoAVariable
Write-Host $Season
Write-Host $Month
Write-Host $TrueFalse
Write-Host $Things


