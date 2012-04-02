function show-games {

$computer = "LocalHost" 
$namespace = "root\CIMV2\Applications\Games" 
$Game = Get-WmiObject -class Game -computername $computer -namespace $namespace

$Game

}

function show-ratings {

$computer = "LocalHost" 
$namespace = "root\CIMV2\Applications\WindowsParentalControls" 
$WPCRating = Get-WmiObject -class WpcRating -computername $computer -namespace $namespace

$WPCRating.SyncRoot | Select-Object longname, description | Format-List
}

function show-bios {

$computer = "LocalHost" 
$namespace = "root\CIMV2" 
$Bios = Get-WmiObject -class Win32_BIOS -computername $computer -namespace $namespace

$bios

}


function show-keyboard {
$computer = "LocalHost" 
$namespace = "root\CIMV2" 
$Keyboard = Get-WmiObject -class Win32_Keyboard -computername $computer -namespace $namespace

$keyboard
}