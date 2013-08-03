
#None of this will work through an already open excel application
#You must open Excel and workbooks you want to manipulate via the COMobject

####################################################
############### Starting Excel #####################
####################################################

$Excel = New-Object -ComObject Excel.Application

$Excel.Visible = $true
$Excel.DisplayAlerts = $false

####################################################
############## Working with Workbooks ##############
####################################################

#Add a workbook to your current excel file
#You can add multiple workbooks with this method
$Excel.Workbooks.Add()

#Find all the workbooks in your excel file by name
$Excel.Workbooks | Select-Object -ExpandProperty name

#Activate a specifc workbook in your excel file
$Excel.Workbooks.Item(2).activate()
$Excel.Workbooks.Item("book1").activate()

#Acivate Random Workbook in Excel file
$Excel.Workbooks.Item((Get-Random -min 1 -Max ($Excel.Workbooks.Count+1))).activate()

#Open an existing workbook on your hardrive
$Excel.Workbooks.Open("$env:userprofile\desktop\mrpowerscripts.xlsx")

#close workbooks from an excel file
$Excel.Workbooks.Item(1).close()
$Excel.Workbooks.Item("MrPowerScripts.xlsx").close()

#Save workbooks to the hard drive
$Excel.Workbooks.item(1).SaveAs("$env:userprofile\Desktop\asdf.xlsx")


####################################################
########### Working with Worksheets ################
####################################################

#These bits of code will affect the active Workbook.

#Add a worksheet to your active workbook
$Excel.Worksheets.Add()

#Find all worksheets in your active workbook
$Excel.Worksheets | Select-Object -ExpandProperty name

#Change name of worksheet in workbook
$Excel.Worksheets.Item(1).name = "potato"
$Excel.Worksheets.Item("potato").name = "spud"

#Activate specific worksheet in workbook
$Excel.Worksheets.Item(2).activate()
$Excel.Worksheets.Item("sheet3").activate()

#Acivate Random Worksheet in Excel file
$Excel.Worksheets.Item((Get-Random -min 1 -Max ($Excel.Worksheets.Count+1))).activate()

#Delete worksheets from workbook
$Excel.Worksheets.Item(1).delete()
$Excel.Worksheets.Item("Sheet3").delete()


####################################################
########## Cleaning up the environment #############
####################################################

$Excel.Workbooks.Close()
$Excel.Quit()

#Check and you will see an excel process still exists after quiting
#Remove the excel process by piping it to stop-porcess
Get-Process excel | Stop-Process -Force

#Now we must release the $excel com object to ready it for garbage collection
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel)
