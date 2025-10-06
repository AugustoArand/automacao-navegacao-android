*** Settings ***
Resource    ../../base.resource
Test Setup    Open Device
Test Teardown    Close All Applications

*** Test Cases ***
Cenário 01: Acessar Configurações do Dispositivo
   Swipe Up On Screen
   Capturar Screenshot Evidencia    Tela_inicial_apos_swipe
   Abrir Configuracoes
   Capturar Screenshot Evidencia    Tela_configuracoes_aberta

Cenário 02: Acessar Tela de Conexões
   Swipe Up On Screen
   Abrir Configuracoes
   Sleep    3s
   Capturar Screenshot Evidencia    Configuracoes_abertas

   # Clicar na seção "Network & internet"
   Acessar Rede e internet
   Sleep   3s
   Capturar Screenshot Evidencia    Tela_rede_e_internet

Cenário 03: Acessar Tela de Dispositivos Conectados
    Swipe Up On Screen
    Abrir Configuracoes
    Capturar Screenshot Evidencia    Configuracoes_abertas
    Sleep    3s
    
    Acessar Tela de Dispositivos Conectados
    Sleep   3s
    Capturar Screenshot Evidencia    Tela_dispositivos_conectados
    # Ativar Bluetooth se estiver desativado
    Ativação Bluetooth
    Sleep   3s
    Capturar Screenshot Evidencia    Bluetooth_ativado
  
   