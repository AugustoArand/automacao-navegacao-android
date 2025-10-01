#!/bin/bash

# Script para executar testes de automação Android
# Automação de Navegação Android - Appium + Robot Framework + Poetry

echo "=== Automação de Navegação Android ==="
echo "📱 Projeto: automacao-navegacao-android"
echo "🤖 Framework: Robot Framework + Appium"
echo "📦 Gerenciador: Poetry"
echo ""

# Verificar se o Poetry está instalado
if ! command -v poetry &> /dev/null; then
    echo "❌ Poetry não encontrado. Instale com:"
    echo "   curl -sSL https://install.python-poetry.org | python3 -"
    exit 1
fi

# Verificar se o Node.js está instalado (necessário para Appium)
if ! command -v node &> /dev/null; then
    echo "❌ Node.js não encontrado. Instale o Node.js primeiro"
    exit 1
fi

# Verificar se o Appium está instalado
if ! command -v appium &> /dev/null; then
    echo "❌ Appium não encontrado. Instalando..."
    npm install -g appium@next
    if [ $? -ne 0 ]; then
        echo "❌ Falha ao instalar Appium"
        exit 1
    fi
fi

# Verificar se o driver UIAutomator2 está instalado
echo "🔍 Verificando driver UIAutomator2..."
if ! appium driver list | grep -q "uiautomator2.*installed"; then
    echo "📥 Instalando driver UIAutomator2..."
    appium driver install uiautomator2
    if [ $? -ne 0 ]; then
        echo "❌ Falha ao instalar driver UIAutomator2"
        exit 1
    fi
fi

# Verificar se o ADB está disponível
if ! command -v adb &> /dev/null; then
    echo "❌ ADB não encontrado. Instale o Android SDK"
    exit 1
fi

# Verificar se há dispositivos conectados
echo "🔍 Verificando dispositivos Android..."
if ! adb devices | grep -q "device$"; then
    echo "❌ Nenhum dispositivo Android conectado ou emulador rodando"
    echo "💡 Dicas:"
    echo "   • Conecte um dispositivo via USB com debug ativado"
    echo "   • Ou inicie um emulador Android"
    echo "   • Execute 'adb devices' para verificar"
    exit 1
fi

echo "✅ Pré-requisitos verificados"

# Instalar/atualizar dependências do projeto com Poetry
echo "📦 Verificando dependências do projeto..."
if [ ! -f "poetry.lock" ]; then
    echo "🔄 Instalando dependências..."
    poetry install
else
    echo "🔄 Sincronizando dependências..."
    poetry install --sync
fi

# Verificar se o Appium Server está rodando
echo "🔍 Verificando Appium Server..."
if ! curl -s http://localhost:4723/status &> /dev/null; then
    echo "⚠️  Appium Server não está rodando. Iniciando..."
    appium server --port 4723 --base-path /wd/hub &
    APPIUM_PID=$!
    echo "⏳ Aguardando Appium Server iniciar..."
    sleep 8
    
    # Verificar novamente se está rodando
    if ! curl -s http://localhost:4723/status &> /dev/null; then
        echo "❌ Falha ao iniciar Appium Server"
        echo "💡 Verifique se a porta 4723 está disponível"
        exit 1
    fi
    echo "✅ Appium Server iniciado (PID: $APPIUM_PID)"
else
    echo "✅ Appium Server já está rodando"
fi

# Criar diretório de logs se não existir
mkdir -p log

# Executar testes usando Poetry
echo ""
echo "🚀 Executando testes de automação..."
echo "📍 Dispositivo alvo: Google Pixel 7 Pro (Android 16)"
echo "🔧 Engine: UIAutomator2"
echo ""

poetry run robot --outputdir log --loglevel INFO test/

# Verificar resultado da execução
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Testes executados com sucesso!"
    echo "📊 Relatórios disponíveis em:"
    echo "   📄 log/report.html - Relatório principal"
    echo "   📄 log/log.html - Log detalhado"
    echo "   📄 log/output.xml - Saída XML"
else
    echo ""
    echo "❌ Alguns testes falharam. Verifique os relatórios em log/"
fi

# Opcional: matar o Appium Server se foi iniciado por este script
if [ ! -z "$APPIUM_PID" ]; then
    echo ""
    echo "🛑 Parando Appium Server..."
    kill $APPIUM_PID
    wait $APPIUM_PID 2>/dev/null
    echo "✅ Appium Server finalizado"
fi

echo ""
echo "🏁 Automação finalizada"