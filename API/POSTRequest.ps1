$URL = "https://api.github.com"
$Endpoint = "/gists"

$URLAnon = "$URL$Endpoint"


$JSON = ConvertTo-Json @{
          description = "the description for this gist";
          public =  $true;
          files = @{
            "file1.txt" = @{
              content = "String file contents"
            }
          }
        }


$gist = Invoke-RestMethod -Method Post -Uri $URLAnon -Body $JSON

$Token = "?access_token=92a3af3c5ebc6afbfc0018db3215a490058b8537"
$URLSecure = "$URL$Endpoint$Token"

$gist = Invoke-RestMethod -Method Post -Uri $URLSecure -Body $JSON

$URLEdit = "$URL$Endpoint/$($gist.id)$Token"

$JSON2 = ConvertTo-Json @{
          description = "Potato";
          public =  $true;
          files = @{
            "file1.txt" = @{
              content = "I'm Hungry"
            }
          }
        }

$gist = Invoke-RestMethod -Method Post -Uri $URLEdit -Body $JSON2
