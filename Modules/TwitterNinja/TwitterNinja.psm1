
function Get-Tweets {

<#

Created by Mr.PowerScripts

More Powershell examples at 

www.youtube.com/MrPowerScripts
www.github.com/MrPowerScripts


-----------------INSTALLATION------------------------

If you have installed a previous version then use Remove-Module
to remove the old version first

1. Create a folder called "TwitterNinja" in your module folder and
 place TwitterNinja.psm1 inside of it

Type "$env:PSModulePath" in powershell to see different
module paths on your local system

C:\Users\USERNAME\Documents\WindowsPowerShell\Modules is one location you can
place the TwitterNinja folder

If it doesn't exist you can create it.

2. Inside powershell type "Get-Module -ListAvailable" and you should now
see Twitter Ninja as one of the options.

3. Type "Import-Module "TwitterNinja"

4. Type "Get-Reddits" to see if the module was installed correctly

5. Enjoying being a Twitter Ninja


------------ Usage ---------------------------------

.DESCRIPTION
This cmdlet will allow you to search twitter using any general search term - Such as Sports, WorldNews, TVShows - and displays the latest 15 tweets with that term.
If you find tweets from a user and would like to see more tweets from them, you can provide their user name to see as many as their last 200 tweets.
Finally, you can view their profile information, or launch their twitter page into your default browser from powershell.

.PARAMETER
-Search "SearchTerm" will search twitter for the provided term, and list the last 15 tweets

-User "UserName" will display the last 20 tweets from that user

-Index "Integer" can be used with -User to display up to 200 tweets.

-Profile Can be used with -User to display information from that users twitter profile.

-Browse Can be use with -User to launch their Twitter page in your local browser.

.EXAMPLE

Get-Tweets -Search Potato

Get-Tweets -User MrPowerScripts

Get-Tweets -User MrPowerScripts -Index 150

Get-Tweets -User MrPowerScripts -Profile

Get-Tweets -User MrPowerScripts -Browse

#>

    Param (
    
    [Parameter(Mandatory=$False,HelpMessage="Search the twitterverse by typing in a keyword")]
    [string]$Search,

    [Parameter(Mandatory=$False,HelpMessage="Enter a twitter name to see more info about their twitter page")]
    [string]$User,
    
    [Parameter(Mandatory=$False,HelpMessage="Array of integers to display")]
    [ValidateRange(1,200)]
    [array]$Index=(1..15),
    [switch]$New,
    [switch]$Profile,
    [switch]$Browse
    )

    cls

#Start of the search param
    if ($Search.length -gt 0) {

        if ($New -eq $True -or $TweetSearchStorage -eq $Null -or $Search.length -gt 0) {

            Write-Host "Updating info..."
            $WC = New-Object net.webclient
            try {
            $global:TweetSearchStorage = $WC.Downloadstring("http://search.twitter.com/search.json?q=$Search") | ConvertFrom-json
            } catch {

            Write-Host "Something went wrong. Maybe Twitter is down?"
            break function
            }
        }

    [array]::Reverse($Index)


    $Index | ForEach-Object {

    $ix=$_-1
        
        if (($TweetSearchStorage.results[$ix].created_at) -ne $Null) {
            
            [datetime]$CreateTime = $TweetSearchStorage.results[$ix].created_at

            Write-Host "___ $_ ____________________________________________"
            Write-Host ("Created----- "+$CreateTime.ToLocalTime())
            Write-Host ("ScreenName-- "+$TweetSearchStorage.results[$ix].From_User)
            Write-Host ("Tweet------- "+$TweetSearchStorage.results[$ix].Text)
            Write-Host ("SentTo------ "+$TweetSearchStorage.results[$ix].To_User)
            Write-Host "`n"
        
        }
    
    }

    break function
#End of search parameter
    } elseif ($user.length -gt 0) {
#Start of the user param
    [int]$count = $Index[0]
    
    if ($count-eq1) {$Count=20}

    if ($New -eq $True -or $TweetUserStorage -eq $Null -or $user.length -gt 0) {

        Write-Host "Updating Info..."
        $WC = New-Object net.webclient
        try {
        $global:TweetUserStorage = $WC.Downloadstring("https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=$user&count=$Count") | ConvertFrom-json
        } catch {

        Write-Host "Something went wrong. If you're searching tweets maybe twitter is down. If you're checking a user make sure you typed the name correctly"
        break function
        }
    }

    if ($Browse -eq $true) {

    $TwitterProfURI= "http://www.twitter.com/"+$user
    Invoke-Expression "start $TwitterProfURI"
    break function
    }

    if ($Profile -eq $true) {
        
        $Index = (1..$Count)

        [array]::Reverse($Index)

        $Index | ForEach-Object {

            $ix=$_-1

            if (($TweetUserStorage[$ix].user.screen_name) -ne "") {
                Write-Host "___________________________________________________"
                Write-Host ("ScreenName-- "+$TweetUserStorage[$ix].user.screen_name)
                Write-Host ("Name-------- "+$TweetUserStorage[$ix].user.name)
                Write-Host ("Location---- "+$TweetUserStorage[$ix].user.location)
                Write-Host ("Description- "+$TweetUserStorage[$ix].user.url)
                Write-Host ("Tweets------ "+$TweetUserStorage[$ix].user.statuses_count)
                Write-Host ("Protected--- "+$TweetUserStorage[$ix].user.protected)
                Write-Host ("Followers--- "+$TweetUserStorage[$ix].user.followers_count)
                Write-Host ("Following--- "+$TweetUserStorage[$ix].user.friends_count)
                Write-Host ("Favorites--- "+$TweetUserStorage[$ix].user.favourites_count)
                Write-Host ("TimeZone---- "+$TweetUserStorage[$ix].user.time_zone)
                Write-Host ("Language---- "+$TweetUserStorage[$ix].user.lang)

                Write-Host "`n"
            }
        break function
        }
    }

    $Index = (1..$Count)

    [array]::Reverse($Index)

    $Index | ForEach-Object {

        $ix=$_-1

            if ($TweetUserStorage[$ix].user.screen_name -ne $Null) {

                Write-Host "___ $_ ____________________________________________"
                Write-Host ("user------- "+$TweetUserStorage[$ix].user.screen_name)
                Write-Host ("Created---- "+$TweetUserStorage[$ix].created_at)
                Write-Host ("Source----- "+$TweetUserStorage[$ix].source)
                Write-Host ("text------- "+$TweetUserStorage[$ix].text)
                Write-Host ("RT Count--- "+$TweetUserStorage[$ix].Retweet_Count)
                Write-Host ("--------------------------------------------------")
                Write-Host ("Clear URL-- "+($TweetUserStorage[$ix].entities.urls | select -ExpandProperty display_url))
                Write-Host ("HashTags--- "+($TweetUserStorage[$ix].entities.hashtags | select -ExpandProperty text))
                Write-Host ("User Ment.- "+($TweetUserStorage[$ix].entities.usermentions | select -ExpandProperty screen_name))

                Write-Host "`n"
            }
        
        }

    break function
#End user parameter
    } else {Get-Help Get-Tweets}
}#End Get-Tweet



