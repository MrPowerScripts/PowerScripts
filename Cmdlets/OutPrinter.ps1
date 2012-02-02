#Simple Out-Printer examples
$Stuff = Get-Process

Out-Printer -InputObject $Stuff -Name $PrinterName


Get-Process | Out-Printer


#Advanced Out-Printer example
$FileDate = Get-Date -Format "MMMddyy_HHmmss"
$FileName = "DailyReport_$FileDate.txt"
$FilePath = "Path"
$Fullpath = "$FilePath\$Filename"

New-Item -Name $Filename -Path $Filepath -ItemType File


"$env:COMPUTERNAME" | Out-File -FilePath $FullPath -Append
Get-Date -Format "MMM/dd/yyyy HH:mm:ss" | Out-File -FilePath $Fullpath -Append
Get-Service | where {$_.name -ilike "b*" -or $_.name -ilike "w*"} | Format-Table Name, Status | Out-File -FilePath $Fullpath -Append

Get-Content $FullPath | Out-Printer

