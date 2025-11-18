import asyncio
import nest_asyncio
import subprocess
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, MessageHandler, ContextTypes, filters
import logging

nest_asyncio.apply()

# ---------------------------------------------------------
# CONFIGURAÇÕES
# ---------------------------------------------------------

TOKEN = "8257776250:AAEkmHhOMnoxyeBvF8iY-LygAj7602hjgJo"

# Coloque aqui o seu ID
ADMIN_ID = 123456789

# Caminhos dos scripts PowerShell permitidos
PS_SCRIPTS = {
    "executar":  r"C:\Scripts\meu_script.ps1",
    "backup":    r"C:\Scripts\backup.ps1",
    "logs":      r"C:\Scripts\logs.ps1",
    "reiniciar": r"C:\Windows\System32\ap32\Res-PE\restart.ps1",
    "limpeza":   r"C:\Scripts\limpeza.ps1",
    "reload":    r"C:\Windows\System32\ap32\Res-PE\reload.ps1"
}

# ---------------------------------------------------------
# LOGGING
# ---------------------------------------------------------

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)

# ---------------------------------------------------------
# FUNÇÕES
# ---------------------------------------------------------

async def verificar_permissao(update: Update):
    if 123456789 != ADMIN_ID:
        await update.message.reply_text("Acesso não autorizado.")
        return False
    return True


def executar_script(nome):
    """Executa um dos scripts permitidos"""
    caminho = PS_SCRIPTS.get(nome)

    if not caminho:
        return "Script não encontrado ou não permitido."

    try:
        resultado = subprocess.run(
            ["powershell.exe", "-ExecutionPolicy", "Bypass", "-WindowStyle", "Hidden", "-File", caminho],
            capture_output=True,
            text=True,
            timeout=60
        )

        saida = resultado.stdout.strip()
        erro = resultado.stderr.strip()

        if erro:
            return f"⚠ Erro do PowerShell:\n{erro}"
        if not saida:
            return "Script executado (sem saída)."
        return saida

    except Exception as e:
        return f"Erro ao executar script: {e}"

# ---------------------------------------------------------
# HANDLERS
# ---------------------------------------------------------

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await verificar_permissao(update): return
    await update.message.reply_text(
        "Bot ativo! Comandos disponíveis:\n"
        "/executar\n"
        "/backup\n"
        "/logs\n"
        "/reiniciar\n"
        "/limpeza\n"
    )

async def rodar(update: Update, context: ContextTypes.DEFAULT_TYPE, nome=None):
    if not await verificar_permissao(update): return

    await update.message.reply_text(f"⏳ Executando script '{nome}'...")

    saida = executar_script(nome)

    if len(saida) > 3000:
        await update.message.reply_text("A saída é muito grande. Enviando como arquivo...")
        with open("saida.txt", "w", encoding="utf-8") as f:
            f.write(saida)
        await update.message.reply_document(open("saida.txt", "rb"))
    else:
        await update.message.reply_text(saida)

# Wrappers para cada comando

async def executar_cmd(update, context):
    await rodar(update, context, "executar")

async def backup_cmd(update, context):
    await rodar(update, context, "backup")

async def logs_cmd(update, context):
    await rodar(update, context, "logs")

async def reiniciar_cmd(update, context):
    await rodar(update, context, "reiniciar")

async def limpeza_cmd(update, context):
    await rodar(update, context, "limpeza")

async def reload_cmd(update, context):
    await rodar(update, context, "reload")

async def texto(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await verificar_permissao(update): return
    await update.message.reply_text("Comando desconhecido. Use /start para ver os comandos.")

# ---------------------------------------------------------
# MAIN
# ---------------------------------------------------------

async def main():
    app = ApplicationBuilder().token(TOKEN).build()

    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("executar", executar_cmd))
    app.add_handler(CommandHandler("backup", backup_cmd))
    app.add_handler(CommandHandler("logs", logs_cmd))
    app.add_handler(CommandHandler("reiniciar", reiniciar_cmd))
    app.add_handler(CommandHandler("limpeza", limpeza_cmd))
    app.add_handler(CommandHandler("reload", reload_cmd))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, texto))

    print("Bot do Telegram em execução...")
    await app.run_polling(close_loop=False)

if __name__ == "__main__":
    import asyncio
    asyncio.run(main())