
for (;;) {

$IP = Read-Host -Prompt "Please enter a valid IP address"

if ([bool]($IP -as [ipaddress])) {Write-Host "Thank you" -f Green;break} else {Write-Host "Invalid IP. You entered $IP" -f Red}

}

$IP