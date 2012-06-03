cls
#Assigns the input to a variable, or remove "$Var=" to pass the input to the pipeline
$Var = Read-Host -Prompt "Please Enter Your Name" -AsSecureString #| Write-Host -ForegroundColor Green



#This code will allow you to convert the secured string back to plain text
#Add "$Var2 =" to the second line of code to add it into a variable
$marshal = [Runtime.InteropServices.Marshal]
$marshal::PtrToStringAuto($marshal::SecureStringToBSTR($Var))