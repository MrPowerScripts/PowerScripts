<#
Created by Mr.PowerScripts
More Powershell examples at www.youtube.com/MrPowerScripts
Become a Reddit ninja with this CMDLET
You can easily browse reddit from within a powershell console


-----------------INSTALLATION------------------------

1. Create a folder called "RedditNinja" in your module folder and
 place RedditNinja.psm1 inside of it

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

- lets you show specific reddits from the stored index in three different ways
    a. Get-Reddits -Index 5 --- for a single record inside the index
    b. Get-Reddits -Index (1,5,13,25) --- will return only the index numbers specified
    c. Get_Reddits -Index (5..7) --- will return the items between 5 and 7. i.e (5,6,7)

#Get-reddits -Browse (integer set)

- Works the same way as -Index, except the values you provide here will launch those
specific indexes into your default browser.

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
    [array]
    $Index=(1..25),

    [Parameter(Mandatory=$False,HelpMessage="Enter a value between 1-25 to open this reddit page in a browser")]
    [ValidateRange(1,25)]
    [array]
    $Browse,
    
    [Parameter(Mandatory=$False,HelpMessage="Use this flag alone to download new reddits")]
    [Switch]
    $New,

    [Parameter(Mandatory=$False,HelpMesssage="Enter the name of a known subreddit to download the reddits")]
    [ValidateLength(30)]
    [string]
    $Sub
    )



    if ($Sub.length-gt0-eq$true) {

        Write-Host "Downloading new sub threads"
        $WC = New-Object net.webclient
        $global:SubRedditStorage = $WC.Downloadstring("http://www.reddit.com/r/$Sub/.json") | ConvertFrom-json
        Write-Host "Threads Updated"

    }

    #Redownload the reddit jason which may have new items
    if ($New-eq$true-or$RedditStorage-eq$Null) {
        
        if ($Sub.length-gt0-eq$true) {

            Write-Host "Downloading new threads"
            $WC = New-Object net.webclient
            $global:RedditStorage = $WC.Downloadstring("http://www.reddit.com/.json") | ConvertFrom-json
            Write-Host "Threads Updated"
        
            break function
        }
        
        
        Write-Host "Downloading new threads"
        $WC = New-Object net.webclient
        $global:RedditStorage = $WC.Downloadstring("http://www.reddit.com/.json") | ConvertFrom-json
        Write-Host "Threads Updated"
        
    break function
    }

    #Browse switch to lauch a reddit thread in your default browser
    if ($browse.count-gt0-eq$true) {

        $Browse | ForEach-Object {
            $ix = $_-1
            $RedditURI= "http://www.reddit.com"+$RedditStorage.data.children.Item(($ix)).data.permalink
            Invoke-Expression "start $RedditURI"
        }
    break function
    }

    #Reverse the array to show the most popular items at the bottom
    [array]::Reverse($Index)

    #Pass the items in the array to the foreach object, and display the content based on the index values submitted
    $Index | ForEach-Object {
        
        $ix = $_-1

        "`n_ $_ ______________________________________________________"
        "title-------- "+$RedditStorage.data.children.Item($ix).data.title
        "url---------- "+$RedditStorage.data.children.Item($ix).data.url
        "PermaLink---- www.reddit.com"+$RedditStorage.data.children.Item($ix).data.permalink
        "score-------- "+$RedditStorage.data.children.Item($ix).data.score
        "ups---------- "+$RedditStorage.data.children.Item($ix).data.ups
        "downs-------- "+$RedditStorage.data.children.Item($ix).data.downs
        "author------- "+$RedditStorage.data.children.Item($ix).data.author
        "Num_Comments- "+$RedditStorage.data.children.Item($ix).data.num_comments
    }
}

