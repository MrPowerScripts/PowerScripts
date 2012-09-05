$Name="Chrome"
$Path=$env:USERPROFILE+"\desktop\HTMLTest.html"

Get-Process | Where {$_.ProcessName -imatch "$Name"} | Select-Object Name, CPU | Sort-Object CPU -Descending  | ConvertTo-Html -Head "<style> th {background-color: red;} td {border: 1px black solid; padding: 3px;} </style>" -Title "Processnames" | Out-File -FilePath $Path
