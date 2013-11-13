#Clear table body to run in over and over in ISE
$TableBody,$StrBody=""

#Grab the files to check and organize them by lastwritetime
$Files = Get-ChildItem "$env:USERPROFILE\desktop\temp" |
Select-Object name,@{name="Size(MB)";expression={ "{0:N0}" -f ($_.Length / 1mb) }} |
Sort-Object 'name'

#Generate custom colored tables based on the last write time of the file
$Files | ForEach-Object {
 
                    
[int]$Var=$_.'size(mb)'

if ($Var -gt 0) {
                            
        if ($Var -gt 100)  {$TableBody+="<tr><td>$($_.name)</td><td style =`"border-style:solid;border-color: red`">$($_.'size(mb)')</td></tr>"}
        elseif ($Var -gt 50)  {$TableBody+="<tr><td>$($_.name)</td><td style =`"border-style:solid;border-color: orange`">$($_.'size(mb)')</td></tr>"}                            
        elseif ($Var -gt 10) {$TableBody+="<tr><td>$($_.name)</td><td style =`"border-style:solid;border-color: yellow`">$($_.'size(mb)')</td></tr>"}                            
        elseif ($Var -gt 5) {$TableBody+="<tr><td>$($_.name)</td><td style =`"border-style:solid;border-color: lightgreen`">$($_.'size(mb)')</td></tr>"}  
        else {$TableBody+="<tr><td>$($_.name)</td><td>$($_.'size(mb)')</td></tr>"}
    }
}


#Place the table into pre-formatted HTML Table
$Body =@"
<table>
<th>Filename</th><th>MB(s)</th>
$TableBody
</table>
"@

#Creat the CSS style for the entire report
$Head = "<Style> body {Background-color: lightblue; } table {background-color: white; margin: 5px; float: left; top: 0px; display: inline-block; padding:5px; border: 1px solid black} tr:nth-child(odd) {background-color: lightgray} </style>"

#Cram the body and the Head into completed HTML code
$HTML = ConvertTo-Html -Body $Body -Head $Head

#Create an HTML file in a temp directory
$HTML | Out-File -filepath "C:\temp\test.html" -Force
