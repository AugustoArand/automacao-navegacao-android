*** Settings ***
Library    Collections
Resource   ../../../base.resource

*** Keywords ***
Acessar Menu de Dispositivos Conectados
    [Documentation]    Acessa a tela principal de Dispositivos Conectados
    Log    Acessando tela de Dispositivos Conectados
    # Swipe Down On 720x1280 Screen
    Click Text    Dispositivos conectados
    Sleep    2s

Acessar Tela de Bluetooth
    [Documentation]    Acessa a tela de configurações do Bluetooth
    Log    Acessando tela de Bluetooth...
    
    # Tentar múltiplos localizadores
    ${bluetooth_click}=    Run Keyword And Return Status    Click Element    ${bluetooth.bluetoothIcon}
    Sleep    2s
    Capturar Screenshot Evidencia    Tela_Bluetooth

Verificar Status Bluetooth
    [Documentation]    Verifica o status atual do Bluetooth (ativado/desativado)
    Log    Verificando status do Bluetooth...
    
    # Verificar se está ativado ou desativado
    ${bluetooth_ativado}=    Run Keyword And Return Status    Page Should Contain Text    Ativado
    ${bluetooth_on}=    Run Keyword And Return Status    Page Should Contain Text    On
    
    IF    ${bluetooth_ativado} or ${bluetooth_on}
        Log    Bluetooth está ATIVADO
        Set Test Variable    ${BLUETOOTH_STATUS}    Ativado
    ELSE
        Log    Bluetooth está DESATIVADO
        Set Test Variable    ${BLUETOOTH_STATUS}    Desativado
    END
    
    Capturar Screenshot Evidencia    Status_Bluetooth_${BLUETOOTH_STATUS}

Acessar Tela de USB
    [Documentation]    Acessa a tela de configurações USB
    Log    Acessando tela de USB...
    
    # Tentar múltiplos localizadores
    ${usb_click}=    Run Keyword And Return Status    Click Element    ${usb.usbIcon}
    Sleep    2s

Verificar Status USB
    [Documentation]    Verifica o status da conexão USB
    Log    Verificando status da conexão USB...
    
    # Verificar diferentes estados USB
    ${usb_conectado}=    Run Keyword And Return Status    Page Should Contain Text    USB conectado
    ${usb_connected}=    Run Keyword And Return Status    Page Should Contain Text    USB connected
    
    IF    ${usb_conectado} or ${usb_connected}
        Log    USB está CONECTADO
        Set Test Variable    ${USB_STATUS}    Conectado
    ELSE
        Log    USB está DESCONECTADO
        Set Test Variable    ${USB_STATUS}    Desconectado
    END
    
    Capturar Screenshot Evidencia    Status_USB_${USB_STATUS}

Acessar Tela de "Parear novo dispositivo"
    [Documentation]    Acessa a tela para parear novos dispositivos Bluetooth
    Log    Acessando tela 'Parear novo dispositivo'...
    
    # Primeiro verificar se estamos na tela do Bluetooth
    ${procurar_click}=    Run Keyword And Return Status    Click Text    Parear novo dispositivo
    Sleep    2s

Verificar Dispositivos Disponiveis
    [Documentation]    Verifica dispositivos disponíveis para emparelhamento Bluetooth
    Log    Verificando dispositivos disponíveis para emparelhamento...
    
    # Verificar se existe lista de dispositivos disponíveis
    ${dispositivos_disponiveis}=    Run Keyword And Return Status    Page Should Contain Text    Dispositivos disponíveis
    ${available_devices_en}=    Run Keyword And Return Status    Page Should Contain Text    Available devices
    
    IF    ${dispositivos_disponiveis} or ${available_devices_en}
        Log    Dispositivos disponíveis para emparelhamento encontrados
        Set Test Variable    ${DISPOSITIVOS_DISPONIVEIS}    Disponíveis
    ELSE
        Log    Nenhum dispositivo disponível para emparelhamento
        Set Test Variable    ${DISPOSITIVOS_DISPONIVEIS}    Nao_Encontrados
    END
    
    # Capturar screenshot da tela mostrando os dispositivos disponíveis para conexão
    Capturar Screenshot Evidencia    Dispositivos_Disponiveis_${DISPOSITIVOS_DISPONIVEIS}

Acessar Preferência de Conexão
    [Documentation]    Acessa as preferências de conexão dos dispositivos
    Log    Acessando preferências de conexão...
    
    # Tentar acessar diferentes seções de preferências
    Click Text    Preferências de conexão
    Sleep    2s
    Capturar Screenshot Evidencia    Tela_Preferencia_Conexao

Verificar Dispositivos Cast Disponiveis
    [Documentation]    Verifica dispositivos disponíveis para transmissão/cast
    Log    Verificando dispositivos de cast disponíveis...
    
    ${cast_disponiveis}=    Run Keyword And Return Status    Page Should Contain Text    Dispositivos disponíveis
    ${available_cast}=    Run Keyword And Return Status    Page Should Contain Text    Available devices
    
    IF    ${cast_disponiveis} or ${available_cast}
        Log    Dispositivos de cast disponíveis encontrados
        Set Test Variable    ${CAST_DISPOSITIVOS}    Disponíveis
    ELSE
        Log    Nenhum dispositivo de cast disponível
        Set Test Variable    ${CAST_DISPOSITIVOS}    Indisponíveis
    END
    
    Capturar Screenshot Evidencia    Cast_Dispositivos_${CAST_DISPOSITIVOS}

Acessar Ver Todos
    [Documentation]    Acessa a opção 'Ver todos' os dispositivos conectados
    Log    Acessando 'Ver todos' os dispositivos...
    
    # Tentar encontrar opção "Ver todos" ou similar
    ${ver_todos_click}=    Run Keyword And Return Status    Click Text    Ver todos
    
    Sleep    2s
    Capturar Screenshot Evidencia    Tela_Ver_Todos_Dispositivos

Listar Todos Dispositivos Conectados
    [Documentation]    Lista todos os dispositivos conectados encontrados
    Log    Listando todos os dispositivos conectados...
    
    # Capturar informações dos dispositivos na tela
    ${tem_bluetooth}=    Run Keyword And Return Status    Page Should Contain Text    Bluetooth
    ${tem_usb}=    Run Keyword And Return Status    Page Should Contain Text    USB
    ${tem_wifi}=    Run Keyword And Return Status    Page Should Contain Text    Wi-Fi
    
    # Gerar relatório
    Log    === RELATÓRIO DISPOSITIVOS CONECTADOS ===
    Log    Bluetooth presente: ${tem_bluetooth}
    Log    USB presente: ${tem_usb}
    Log    Wi-Fi presente: ${tem_wifi}
    Log    ========================================
    
    Capturar Screenshot Evidencia    Lista_Todos_Dispositivos

Voltar Para Dispositivos Conectados
    [Documentation]    Volta para a tela principal de Dispositivos Conectados
    Log    Voltando para tela de Dispositivos Conectados...
    
    ${voltar_click}=    Run Keyword And Return Status    Click Element    ${controles_gerais.btnVoltar}
    