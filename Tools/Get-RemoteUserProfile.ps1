
function Get-RemoteProfile {

param (
[parameter(mandatory=$true)]
$Computer
)

$Cred = Get-Credential

Get-WmiObject -Class win32_userprofile -ComputerName $Computer -Credential $Cred | ft localpath,
    
    @{Name="LastUse";Expression={
    [System.Management.ManagementDateTimeconverter]::ToDateTime($_.lastusetime) 
                                }
    } -AutoSize

}