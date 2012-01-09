$File = ""
$Text = ""


$Content = Get-Content $File

$Content | Foreach {

                    if ($_ -ilike "$Text") {Write-Output $_}

                    }