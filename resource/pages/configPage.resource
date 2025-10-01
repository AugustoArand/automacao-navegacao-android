*** Settings ***
Resource   ../../base.resource

*** Keywords ***
Abrir Configuracoes
    [Documentation]    Abre o aplicativo de Configurações do Android
    
    # Método 1: Usando o nome do pacote
    Start Activity    com.android.settings    .Settings
    
    # OU Método 2: Usando intent
    #Start Activity    android.settings    android.intent.action.SETTINGS
    
    # OU Método 3: Clicando no ícone (se visível)
    #Wait Until Element Is Visible    ${config.configIcon}   10s
    #Click Element    ${config.configIcon}

Clicar About Device
    [Documentation]    Clica na seção "About emulated device" nas configurações
    
    # Tenta diferentes estratégias para encontrar o elemento "About device"
    ${about_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${config.aboutDevice}    5s
    
    Run Keyword If    ${about_found}
    ...    Click Element    ${config.aboutDevice}
    ...    ELSE
    ...    Run Keywords
    ...        Log    Tentando localizar por texto "About emulated device"
    ...        AND    Wait Until Element Is Visible    ${config.aboutDeviceText}    10s
    ...        AND    Click Element    ${config.aboutDeviceText}
    
    Sleep    2s    # Aguardar carregamento da próxima tela
    