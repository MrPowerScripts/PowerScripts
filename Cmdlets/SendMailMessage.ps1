$MyEmail = "PlayingWithPowershell@gmail.com"
$SMTP= "smtp.gmail.com"
$To = "PlayingWithPowershell@gmail.com"
$Subject = "BRO!"
$Body = "WHAT UP MR.POWERSCRIPTS?"
$Creds = (Get-Credential -Credential "$MyEmail")

Start-Sleep 2

Send-MailMessage -To $to -From $MyEmail -Subject $Subject -Body $Body -SmtpServer $SMTP -Credential $Creds -UseSsl -Port 587 -DeliveryNotificationOption never

<# 
$PSEmailServer variable can be used to pre-configure the
SMTP server in your Powershell Profile. Then you don't need
to specify -smtpserver paramter. Send-MailMessage will use the
SMTP sever address assigned to $PSEmailServer


Delivery Notification Options:
-- None: No notification.        
-- OnSuccess: Notify if the delivery is successful.      
-- OnFailure: Notify if the delivery is unsuccessful.     
-- Delay: Notify if the delivery is delayed.       
-- Never: Never notify.
#>