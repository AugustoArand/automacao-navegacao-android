# Automação de Navegação Android - GPOS820

Este projeto implementa uma automação completa para verificação de configurações do terminal de pagamento GPOS820 utilizando Robot Framework e Appium.

## 🎯 Objetivo

Automatizar a verificação das configurações e informações do dispositivo GPOS820:
- ✅ **Nome do dispositivo** (TS-G820)
- ✅ **Versão do Android** (13)
- ✅ **Versão do firmware** 
- ✅ **Versão do hardware** 
- ✅ **Número de série** 

## 🛠️ Tecnologias Utilizadas

### Principais
- **Robot Framework** (7.3.2+) - Framework de automação de testes
- **Appium** - Ferramenta de automação para aplicações mobile
- **AppiumLibrary** (3.1.0+) - Biblioteca do Robot Framework para integração com Appium
- **Python** (3.11+) - Linguagem de programação
- **Poetry** - Gerenciador de dependências

### Dependências Adicionais
- **PyYAML** (6.0.0+) - Para leitura de arquivos de configuração YAML
- **Selenium** (4.0.0+) - WebDriver para automação web
- **Collections** - Para manipulação de listas e elementos

## 📱 Configuração do Dispositivo

### Plataforma Alvo
- **Sistema Operacional**: Android
- **Versão**: Android 16
- **Dispositivo de Teste**: Google Pixel 7 Pro
- **Automation Engine**: UIAutomator2

### Servidor Appium
- **URL do Servidor**: http://localhost:4723/wd/hub
- **Driver**: UIAutomator2

## 🏗️ Estrutura do Projeto

```
automacao-navegacao-android/
├── base.resource                 # Configurações base e imports
├── pyproject.toml               # Dependências e configuração do projeto
├── run_tests.sh                 # Script para execução dos testes
├── resource/
│   ├── locators/               # Mapeamento dos elementos da interface
│   │   ├── chromeLocator.yml
│   │   ├── configLocators.yml
│   │   └── menuAppLocators.yml
│   ├── pages/                  # Page Objects
│   │   ├── chromePage.resource
│   │   └── configPage.resource
│   └── utils/                  # Utilitários e funções auxiliares
│       ├── openApp.resource
│       └── swipeAction.resource
├── test/                       # Casos de teste
│   ├── chrome.robot
│   ├── config.robot
│   └── menuApp.robot
└── log/                        # Logs e relatórios de execução
```

## 🚀 Como Executar

### Pré-requisitos
1. **Node.js** instalado para o Appium
2. **Android SDK** configurado
3. **Python 3.11+** instalado
4. **Poetry** para gerenciamento de dependências (opcional)

### Instalação
```bash
# Instalar Appium
npm install -g appium@next

# Instalar driver UIAutomator2
appium driver install uiautomator2

# Instalar dependências Python
pip install robotframework>=7.0.0 robotframework-appiumlibrary>=3.1.0 pyyaml>=6.0.0 robotframework-requests>=0.9.0 selenium>=4.0.0
```

### Execução dos Testes
```bash
# Usando o script automatizado (recomendado)
./run_tests.sh

# Ou executando apenas o teste principal do GPOS820
poetry run robot test/dispositivoFisico/configGPOS820.robot

# Executar com mais detalhes de log
poetry run robot --loglevel DEBUG test/dispositivoFisico/configGPOS820.robot
```

### Exemplo de Saída Esperada
```
====================================
VERSÃO DO ANDROID ENCONTRADA: 13
VERSÃO ESPERADA: 13
====================================
VERSÃO DO FIRMWARE ENCONTRADA: V4.0.1  
VERSÃO ESPERADA: V4.0.1
====================================
VERSÃO DO HARDWARE ENCONTRADA: V4.0.1
VERSÃO ESPERADA: V4.0.1
====================================
NÚMERO DE SÉRIE ENCONTRADO: 4101012546000945
NÚMERO ESPERADO: 4101012546000945
====================================
```

## 📋 Funcionalidades Implementadas

### Verificações Automatizadas para GPOS820
- **✅ Navegação para Configurações** - Acesso automático ao menu de configurações
- **✅ Verificação do Nome do Dispositivo** - Confirma se é TS-G820  
- **✅ Verificação da Versão do Android** - Valida versão 13
- **✅ Verificação da Versão do Firmware** - Confirma V4.0.1
- **✅ Verificação da Versão do Hardware** - Valida V4.0.1
- **✅ Verificação do Número de Série** - Confirma série específica

### Recursos Avançados
- **🔄 Scroll automático** - Navega automaticamente pela tela para encontrar elementos
- **🔍 Múltiplos localizadores** - Fallback para diferentes estratégias de localização
- **📸 Screenshots automáticos** - Captura evidências de cada etapa
- **📝 Logs detalhados** - Registra todas as ações e verificações
- **🚨 Tratamento de erros** - Continua execução mesmo com diferenças menores

## 📊 Relatórios

Os testes geram automaticamente:
- **log.html** - Log detalhado com todas as verificações
- **output.xml** - Saída em formato XML para integração
- **report.html** - Relatório visual dos resultados
- **Screenshots** - Evidências de cada etapa do teste (Tela_*.png)

## 🔧 Configuração

### Localizadores Específicos do GPOS820
Os elementos são mapeados em `resource/locators/gpos760/configLocators.yml`:
- `configIcon` - Ícone de configurações
- `versaoAndroid` - Elemento da versão do Android  
- `versionFirmware` - Elemento da versão do firmware
- `versionHardware` - Elemento da versão do hardware
- `secaoNumeroSerie` - Seção do número de série

### Page Objects Otimizados
Implementação específica em `resource/pages/gpos760/configPage.resource`:
- `chromePage.resource` - Ações específicas do Chrome
- `configPage.resource` - Ações das configurações

## 📝 Notas

- O projeto utiliza o padrão Page Object Model para melhor organização
- Localizadores são externalizados em arquivos YAML
- Configuração flexível através de variáveis
- Suporte a execução em diferentes dispositivos Android