

function VHD-Mount {
    Param (
    [Parameter(Mandatory=$True)]
    [string]$Path
    )

if (Test-Path $Path) {

    $script = "SELECT VDISK FILE=`"$path`"`r`nATTACH VDISK"
    $script | diskpart

} Else {Throw "VHD Could not be found"}

}

function VHD-UnMount {
    Param (
    [Parameter(Mandatory=$True)]
    [string]$Path
    )

if (Test-Path $Path) {

    $script = "SELECT VDISK FILE=`"$path`"`r`nDETACH VDISK"
    $script | diskpart

} Else {Throw "VHD Could not be found"}

}