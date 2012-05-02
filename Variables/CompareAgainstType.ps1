cls
$Value = "4543",12


if ($Value -is [int]) {
Write-Host "$Value is a int"
}

if ($Value -is [string]) {
Write-Host "$Value is a string"
}


if ($Value -is [array]) {
Write-Host "$Value is a array"

    if ($Value[1] -is [int]) {
        Write-Host "The Second Value of the array is an int"
    }
}