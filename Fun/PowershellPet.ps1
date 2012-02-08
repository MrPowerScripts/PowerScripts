#Powershell Pet

$Move = 10

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

        $Mover = $Mover + " "

    }

cls

    switch (Get-Random 6) {

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

sleep 1

}