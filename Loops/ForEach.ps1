#ForEach Pipelining
Get-Service | ForEach {

                      if ($_.status -imatch "running") {Write-Host $_ -ForegroundColor Green}
                      if ($_.status -imatch "stopped") {Write-Host $_ -ForegroundColor Red}

                     }

#ForEach without pipelining
$Services = Get-Service

ForEach ($Potato in $Services) {

        if ($Potato.status -imatch "running") {Write-Host $Potato -ForegroundColor Green}
        if ($Potato.status -imatch "stopped") {Write-Host $Potato -ForegroundColor Red}

        }

#ForEach example to delete files with a certain extension recursively

$Stuff = Get-ChildItem $Folder -Recurse


Foreach ($Item in $Stuff) {
                            
                            $Parent = $Item.DirectoryName


                            if ($item.Extension -ilike ".php") {Remove-Item "$Parent\$Item" }
                          

                          }