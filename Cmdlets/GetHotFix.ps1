#$HotFixes = Get-HotFix

<#
foreach ($HotFix in $HotFixes) {

    if ($HotFix.Installedby -ilike "*fern*") {

        Write-Host $Hotfix.HotFixID
    }
}
#>


<#
$List = $HotFixes.GetEnumerator() | Select-Object -ExpandProperty Hotfixid

Out-File "$env:HOMEDRIVE\$env:HOMEPATH\desktop\$Env:COMPUTERNAME.txt" -InputObject $List
#>