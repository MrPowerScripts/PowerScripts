$Loc="C:\somefolder\testfile.txt"
$TO="C:\somefolder\testoutput.txt"

cls

#Using out-null can supress some kinds of output from Powershell
#New-Item $Loc -ItemType file | Out-Null

#New-Item $Loc -ItemType file -Force | Out-Null






#You can use the redirection symbol to
#New-Item $Loc -ItemType file > $Null
#New-Item $Loc -ItemType file 2> $TO
#New-Item $Loc -ItemType file 2> $Null
#New-Item $Loc -ItemType file 2>> $TO
#New-Item $Loc -ItemType file 2>&1 | Out-File $TO







#Use Tee-Object to redirect the contents of a pipeline to a file/variable
#Then continue handing those contents down the pipeline
Get-Process | Tee-Object -FilePath $Loc | Select-Object ProcessName,CPU | ft -AutoSize
