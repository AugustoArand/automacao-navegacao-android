*** Settings ***
Resource    ../../base.resource
Test Setup    Open Device
Test Teardown    Close All Applications

*** Test Cases ***
Cenário: Acessar Configurações do Dispositivo
   Swipe Up On Screen
   Abrir Configuracoes
   # Clicar na seção "About emulated device"
   Clicar About Device
   
   # Primeiro obter o texto do elemento IMEI
   ${imei_obtido}=    Get Text    ${config.IMEI}
   Should Contain    ${imei_obtido}    867400022047199

Cenário: Acessar Tela de Conexões
   Swipe Up On Screen
   Abrir Configuracoes
   # Clicar na seção "Network & internet"
  