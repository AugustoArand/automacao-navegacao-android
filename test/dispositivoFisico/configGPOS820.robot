*** Settings ***
Resource    ../../base.resource
Test Setup    Open Terminal
Test Teardown    Close All Applications

*** Test Cases ***
Cenário 01: Acessar Configurações do Terminal
    Swipe Up On 720x1280 Screen
    Capturar Screenshot Evidencia    Tela_inicial_apos_swipe
    Acessar Configurações do Terminal
    Capturar Screenshot Evidencia    Tela_configurações_terminal

    Ir Para Sobre o Dispositivo
    Capturar Screenshot Evidencia    Tela_sobre_o_dispositivo

    Verificar Nome do Dispositivo
    Capturar Screenshot Evidencia    Tela_nome_do_dispositivo

    Verificar a Versão do android
    Capturar Screenshot Evidencia    Tela_versao_do_android

    Verificar a Versão do Firmware
    Capturar Screenshot Evidencia    Tela_versao_do_firmware

    Verificar a Versão do Hardware
    Capturar Screenshot Evidencia    Tela_versao_do_hardware

    Verificar o Numero de Serie
    Capturar Screenshot Evidencia    Tela_numero_de_serie