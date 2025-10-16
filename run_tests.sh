#!/bin/bash

# Script para executar testes de automação Android
# Automação de Navegação Android - Appium + Robot Framework + Poetry
# Versão: 3.0 - Atualizado em 15/10/2025
# Suporte completo para GPOS820 - Verificação de configurações do dispositivo

set -e  # Parar execução em caso de erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funções auxiliares
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Banner do projeto
echo -e "${BLUE}"
echo "======================================================"
echo "     🚀 AUTOMAÇÃO DE NAVEGAÇÃO ANDROID 🚀           "
echo "======================================================"
echo -e "${NC}"
echo "📱 Projeto: automacao-navegacao-android"
echo "🤖 Framework: Robot Framework + Appium"
echo "📦 Gerenciador: Poetry"
echo "� Dispositivo: GPOS820 Terminal de Pagamento"
echo "�📅 Data: $(date '+%d/%m/%Y %H:%M:%S')"
echo ""
echo "✅ Funcionalidades Testadas:"
echo "   • Navegação para Configurações"
echo "   • Verificação de Nome do Dispositivo"
echo "   • Verificação de Versão do Android"
echo "   • Verificação de Versão do Firmware"
echo "   • Verificação de Versão do Hardware"
echo "   • Verificação de Número de Série"
echo ""

# Variáveis de configuração
APPIUM_PORT=${APPIUM_PORT:-4723}
APPIUM_BASE_PATH=${APPIUM_BASE_PATH:-"/wd/hub"}
LOG_DIR="log"
TEST_SUITE=${1:-"test/dispositivoFisico/configGPOS820.robot"}
APPIUM_PID=""

# Novos parâmetros específicos para GPOS820
DEFAULT_DEVICE_NAME="GPOS820"
DEFAULT_ANDROID_VERSION="13"
DEFAULT_FIRMWARE_VERSION="V4.0.1"
DEFAULT_HARDWARE_VERSION="V4.0.1"
DEFAULT_SERIAL_NUMBER="4101012546000945"

# Função de limpeza em caso de interrupção
cleanup() {
    if [ ! -z "$APPIUM_PID" ]; then
        log_warning "Interrompido! Finalizando Appium Server..."
        kill $APPIUM_PID 2>/dev/null || true
        wait $APPIUM_PID 2>/dev/null || true
    fi
    exit 1
}

# Capturar sinais de interrupção
trap cleanup SIGINT SIGTERM

# Verificar dependências do sistema
log_info "Verificando dependências do sistema..."

# Verificar se o Poetry está instalado
if ! command -v poetry &> /dev/null; then
    log_error "Poetry não encontrado. Instale com:"
    echo "   curl -sSL https://install.python-poetry.org | python3 -"
    exit 1
fi

# Verificar se o Node.js está instalado (necessário para Appium)
if ! command -v node &> /dev/null; then
    log_error "Node.js não encontrado. Instale o Node.js primeiro"
    echo "   sudo apt update && sudo apt install nodejs npm"
    exit 1
fi

# Verificar versão do Node.js
NODE_VERSION=$(node --version | cut -d 'v' -f 2 | cut -d '.' -f 1)
if [ "$NODE_VERSION" -lt 16 ]; then
    log_warning "Node.js versão $(node --version) detectada. Recomendado: v16 ou superior"
fi

# Verificar se o Appium está instalado
if ! command -v appium &> /dev/null; then
    log_warning "Appium não encontrado. Instalando..."
    npm install -g appium@next
    if [ $? -ne 0 ]; then
        log_error "Falha ao instalar Appium"
        exit 1
    fi
    log_success "Appium instalado com sucesso"
fi

# Verificar versão do Appium
APPIUM_VERSION=$(appium --version)
log_info "Appium versão: $APPIUM_VERSION"

# Verificar se o driver UIAutomator2 está instalado
log_info "Verificando driver UIAutomator2..."
if ! appium driver list | grep -q "uiautomator2.*installed"; then
    log_warning "Instalando driver UIAutomator2..."
    appium driver install uiautomator2
    if [ $? -ne 0 ]; then
        log_error "Falha ao instalar driver UIAutomator2"
        exit 1
    fi
    log_success "Driver UIAutomator2 instalado"
else
    log_success "Driver UIAutomator2 já instalado"
fi

# Verificar se o ADB está disponível
if ! command -v adb &> /dev/null; then
    log_error "ADB não encontrado. Instale o Android SDK"
    echo "   sudo apt update && sudo apt install android-tools-adb"
    exit 1
fi

# Verificar versão do ADB
ADB_VERSION=$(adb version | head -1)
log_info "ADB: $ADB_VERSION"

# Verificar dispositivos Android conectados
log_info "Verificando dispositivos Android conectados..."
adb devices -l

DEVICE_COUNT=$(adb devices | grep -c "device$")
if [ "$DEVICE_COUNT" -eq 0 ]; then
    log_error "Nenhum dispositivo Android conectado"
    echo ""
    echo "💡 Para este projeto, você precisa de:"
    echo "   📱 Dispositivo GPOS820 (Terminal de Pagamento)"
    echo "   🔧 Cabo USB para conexão"
    echo "   ⚙️  Configurações necessárias:"
    echo "      • Ative 'Opções do desenvolvedor'"
    echo "      • Ative 'Depuração USB'"
    echo "      • Conecte o terminal via USB"
    echo "      • Autorize a conexão quando solicitado"
    echo ""
    echo "   � Verificação: Execute 'adb devices' para confirmar"
    echo "   📋 Dispositivo esperado: Série $DEFAULT_SERIAL_NUMBER"
    exit 1
elif [ "$DEVICE_COUNT" -eq 1 ]; then
    DEVICE_ID=$(adb devices | grep "device$" | cut -f1)
    log_success "1 dispositivo conectado: $DEVICE_ID"
    
    # Verificar se é um GPOS820 (opcional)
    DEVICE_MODEL=$(adb shell getprop ro.product.model 2>/dev/null || echo "Unknown")
    log_info "Modelo do dispositivo: $DEVICE_MODEL"
    
else
    log_warning "$DEVICE_COUNT dispositivos conectados. Usando o primeiro disponível."
    adb devices | grep "device$" | nl
fi

log_success "Pré-requisitos verificados"

# Gerenciar dependências do projeto
log_info "Gerenciando dependências do projeto..."
if [ ! -f "pyproject.toml" ]; then
    log_error "Arquivo pyproject.toml não encontrado. Certifique-se de estar no diretório correto."
    exit 1
fi

if [ ! -f "poetry.lock" ]; then
    log_info "Primeira instalação detectada. Instalando dependências..."
    poetry install
else
    log_info "Sincronizando dependências existentes..."
    poetry install --sync
fi

# Verificar ambiente Python
log_info "Verificando ambiente Python..."
PYTHON_VERSION=$(poetry run python --version)
log_info "Python: $PYTHON_VERSION"

# Listar dependências principais
log_info "Dependências do projeto:"
poetry show --tree --only main | head -10

# Verificar e gerenciar Appium Server
log_info "Verificando status do Appium Server..."
if curl -s "http://localhost:$APPIUM_PORT/status" &> /dev/null; then
    log_success "Appium Server já está rodando na porta $APPIUM_PORT"
    APPIUM_RUNNING=true
else
    log_warning "Appium Server não está rodando. Iniciando..."
    appium server --port $APPIUM_PORT --base-path $APPIUM_BASE_PATH &
    APPIUM_PID=$!
    APPIUM_RUNNING=false
    
    log_info "Aguardando Appium Server iniciar (PID: $APPIUM_PID)..."
    for i in {1..15}; do
        if curl -s "http://localhost:$APPIUM_PORT/status" &> /dev/null; then
            log_success "Appium Server iniciado com sucesso!"
            break
        fi
        echo -n "."
        sleep 1
        if [ $i -eq 15 ]; then
            log_error "Timeout: Appium Server não iniciou em 15 segundos"
            log_error "Verifique se a porta $APPIUM_PORT está disponível"
            kill $APPIUM_PID 2>/dev/null || true
            exit 1
        fi
    done
fi

# Criar estrutura de diretórios de logs
log_info "Preparando diretórios de logs..."
mkdir -p "$LOG_DIR"
mkdir -p "$LOG_DIR/screenshots"

# Limpar logs antigos (opcional)
if [ -d "$LOG_DIR" ] && [ "$(ls -A $LOG_DIR)" ]; then
    log_info "Logs anteriores encontrados em $LOG_DIR/"
    read -p "Deseja arquivar logs antigos? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        ARCHIVE_DIR="$LOG_DIR/archive_$TIMESTAMP"
        mkdir -p "$ARCHIVE_DIR"
        mv "$LOG_DIR"/*.{html,xml,png} "$ARCHIVE_DIR/" 2>/dev/null || true
        log_success "Logs antigos arquivados em $ARCHIVE_DIR/"
    fi
fi

# Executar testes
echo ""
echo -e "${BLUE}======================================================"
echo "          🚀 INICIANDO EXECUÇÃO DOS TESTES"
echo -e "======================================================${NC}"
echo ""

log_info "Configuração da execução:"
echo "   📂 Suite de testes: $TEST_SUITE"
echo "   📁 Diretório de logs: $LOG_DIR"
echo "   🌐 Appium Server: http://localhost:$APPIUM_PORT$APPIUM_BASE_PATH"
echo "   📱 Dispositivos disponíveis: $DEVICE_COUNT"
echo "   🕒 Iniciado em: $(date '+%d/%m/%Y %H:%M:%S')"
echo ""
echo "   🎯 Valores esperados para GPOS820:"
echo "      • Nome do dispositivo: TS-G820"
echo "      • Versão do Android: $DEFAULT_ANDROID_VERSION"
echo "      • Versão do firmware: $DEFAULT_FIRMWARE_VERSION"
echo "      • Versão do hardware: $DEFAULT_HARDWARE_VERSION"
echo "      • Número de série: $DEFAULT_SERIAL_NUMBER"
echo ""

# Verificar se a suite de testes existe
if [ ! -e "$TEST_SUITE" ]; then
    log_error "Suite de testes não encontrada: $TEST_SUITE"
    log_info "Suites disponíveis:"
    echo "   📋 Testes principais:"
    find test/ -name "*.robot" -type f | while read file; do
        echo "      • $file"
    done
    echo ""
    echo "   💡 Exemplo de uso:"
    echo "      ./run_tests.sh test/dispositivoFisico/configGPOS820.robot"
    exit 1
fi

# Executar testes com Robot Framework
log_info "Executando testes de automação..."

# Argumentos para Robot Framework
ROBOT_ARGS=(
    "--outputdir" "$LOG_DIR"
    "--loglevel" "INFO"
    "--timestampoutputs"
    "--report" "report.html"
    "--log" "log.html"
    "--output" "output.xml"
    "--xunit" "xunit.xml"
)

# Adicionar argumentos opcionais se definidos
if [ ! -z "$ROBOT_INCLUDE" ]; then
    ROBOT_ARGS+=("--include" "$ROBOT_INCLUDE")
fi

if [ ! -z "$ROBOT_EXCLUDE" ]; then
    ROBOT_ARGS+=("--exclude" "$ROBOT_EXCLUDE")
fi

# Executar testes
START_TIME=$(date +%s)
poetry run robot "${ROBOT_ARGS[@]}" "$TEST_SUITE"
TEST_EXIT_CODE=$?
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

# Relatório de execução
echo ""
echo -e "${BLUE}======================================================"
echo "             📊 RELATÓRIO DE EXECUÇÃO"
echo -e "======================================================${NC}"

if [ $TEST_EXIT_CODE -eq 0 ]; then
    log_success "Todos os testes executados com sucesso! 🎉"
elif [ $TEST_EXIT_CODE -eq 1 ]; then
    log_warning "Alguns testes falharam ⚠️"
else
    log_error "Erros críticos durante a execução ❌"
fi

echo ""
echo "⏱️  Tempo de execução: ${DURATION}s"
echo "📊 Relatórios gerados:"
echo "   📄 $LOG_DIR/report.html - Relatório principal"
echo "   📄 $LOG_DIR/log.html - Log detalhado"
echo "   📄 $LOG_DIR/output.xml - Saída XML"
echo "   📄 $LOG_DIR/xunit.xml - Formato XUnit"

# Estatísticas dos testes (se disponível)
if [ -f "$LOG_DIR/output.xml" ]; then
    echo ""
    log_info "Estatísticas dos testes:"
    if command -v xmllint &> /dev/null; then
        TOTAL_TESTS=$(xmllint --xpath "count(//test)" "$LOG_DIR/output.xml" 2>/dev/null || echo "N/A")
        PASSED_TESTS=$(xmllint --xpath "count(//test[@status='PASS'])" "$LOG_DIR/output.xml" 2>/dev/null || echo "N/A")
        FAILED_TESTS=$(xmllint --xpath "count(//test[@status='FAIL'])" "$LOG_DIR/output.xml" 2>/dev/null || echo "N/A")
        
        echo "   ✅ Passou: $PASSED_TESTS"
        echo "   ❌ Falhou: $FAILED_TESTS"
        echo "   📊 Total: $TOTAL_TESTS"
        
        # Mostrar sumário das verificações se os testes passaram
        if [ "$FAILED_TESTS" = "0" ] && [ "$PASSED_TESTS" != "0" ]; then
            echo ""
            log_success "Verificações do GPOS820 realizadas com sucesso!"
            echo "   ✅ Navegação para configurações"
            echo "   ✅ Nome do dispositivo verificado"
            echo "   ✅ Versão do Android confirmada"
            echo "   ✅ Versão do firmware validada"
            echo "   ✅ Versão do hardware verificada"
            echo "   ✅ Número de série confirmado"
        fi
    else
        log_info "Install xmllint para estatísticas detalhadas: sudo apt install libxml2-utils"
    fi
fi

# Screenshots de evidência
SCREENSHOT_COUNT=$(find "$LOG_DIR" -name "*.png" 2>/dev/null | wc -l)
if [ "$SCREENSHOT_COUNT" -gt 0 ]; then
    echo "   📸 Screenshots: $SCREENSHOT_COUNT evidências capturadas"
fi

# Finalizar Appium Server se foi iniciado pelo script
if [ ! -z "$APPIUM_PID" ] && [ "$APPIUM_RUNNING" = false ]; then
    echo ""
    log_info "Finalizando Appium Server (PID: $APPIUM_PID)..."
    kill $APPIUM_PID 2>/dev/null || true
    wait $APPIUM_PID 2>/dev/null || true
    log_success "Appium Server finalizado"
fi

# Abrir relatório automaticamente (opcional)
if command -v xdg-open &> /dev/null && [ -f "$LOG_DIR/report.html" ]; then
    read -p "Deseja abrir o relatório no navegador? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        xdg-open "$LOG_DIR/report.html" &
        log_success "Relatório aberto no navegador"
    fi
fi

echo ""
echo -e "${BLUE}======================================================"
echo "           🏁 AUTOMAÇÃO FINALIZADA"
echo -e "======================================================${NC}"
echo "📅 Finalizado em: $(date '+%d/%m/%Y %H:%M:%S')"
echo ""

# Código de saída baseado no resultado dos testes
exit $TEST_EXIT_CODE