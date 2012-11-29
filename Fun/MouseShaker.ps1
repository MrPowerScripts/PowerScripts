$Cursor = [system.windows.forms.cursor]::Clip

#[system.windows.forms.cursor]::Position = New-Object system.drawing.point(0,0)

#[system.windows.forms.cursor]::Position = New-Object system.drawing.point(($Cursor.Width/2),($Cursor.Height/2))

#Must add this line of code for [system.windows.forms.cursor]::Position to work outside of ISE
#Thanks to Meik1988 on youtube for schooling me
[System.Reflection.Assembly]::LoadWithPartialName("system.windows.forms")

for ($i=1;$i -lt 5000;$i++) {

$Position = [system.windows.forms.cursor]::Position

$PositionChange = Get-Random 20

switch (Get-Random 4) {

    0 {[system.windows.forms.cursor]::Position = New-Object system.drawing.point($Position.x, ($Position.y + $PositionChange))}
    1 {[system.windows.forms.cursor]::Position = New-Object system.drawing.point(($Position.x + $PositionChange),$Position.y)}
    2 {[system.windows.forms.cursor]::Position = New-Object system.drawing.point($Position.x, ($Position.y - $PositionChange))}
    3 {[system.windows.forms.cursor]::Position = New-Object system.drawing.point(($Position.x - $PositionChange),$Position.y)}

}

#$PositionChange
$i

}

#>