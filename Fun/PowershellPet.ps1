#Powershell Pet

$Move = 10
$Colors = [enum]::GetNames([system.consolecolor])

for (;;) {

$Mover = ""

    switch (Get-Random 5) {

        0 {break}
        1 {$Move = $Move + 1; break}
        2 {$Move = $Move - 1; break}
        3 {$Move = $Move + 2; break}
        4 {$Move = $Move - 2; break}
    }

    for ($i=0; $i -lt $Move; $i++) {
        $Mover += " "
    }

    switch -Regex (Get-Random 5) {

        [0-1] {break}
        [2-4] {$Color = $Colors[(Get-Random 16)]}
    }

cls

    switch (Get-Random 6) {

        0 {write-host "`n$Mover(>'')>" -ForegroundColor $Color; break}
        
        1 {write-host "`n$Mover<(''<)" -F $Color; break}
            
        2 {write-host "`n$Mover(V''V)" -F $Color; break}
            
        3 {write-host "`n$Mover(^''^)" -F $Color; break}
    
        4 {write-host "`n$Mover<(  Y )" -F $Color; break}

        5 {write-host "`n$Mover( Y  )>" -F $Color; break}
    }

sleep 1

}