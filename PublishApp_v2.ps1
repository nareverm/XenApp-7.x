
####################################
## Created by Naresh Verma ####
## Date 21/12/2019
## Publish application from CSV 
## Tested in XENAPP 7.15/7.19
###################################
##Import the Data
$table = Import-Csv "C:\TEMP\LocalApps_man.csv"

for([int]$i=0;$i -le 900;$i++){

#Variables
$Client = $table[$i].ClientName
$DisplayName = $table[$i].DisplayName
$cmdexc = $table[$i].CommandLineExecutable
$cmdarg = $table[$i].cmdArg
$path = $table[$i].Path

Clear-Content "C:\Users\TEMP\Desktop\grp.txt"
$a = 1
while($a -le 38){

$b="Accounts"+$a
$table[$i].$b | Add-Content "C:\Users\TEMP\Desktop\grp.txt"

$a++
}

$adgrp = Get-Content "C:\Users\TEMP\Desktop\grp.txt"

Write-Host "Publishing Application Phase $i ........."

$a = New-BrokerApplication -DesktopGroup USMAN-MCTSPVW15_DG -WorkingDirectory "C:\Windows\system32" -AdminFolder $path -ClientFolder $path -CommandLineExecutable $cmdexc -CommandLineArguments $cmdarg -Description $cmdarg -Name $DisplayName

Write-host "Publish successfull $i..." -ForegroundColor Green

"Adding Groups $i....."

foreach($adgrps in $adgrp){if(!$adgrps){Write-host " ---ADGroup is NULL for $adgrps" -ForegroundColor Gray}else{$a | Add-BrokerUser $adgrps}}

#$a | Add-BrokerUser $ADGrp1

"AD Group addition process completed $i....."

Write-Host "Phase $i...Completed... "

}


#New-BrokerApplication -DesktopGroup USMAN-MCTSPVW15_DG -WorkingDirectory "C:\Windows\system32" -AdminFolder $path -ClientFolder $path -CommandLineExecutable C:\windows\System32\mstsc.exe -CommandLineArguments "" -Description "" -Name Notepad_test
