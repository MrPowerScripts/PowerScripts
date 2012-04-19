


$WebClient = New-Object net.webclient

$Json = $WebClient.Downloadstring("http://www.reddit.com/.json") | ConvertFrom-Json


$Keys=@()
(0..($Json.data.children.count-1)) | ForEach-Object {

        $Keys+= @{
            "title"=$Json.data.children.Item($_).data.title
            "url"=$Json.data.children.Item($_).data.url
            "PermaLink"=$Json.data.children.Item($_).data.permalink
            "score"=$Json.data.children.Item($_).data.score
            "ups"=$Json.data.children.Item($_).data.ups
            "downs"=$Json.data.children.Item($_).data.downs
            "author"=$Json.data.children.Item($_).data.author
            "Num_Comments"=$Json.data.children.Item($_).data.num_comments
            "over_18"=$Json.data.children.Item($_).data.over_18
            "subreddit"=$Json.data.children.Item($_).data.subreddit
            "domain"=$Json.data.children.Item($_).data.domain
            "banned_by"=$Json.data.children.Item($_).data.banned_by
            "media_embed"=$Json.data.children.Item($_).data.media_embed
            "selftext_html"=$Json.data.children.Item($_).data.selftext_html
            "selftext"=$Json.data.children.Item($_).data.selftext
            "likes"=$Json.data.children.Item($_).data.likes
            "saved"=$Json.data.children.Item($_).data.saved
            "clicked"=$Json.data.children.Item($_).data.clicked
            "approved_by"=$Json.data.children.Item($_).data.approved_by
            "hidden"=$Json.data.children.Item($_).data.hidden
            "thumbnail"=$Json.data.children.Item($_).data.thumbnail
            "subreddit_id"=$Json.data.children.Item($_).data.subreddit_id
            "author_flair_css_class"=$Json.data.children.Item($_).data.author_flair_css_class
            "is_self"=$Json.data.children.Item($_).data.is_self
            "name"=$Json.data.children.Item($_).data.name
            "id"=$Json.data.children.Item($_).data.id
            "created"=$Json.data.children.Item($_).data.created
            "author_flair_text"=$Json.data.children.Item($_).data.author_flair_text
            "created_utc"=$Json.data.children.Item($_).data.created_utc
            "media"=$Json.data.children.Item($_).data.media
            "num_reports"=$Json.data.children.Item($_).data.num_reports
            
            }
}


function Get-Reddit {
    
    Param (
    
    [Parameter(Mandatory=$False,HelpMessage="Enter one or more values 1 or (1,4,15) or (3..7)")]
    [ValidateRange(1,25)]
    [array]
    $Index=(1..25),

    [Parameter(Mandatory=$False,HelpMessage="Enter a value between 1-25")]
    [ValidateRange(1,25)]
    [int]
    $Browse,
    
    [Parameter(Mandatory=$False,HelpMessage="Use this flag alone to download new reddits")]
    [Switch]
    $New
    )

    #Redownload the reddit jason which may have new items
    if ($New) {
    $WC = New-Object net.webclient
    $RedditStorage = $WC.Downloadstring("http://www.reddit.com/.json") | ConvertFrom-json
    break function
    }

    #Browse switch to lauch a reddit thread in your default browser
    if ($browse) {
        $RedditURI= "http://www.reddit.com"+$RedditStorage.data.children.Item(($Browse-1)).data.permalink
        Invoke-Expression "start $RedditURI"
        break function
    }
    
    #Reverse the array to show the most popular items at the bottom
    [array]::Reverse($Index)

    #Pass the items in the array to the foreach object, and display the content based on the index number
    $Index | ForEach-Object {
        
        $ix = $_-1

        "`n_ $_ _________ $_ _________ $_ _____________ $_ ___________ $_ ______"
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


