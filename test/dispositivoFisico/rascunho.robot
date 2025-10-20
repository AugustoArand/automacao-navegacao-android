*** Settings ***
Resource    ../../base.resource
Test Setup    Open Terminal
Test Teardown    Close All Applications

*** Test Cases ***
Cenário 01: Validar SIM Card e Internet
    Swipe Up On 720x1280 Screen
    Tela Configurações
    Acessar Tela de Rede e Internet
    Validar SIM Card e Internet

Cenário 02: 
