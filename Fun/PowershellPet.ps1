#Powershell Pet

$Mover = "       "

for (;;) {


#This function returns a random number between 0 and 6
$Pose = Get-Random 6

#Supplying the randomly generated number to the switch command tells
#Switch which pose to display

#CLS clears the screen before a new pose is displayed
cls

switch ($Pose) {


    0 { 
        write-host ""
        write-host "$Mover(>'')>"
        write-host ""
        break}
        
    1 { 
        write-host ""
        write-host "$Mover<(''<)"
        write-host ""
        break}
            
    2 { 

        write-host ""
        write-host "$Mover(V''V)"
        write-host ""
        break}
            
    3 { 
        write-host ""
        write-host "$Mover(^''^)"
        write-host ""
        break}
    
    4 { 
        write-host ""
        write-host "$Mover<(  Y )"
        write-host ""
        break}

    5 { 
        write-host ""
        write-host "$Mover( Y  )>"
        write-host ""
        break}
}

$CurMove = $Mover.Length

$Mover = ""

$MoveType = Get-Random 3


if ($MoveType -eq 1) {

    for ($i=0; $i -lt ($CurMove + 1); $i++) {

    $Mover = $Mover + " "
    Write-Host "$i added"
    }

}

if ($MoveType -eq 2) {

    for ($i=0; $i -lt ($CurMove - 1); $i++) {

    $Mover = $Mover + " "
    Write-Host "$i subtracted"
    }

}

Write-Host " "
Write-Host $MoveType
Write-Host $CurMove
Write-Host $NewMove

sleep 1

}