cls
#Example of passing params to a function with () outside the script block
function Date-Created-Out ($File,$Q) {

    ($FileInfo = Get-ItemProperty -Path $File).creationtime | Out-Host

    if ($Q -imatch "y"){($FileInfo.CreationTime).DayOfYear|Out-Host}

}

function Date-Created-In { 

    #Example of passing params using param statement inside the script block
    #Also showing that defualt params can be set as well as var types
    param ($File="C:\winpe", [int]$Q=0)

    ($FileInfo = Get-ItemProperty -Path $File).creationtime | Out-Host

    if ($Q -eq 1) {($FileInfo.CreationTime).DayOfYear|Out-Host}

}

function Date-Created-Args {

    #Example of grabbing parameters using the $Args reserved variable
    $File = $args[0];$Q = $args[1]

    ($FileInfo = Get-ItemProperty -Path $File).creationtime | Out-Host

    if ($Q -imatch "y"){($FileInfo.CreationTime).DayOfYear|Out-Host}
}


#Method with ($Args) on the outside of {}
Date-Created-Out -q n -File "C:\Windows"

#Method using Param () as the first set of code inside {}
Date-Created-In -Q 1 

#Method using the special $Args variable and [] to select
Date-Created-Args "C:\users\Fern"