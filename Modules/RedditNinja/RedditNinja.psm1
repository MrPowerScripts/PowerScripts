<#
Created by Mr.PowerScripts

More Powershell examples at www.youtube.com/MrPowerScripts

Become a Reddit ninja with this CMDLET
You can easily browse reddit from within a powershell console

1.2
Fixed a bug that caused an error when trying to lauch main reddits from a browser

Version 1.1
Added -Sub parameter to seach through subreddits

Version 1.0

-----------------INSTALLATION------------------------

If you have installed a previous version then use Remove-Module
to remove the old version first

1. Create a folder called "RedditNinja" in your module folder and
 place RedditNinja.psm1 inside of it

Type "$env:PSModulePath" in powershell to see different
module paths on your local system

C:\Users\USERNAME\Documents\WindowsPowerShell\Modules is one location you can
place the RedditNinja folder

If it doesn't exist you can create it.

2. Inside powershell type "Get-Module -ListAvailable" and you should now
see Reddit Ninja as one of the options.

3. Type "Import-Module "RedditNinja"

4. Type "Get-Reddits" to see if the module was installed correctly

5. Enjoying being a Reddit Ninja

-----------------USAGE-----------------------

#Get-Reddits 

     -will check if it has reddits stored, and if not will download
     the lastest 25 from reddit.com, and display them

#Get-Reddits -new

    -forces Get-Reddits to download the lastest set of 25 from reddit.com

#Get-Reddits -Index (integer set)

    -lets you show specific reddits from the stored index in three different ways
        a. Get-Reddits -Index 5 --- for a single record inside the index
        b. Get-Reddits -Index (1,5,13,25) --- will return only the index numbers specified
        c. Get_Reddits -Index (5..7) --- will return the items between 5 and 7. i.e (5,6,7)

#Get-reddits -Browse (integer set)

    -Works the same way as -Index, except the values you provide here will launch those
    specific indexes into your default browser.

#Get-Reddits -sub SubRedditName
    -downloads and displays subreddits from the specified subreddit

    -Note: the -new and -browse can be used with -Sub as well
        Get-Reddits -sub gaming -new
        Get-Reddits -sub Gaming -browse 1,5,6

#>

function Get-Reddits {
    <#
    .Description
    Run this cmdlet without any parameters to list all 25 articles on the reddit front page.
    Supply the browse parameter with a reddit  to lauch it in the default browser
    #>

    Param (
    
    [Parameter(Mandatory=$False,HelpMessage="Enter one or more values 1 or (1,4,15) or (3..7)")]
    [ValidateRange(1,25)]
    [array]$Index=(1..25),

    [Parameter(Mandatory=$False,HelpMessage="Enter a value between 1-25 to open this reddit page in a browser")]
    [ValidateRange(1,25)]
    [array]$Browse,
    
    [Parameter(Mandatory=$False,HelpMessage="Use this flag alone to download new reddits")]
    [switch]$New,

    [Parameter(Mandatory=$False,HelpMessage="Enter the name of a known subreddit to download the reddits")]
    [AllowEmptyString()]
    [string]$Sub
    )
    cls

    if ($Sub.length -eq 0) {

        if ($New -eq $True -or $MainStorage -eq $Null) {
            
            Write-Host "Downloading new main threads"
            
            try {

                $WC = New-Object net.webclient         
                $global:MainStorage = $WC.Downloadstring("http://www.reddit.com/.json") | ConvertFrom-json
            
            } catch {

                Write-Host "Error: Did you type the correct Subreddit? Is Reddit.com down?" 
            break function
            }
            
            Write-Host "Threads Updated"
        
        break function
        }

        if ($browse.count -gt 0 -eq $true) {
            
            $Browse | ForEach-Object {
                $ix = $_-1

                $RedditURI= "http://www.reddit.com"+$MainStorage.data.children.Item(($ix)).data.permalink
                Invoke-Expression "start $RedditURI"

            }
        break function
        }
        
        [array]::Reverse($Index)

        $Index | ForEach-Object {
        
        $ix = $_-1

        "`n_ $_ ______________________________________________________"
        "title-------- "+$MainStorage.data.children.Item($ix).data.title
        "url---------- "+$MainStorage.data.children.Item($ix).data.url
        "PermaLink---- www.reddit.com"+$MainStorage.data.children.Item($ix).data.permalink
        "score-------- "+$MainStorage.data.children.Item($ix).data.score
        "ups---------- "+$MainStorage.data.children.Item($ix).data.ups
        "downs-------- "+$MainStorage.data.children.Item($ix).data.downs
        "author------- "+$MainStorage.data.children.Item($ix).data.author
        "Num_Comments- "+$MainStorage.data.children.Item($ix).data.num_comments
        }

    } elseif ($Sub.length -gt 0) {

        if ($new -eq $True -or $Sub -ne $SubReddit) {

            Write-Host "Downloading new sub threads"
            
            try {
            
                $WC = New-Object net.webclient
                $global:SubStorage = $WC.Downloadstring("http://www.reddit.com/r/$sub/.json") | ConvertFrom-json
            
            } catch {

                Write-Host "Error: Did you type the correct Subreddit? Is Reddit.com down?" 
            
            break function
            }
            
            Write-Host "Threads Updated"

        }

        if ($browse.count -gt 0 -eq $true) {

            $Browse | ForEach-Object {
                $ix = $_-1
                $SubRedditURI= "http://www.reddit.com"+$SubStorage.data.children.Item(($ix)).data.permalink
                Invoke-Expression "start $SubRedditURI"
            }
        
        break function
        
        }

        $Global:Subreddit=$Sub

            [array]::Reverse($Index)

            $Index | ForEach-Object {
            
            $ix = $_-1

            "`n_ $_ ______________________________________________________"
            "title-------- "+$SubStorage.data.children.Item($ix).data.title
            "url---------- "+$SubStorage.data.children.Item($ix).data.url
            "PermaLink---- www.reddit.com"+$SubStorage.data.children.Item($ix).data.permalink
            "score-------- "+$SubStorage.data.children.Item($ix).data.score
            "ups---------- "+$SubStorage.data.children.Item($ix).data.ups
            "downs-------- "+$SubStorage.data.children.Item($ix).data.downs
            "author------- "+$SubStorage.data.children.Item($ix).data.author
            "Num_Comments- "+$SubStorage.data.children.Item($ix).data.num_comments
            
            }
        
        }
    }#End Else
#End Get-Reddits
