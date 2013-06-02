
#Create a wscript.shell object
$ComObj = New-Object -ComObject WScript.Shell

#Use the createshortcut method and assign to a variable
$ShortCut = $ComObj.CreateShortcut("$Env:USERPROFILE\desktop\My Shortcut.lnk")

#Path to file shorcut will open
$ShortCut.TargetPath = "$PSHOME\powershell.exe"

#Describe the shortcut
$ShortCut.Description = "This is my shortcut! Rawr!"

#Returns the fullpatth you defined for the shortcut
$ShortCut.FullName 

#How the window will behave when opened
$ShortCut.WindowStyle = 7
#1 - Activates and displays a window. If the window is minimized or maximized, the system restores it to its original size and position.
#3 - Activates the window and displays it as a maximized window.
#7 - Minimizes the window and activates the next top-level window.

#Create a hotkey shortcut for your shortcut
$ShortCut.Hotkey = "CTRL+SHIFT+F5"
#Modifiers include - ALT+, CTRL+, SHIFT+, EXT+.
#KeyName - a ... z, 0 ... 9, F1 .. F12

#Provide an icon for your shortcut
$ShortCut.IconLocation = "$Env:USERPROFILE\desktop\favicon.ico"
#If left blank it will use the icon for the file you're calling

$ShortCut.Save()


#Create a wscript.shell object
$ComObj = New-Object -ComObject WScript.Shell

#Use the createshortcut method and assign to a variable
$ShortCut = $ComObj.CreateShortcut("$Env:USERPROFILE\desktop\My Web Shortcut.url")

#Path to URL
$ShortCut.TargetPath = "http://www.youtube.com/mrpowerscripts"

$ShortCut.Save()
