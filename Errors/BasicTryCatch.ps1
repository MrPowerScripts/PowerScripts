cls
Try {

    [int]$Variable = "asdf"


}

Catch {

    Write-Host "You dun goofed!"
    Write-Host $_

}
