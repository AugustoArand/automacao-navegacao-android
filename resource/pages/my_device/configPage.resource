*** Settings ***
Resource   ../../../base.resource

*** Keywords ***
Acessar Rede e internet
    Wait Until Element Is Visible    ${connection.connectionIcon}    10s
    Click Element    ${connection.connectionIcon}
    Sleep    2s
    # Inserir alguma verificação para garantir que esteja na tela

Acessar Tela de Wifi
    Wait Until Element Is Visible    ${connection.wifiInfo}    10s
    Click Element    ${connection.wifiInfo}

Ativação Wifi
    Wait Until Element Is Visible    ${connection.wifiScreenSwitch}    10s
    ${wifi_state}=    Get Element Attribute    ${connection.wifiScreenSwitch}    checked
    Log    Estado atual do WiFi: ${wifi_state}
    Run Keyword If    '${wifi_state}' == 'false'    Click Element    ${connection.wifiScreenSwitch}
    ...    ELSE    Log    WiFi já está habilitado

Acessar Tela de Dispositivos Conectados
    Wait Until Element Is Visible    ${connection.connectionScreen}    10s
    Wait Until Element Is Visible    ${connection.bluetoothInfo}    10s
    Click Element    ${connection.bluetoothInfo}
    Sleep    2s
    # Inserir alguma verificação para garantir que esteja na tela

Ativação Bluetooth
    Wait Until Element Is Visible    ${connection.bluetoothScreenSwitch}    10s
    ${bluetooth_state}=    Get Element Attribute    ${connection.bluetoothScreenSwitch}    checked
    Log    Estado atual do Bluetooth: ${bluetooth_state}
    Run Keyword If    '${bluetooth_state}' == 'false'    Click Element    ${connection.bluetoothScreenSwitch}
    ...    ELSE    Log    Bluetooth já está habilitado
