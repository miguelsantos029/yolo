import asyncio
import nest_asyncio
import subprocess
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, MessageHandler, ContextTypes, filters
import logging

nest_asyncio.apply()


TOKEN = "8438311215:AAG4JFC3Lkqx2l6Cx3nQZmmnpU6Fn_sbHgE"
ADMIN_ID = 123456789


PS_SCRIPTS = {
    "reiniciar": r"C:\Windows\System32\ap32\Res-PE\restart.ps1",
    "mute":     r"C:\Windows\System32\ap32\Res-PE\mute.ps1",
    "extract":     r"C:\Windows\System32\ap32\Res-PE\extract.ps1",
    "print":     r"C:\Windows\System32\ap32\Res-PE\print.ps1",
    "reload":    r"C:\Windows\System32\ap32\Res-PE\reload.ps1"
}


logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)


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


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await verificar_permissao(update): return
    await update.message.reply_text(
        "Bot ativo! Comandos disponíveis:\n"
        "\n"
        "\n"
        "  /reiniciar\n"
        "\n"
        "  /extract\n"
        "\n"
        "⚠ /mute\n"
        "\n"
        "⚠ /print\n"
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


async def reiniciar_cmd(update, context):
    await rodar(update, context, "reiniciar")

async def mute_cmd(update, context):
    await rodar(update, context, "mute")  

async def print_cmd(update, context):
    await rodar(update, context, "print")

async def reload_cmd(update, context):
    await rodar(update, context, "reload")

async def extract_cmd(update, context):
    await rodar(update, context, "extract")

async def texto(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await verificar_permissao(update): return
    await update.message.reply_text("Comando desconhecido. Use /start para ver os comandos.")

async def main():
    app = ApplicationBuilder().token(TOKEN).build()

    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("reiniciar", reiniciar_cmd))
    app.add_handler(CommandHandler("mute", mute_cmd))
    app.add_handler(CommandHandler("extract", extract_cmd))
    app.add_handler(CommandHandler("print", print_cmd))
    app.add_handler(CommandHandler("reload", reload_cmd))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, texto))

    print("Bot do Telegram em execução...")
    await app.run_polling(close_loop=False)

if __name__ == "__main__":
    import asyncio
    asyncio.run(main())
