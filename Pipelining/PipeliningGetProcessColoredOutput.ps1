cls

Get-Process | Foreach {
                                    
                        if ($_.name -ilike "*chrome*") { Write-Host "$_" -ForegroundColor green} 
                        Elseif ($_.name -ilike "*powershell*") { Write-Host "$_" -ForegroundColor red}
                        else {Write-Host "$_"}

                                    
                      }

