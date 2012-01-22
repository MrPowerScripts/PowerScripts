#Generate our HTML Tables

$Services = Get-Service | Select-Object DisplayName, Status | ConvertTo-Html -Fragment

$Process = Get-Process | Select-Object Name, CPU | Sort-Object CPU -Descending | ConvertTo-Html -Fragment

#Color the service column
$Services =  $Services | ForEach {

                    $_ -replace "<td>Running</td>","<td style=`"color: green`">Running</td>"

                    }

$Services =  $Services | ForEach {

                    $_ -replace "<td>Stopped</td>","<td style=`"color: red`">Stopped</td>"

                    }

#Generate our full HTML with CSS styling
$HTML = ConvertTo-Html -Body "$Services $Process" -Head "<style> body {background-color: lightblue; } table {background-color: white; margin: 5px; float: left; top: 0px; display: inline-block; padding: 5px; border: 1px solid black} tr:nth-child(odd) {background-color: lightgray} </style>"

#Output to a file
$HTML | Out-File $FileLocation