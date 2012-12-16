cls
#Grab all the cmdlets accessible in this session
$Cmdlets = (Get-Command |  where {$_.commandtype -eq "cmdlet"} |
 select -ExpandProperty name)

#Run the test all all installed cmdlets
$Cmdlets | foreach {

    #Grab the parameters for this cmdlet via Get-Command
    $GetCommandParams = (Get-Command $_).Parameters.keys

    
    #Remove common parameters from Get-Command list
    $GetCommandParams = $GetCommandParams | 
        where {$_ -ne "OutBuffer" `
        -and $_ -ne "OutVariable" `
        -and $_ -ne "WarningVariable" `
        -and $_ -ne "ErrorVariable" `
        -and $_ -ne "WarningAction" `
        -and $_ -ne "ErrorAction" `
        -and $_ -ne "Debug" `
        -and $_ -ne "Verbose" `
        -and $_ -ne "WhatIf" `
        -and $_ -ne "Confirm"}

    #Grab parameters mentioned in the get-help file for cmdlet
    $GetHelpParams =(Get-Help $_).parameters.parameter |
        % {$_ | select -ExpandProperty name}

    #Remove Common Parameters from Get-Help List
    $GetHelpParams = $GetHelpParams |
        where {$_ -ne "Confirm" `
        -and $_ -ne "WhatIf"}

    #If statemente that prevents errors from null results
    if (($GetHelpParams -ne $null) -and ($GetCommandParams -ne $null)) {
    
        #put the comparision in a variable to use later
        $Compare = Compare-Object $GetHelpParams $GetCommandParams
         
        #If statement to only display results with differences
        if ($Compare.count -gt 0) {
            #Display the differences between Get-Help and Get-Command params
            Write-Host "`n$_" -ForegroundColor Green
            $Compare
        }
    }
}