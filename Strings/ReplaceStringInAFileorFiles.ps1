#Change the string in one file
$FileName = "C:\somefolder\somefile.txt"

Get-Content "$FileName" | ForEach-Object { $_ -replace "@","O" } | Set-Content "C:\users\fern\Desktop\CleanGarden.txt" -Force


#Change the string of multiple files
Get-ChildItem "C:\somefolder\somesubfolder" | ForEach-Object {

        $Content = Get-Content $_.fullname 
        
        $Content = ForEach-Object { $Content -replace "@","O" }
         
        Set-Content $_.fullname $Content -Force

}
