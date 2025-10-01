# Automação de Navegação Android

Este projeto implementa uma automação para navegação em aplicativos Android utilizando Robot Framework e Appium.

## 🛠️ Tecnologias Utilizadas

### Principais
- **Robot Framework** (7.0.0+) - Framework de automação de testes
- **Appium** - Ferramenta de automação para aplicações mobile
- **AppiumLibrary** (3.1.0+) - Biblioteca do Robot Framework para integração com Appium
- **Python** (3.11+) - Linguagem de programação

### Dependências Adicionais
- **PyYAML** (6.0.0+) - Para leitura de arquivos de configuração YAML
- **Selenium** (4.0.0+) - WebDriver para automação web
- **RobotFramework-Requests** (0.9.0+) - Para requisições HTTP

### Dependências de Desenvolvimento
- **RobotFramework-DebugLibrary** (4.0.0+) - Para debug dos testes
- **RobotFramework-Lint** (1.0.0+) - Para análise estática do código

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
pip install robotframework robotframework-appiumlibrary pyyaml selenium
```

### Execução dos Testes
```bash
# Usando o script automatizado
./run_tests.sh

# Ou executando diretamente
robot test/
```

### Iniciar Servidor Appium
```bash
appium -pa wd/hub
```

## 📋 Funcionalidades Implementadas

### Aplicações Testadas
- **Chrome** - Navegação e abertura do navegador
- **Configurações** - Acesso às configurações do sistema
- **Menu de Aplicativos** - Navegação pelo menu principal

### Ações Disponíveis
- Abertura de aplicações
- Navegação por menus
- Ações de swipe/deslizar
- Captura de screenshots
- Geração de relatórios HTML

## 📊 Relatórios

Os testes geram automaticamente:
- **log.html** - Log detalhado da execução
- **output.xml** - Saída em formato XML
- **report.html** - Relatório visual dos resultados
- **Screenshots** - Capturas de tela em caso de falhas

## 🔧 Configuração

### Localizadores
Os elementos da interface são mapeados em arquivos YAML para facilitar manutenção:
- `chromeLocator.yml` - Elementos do Chrome
- `configLocators.yml` - Elementos das configurações
- `menuAppLocators.yml` - Elementos do menu de apps

### Page Objects
Implementação do padrão Page Object para organização:
- `chromePage.resource` - Ações específicas do Chrome
- `configPage.resource` - Ações das configurações

## 📝 Notas

- O projeto utiliza o padrão Page Object Model para melhor organização
- Localizadores são externalizados em arquivos YAML
- Configuração flexível através de variáveis
- Suporte a execução em diferentes dispositivos Android