#3
#$wshell = New-Object -ComObject Wscript.Shell
#$wshell.Popup("The report generation script is executed!d")
Remove-Item -Path "$env:USERPROFILE\Downloads\*" -Recurse -Force
