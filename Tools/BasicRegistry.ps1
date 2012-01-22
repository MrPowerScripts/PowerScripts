
#New-Item -Path "HKCU:\potato"

#new-ItemProperty -Path "HKCU:\potato" -Name Spud -Value 12345 -PropertyType string 

#Set-ItemProperty -Path "HKCU:\potato" -Name Spud -Value 54321

#new-ItemProperty -Path "HKCU:\potato" -Name Spuds -Value 67890 -PropertyType string 

#Get-Item -Path HKCU:\potato

#Get-ItemProperty -Path HKCU:\potato -Name Spud | Select-Object spud

#Remove-ItemProperty -Path HKCU:\potato -name spud

#Remove-Item -Path HKCU:\potato