function New-BulkHoot {
<#

.SYNOPSIS
Creates Bulk HootSuite File

.DESCRIPTION
New-BulkHoot allows you to create various types of blank HootSuite CSV files for uploading to HootSuite.com and automating your Twitter feed

.PARAMETER BulkPath
Specifies a path and filename to send the generated file to

.PARAMETER TweetInterval
Specifies time in minutes to space between Tweets. Value must end with 0 or 5.

.PARAMETER Limit
Set the limit of lines to generate in the file. Maximum limit is 50 set by HootSuite.

.Parameter IncludeTime
Includes an timestamp in the generated file starting 20 minutes from the time it's run. This timestamp specifies when scheduled tweets will be sent out. By default using this parameter will only generate enough scheduled tweets for the same day, which depends on the time when run, TweetInterval, and limit. Use -IgnoreDayChange with -IncludeTime to continue generating max scheduled tweets past current day

.PARAMETER IgnoreDayChange
Must be used with -IncludeTime. Allows you to generate tweets for the same day into the next day.

.PARAMETER NewDay
Must be used with -IncludeTime. Creates a new file for the specified date starting from midnight, and increments every 30 minutes.

.PARAMETER SetDate
Must be used with -NewDay. Provide a date in the format MM/dd/yyyy to create a new file that starts from midnight and increments every 30 minutes for a full day of tweets for that day.

.EXAMPLE
New-BulkHoot -BulkPath $Path
Will create a new BulkUpload to the path provided with 50 lines of "","","". If no path is provided the CSV will be saved to your desktop with a current timestamp

.EXAMPLE
New-BulkHoot -TweetInterval 10
Default Time Increment between tweets is 30 minutes. You can change the increment value between 10 or more minutes apart. Value must end in 0 or 5. Remember you are limited to only 50 lines per upload!

.EXAMPLE
New-BulkHoot -Limit 40
Limits the number of lines which are exported to the file. You can limit the file between 1 and 49 lines. Remember you are limited to only 50 lines per upload!

.EXAMPLE
New-BulkHoot -IncludeTime
Will create a new BulkUpload to your desktop with the date and time filled out up to 50 lines or until the end of the current day. Such as "01/23/2045 12:35","","". This parameter by default generates timestamps 20 minutes ahead of the current time.

.EXAMPLE
New-BulkHoot -IncludeTime -IgnoreDayChange
Creates a new file of up to 50 lines with date included, such as "01/23/2045 12:35","","", and does not stop generating lines when a new day begins.
Without this parameter -IncludeTime will only generate enough lines for the current day - depending on current time of day, the limit and incrememnt.

.EXAMPLE
New-BulkHoot -IncludeTime -NewDay
Creates a new file for the next day starting from midnight, and by default increments every 30 minutes. This provides the framework for a full day of tweets every half hour.

.EXAMPLE
New-BulkHoot -IncludeTime -NewDay -SetDate 12/31/2012
Creates a new file for the specified date starting from midnight, and by default increments every 30 minutes. This provides the framework for a full day of tweets every half hour. -SetDate must be used with -Newday parameter.

.LINK
www.youtube.com/MrPowerScripts

#>
[cmdletbinding()]

    param (

    [string]$BulkPath,

    [switch]$IncludeTime,

    [switch]$IgnoreDayChange,
    
    [int]$TweetInterval=30,

    [string]$SetDate,
    
    [switch]$NewDay,

    [ValidateRange(0,50)]
    [int]$Limit=50

    )

$Counter = 0
#Start time this many minutes in the future
$Minutes = 20
$Lines = ""
$CurLine = ""

#If no path provided send to desktop
if (!$BulkPath) {$BulkPath = "$env:USERPROFILE\desktop\BulkHoot$(Get-Date -Format MMddyyyy_HHmmss).csv"}

#How to validate the end of an integer when you failed at using only regex
$TweetIntervalCheck = $TweetInterval.ToString()
if ($TweetIntervalCheck[-1] -inotmatch "[05]") {throw "-TweetInterval must end in 0 or 5"}


if ($SetDate) {

    try {
    $SetDate = get-date ("$SetDate" -as [datetime]) -format MM/dd/yyyy
    } catch {Throw "Date not valid - use format MM/dd/yyyy"}
}

if ($IncludeTime) {
    
    if ($NewDay) {
        $CurDay = (Get-Date).adddays(1).day} else {$CurDay = (Get-Date).day
    }

    $TimeMap = [datetime]::ParseExact((Get-Date -Format "ddMMyyyy HH:mm"),”ddMMyyyy HH:mm",$null)

    switch ($TimeMap.Minute.ToString().length) {

        1 {$MinuteChanger = ($TimeMap.Minute).ToString().substring(0,1)}
        2 {$MinuteChanger = ($TimeMap.Minute).ToString().substring(1,1)}
    }

#adjust minute column to 0
    switch ($MinuteChanger) {

        1 {$TimeMap = $TimeMap.AddMinutes(9)}
        2 {$TimeMap = $TimeMap.AddMinutes(8)}
        3 {$TimeMap = $TimeMap.AddMinutes(7)}
        4 {$TimeMap = $TimeMap.AddMinutes(6)}
        6 {$TimeMap = $TimeMap.AddMinutes(4)}
        7 {$TimeMap = $TimeMap.AddMinutes(3)}
        8 {$TimeMap = $TimeMap.AddMinutes(2)}
        9 {$TimeMap = $TimeMap.AddMinutes(1)}
    }
}

if ($NewDay) {$Minutes = 0}
$TimeCheck = $CurDay

do {

$CurLine = ""

    if ($IncludeTime) {
 
            if ($NewDay) {

                $Timemap = $TimeMap.Date
                Write-Debug "TimeMap: $TimeMap"

                if (!$IgnoreDayChange) {
                        $TimeCheck = ($TimeMap.AddMinutes($Minutes).adddays(1)).day
                        Write-Debug "TimeCheck: $TimeCheck"
                    } else {$TimeCheck = $CurDay}
                 
                if ($TimeCheck -eq $CurDay){
                        $CurLine += "`"" + (Get-Date ($TimeMap.AddMinutes($Minutes).adddays(1)) -Format "MM/dd/yyyy HH:mm").tostring().substring(0,16)+"`",`"`",`"`"`n"
                        Write-Debug "CurLine: $CurLine"
                    }

            } else {
                
                if (!$IgnoreDayChange) {
                    $TimeCheck = ($TimeMap.AddMinutes($Minutes)).day
                    } else {$TimeCheck = $CurDay}
                
                if ($TimeCheck -eq $CurDay){
                    $CurLine += "`"" + (Get-Date ($TimeMap.AddMinutes($Minutes)) -Format "MM/dd/yyyy HH:mm").tostring().substring(0,16)+"`",`"`",`"`"`n"
                    }    
            }

        $Minutes += $TweetInterval

    } else {
    if ($NewDay) {throw "-NewDay parameter must be used with -IncludeTime"}
    if ($IgnoreDayChange) {throw "-IgnoreDayChange parameter must be used with -IncludeTime"}
    if ($SetDate) {throw "-SetDate parameter must be used with -InlcudeTime"}

    $CurLine += "`"`",`"`",`"`"`n"}

    $Lines += $CurLine

    $Counter++

} until ($Counter -eq $Limit -or $CurDay -ne $TimeCheck)

$NewLines = @()

if ($SetDate) {

    if (!$NewDay) {throw "-SetDate must be used with -NewDay parameter"}

    ($Lines -split "`n") | % {
        #Write-Host $Lines
        if ($_.length -gt 2) {

            $DateLine = ($_ -split ",")[0]
            $MessageLine = ($_ -split ",")[1]  
            $LinkLine = ($_ -split ",")[2]        
            #Write-Host "who"
            Write-Debug "DateLine: $DateLine"
            Write-Debug "Date: $Date"
            Write-Debug "Message: $Message"
            Write-Debug "Link: $LinkLine"

            $Date=$DateLine.substring(1,10)
            $NewLines += (($DateLine -replace "$Date","$SetDate") + ",$MessageLine,$LinkLine")
            
        }
    }
$Lines = $NewLines
}
#Write-Host $NewLines
Out-File -FilePath $BulkPath -InputObject $Lines -Encoding utf8 -Force

}
