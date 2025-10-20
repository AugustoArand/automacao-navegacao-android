*** Settings ***
Resource    ../../base.resource
Test Setup    Open Terminal
Test Teardown    Close All Applications

*** Test Cases ***
Cenário 01: Acessar e Verificar Dispositivos Conectados
    [Documentation]    Acessa a tela principal de dispositivos conectados e faz verificações
    Tela Configurações
    Acessar Menu de Dispositivos Conectados

Cenário 02: Verificar USB
    [Documentation]    Acessa e verifica o status do USB
    Acessar Tela de USB
    Verificar Status USB
    Voltar Para Dispositivos Conectados

Cenário 03: Parear Novo Dispositivo Bluetooth
    [Documentation]    Acessa a tela para parear novos dispositivos
    Acessar Tela de Bluetooth
    Acessar Tela de "Parear novo dispositivo"
    Verificar Dispositivos Disponiveis
    Voltar Para Dispositivos Conectados

Cenário 04: Verificar Preferências de Conexão
    [Documentation]    Acessa as preferências de conexão (Cast/Transmitir)
    Acessar Preferência de Conexão
    Verificar Dispositivos Cast Disponiveis
    Voltar Para Dispositivos Conectados
