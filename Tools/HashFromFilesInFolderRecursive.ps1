#Folders for input and output
$ParentFolder = "C:\users\Fern\Desktop\scripts"
$ExportFile = "C:\users\Fern\Desktop\supertest.txt"

#Can use md5, sha1, and more depending on your .net version
$Type="md5"

#Looping through the files, generating hash, and appending to export file
#the -file is exclusive to powershell 3
$Files = Get-ChildItem $Parentfolder -Recurse -File

#Create Empty Array To Store Hashes
$Hashes=@()

$Files | ForEach-Object {

    $fs = new-object System.IO.FileStream $_.fullname, "Open"
    $algo = [type]"System.Security.Cryptography.$Type"
	$crypto = $algo::Create()
    $hash = [BitConverter]::ToString($crypto.ComputeHash($fs)).Replace("-", "")
    $fs.Close()
    
    $Hashes += ($_.fullname.substring(3) + " $hash")
    
}

$Hashes | Out-File $ExportFile -Force