@ECHO off
cls
ECHO 1 - CMD
ECHO 2 - PoSh
ECHO 3 - PoSh ISE
ECHO -------------------
set /p Choice=Select Environment?: 

IF %CHOICE% == 1 RunAs /user:SuperBeamer\MrPowerScripts %windir%\System32\cmd.exe
IF %CHOICE% == 2 RunAs /user:SuperBeamer\MrPowerScripts %windir%\System32\WindowsPowerShell\v1.0\powershell.exe
IF %CHOICE% == 3 RunAs /user:SuperBeamer\MrPowerScripts %windir%\System32\WindowsPowerShell\v1.0\powershell_ise.exe

if %ERRORLEVEL% == 1 pause
