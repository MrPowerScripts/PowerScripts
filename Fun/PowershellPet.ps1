#Powershell Pet
Function PetPose {

#This function returns a random number between 1 and 6
$Pose = Get-Random -Minimum 1 -Maximum 6

#Supplying the randomly generated number to the switch command tells
#Switch which pose to display

#CLS clears the screen before a new pose is displayed
cls

switch ($Pose){


    1 { 
        write-host ""
        write-host "(>''>)"
        write-host ""}

    2 { 
        write-host ""
        write-host "(<''<)"
        write-host ""}
            
    3 { 

        write-host ""
        write-host "(V''V)"
        write-host ""}
            
     4 { 
        write-host ""
        write-host "(^''^)"
        write-host ""}
    
    5 { 
        write-host ""
        write-host "<(  Y )"
        write-host ""}

    6 { 
        write-host ""
        write-host "( Y  )>"
        write-host ""}

      }

    #Sleep command pauses the text for one second

    sleep 1
}

#For loop with syntax to perform the loop infinitely 
for (;;) {

#Executes the pet pose function
PetPose

}