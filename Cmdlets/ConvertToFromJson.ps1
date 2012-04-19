#Create a JSON object model from Get-Process
Get-Process | ConvertTo-Json | Out-File C:\SomeFolder\SomeFile.txt

#Download JSON model of the Reddit front page, and load it as a powershell object
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