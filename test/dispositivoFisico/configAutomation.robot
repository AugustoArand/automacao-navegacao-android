*** Settings ***
Resource    ../../base.resource
Test Setup    Open Terminal
Test Teardown    Close All Applications

*** Test Cases ***
Cenário 01: DNS Particular
    Swipe Up On 720x1280 Screen
    Tela Configurações
    Acessar Tela de Rede e Internet
    Acessar Tela de DNS Particular
    Alterar DNS Particular Para Desativado
    Salvar Configuração DNS

Cenário 02: Acesso VPN
    Acessar Tela de VPN
    Verificar Status VPN
    Voltar Para Rede e Internet
    
Cenário 03: Economia de Dados
    Acessar Tela de Economia de Dados
    Validar Economia de Dados Desativado
    Verificar Switch Economia de Dados Estado Desativado
    Voltar Para Rede e Internet

Cenário 04: Modo Aviao
    Validar Modo Aviao

Cenário 05: Redes Moveis
    Acessar Rede Movel
    Verificar Status Dados Moveis
    Validar Roaming Desativado
    Voltar Para Rede e Internet

Cenário 06: Alerta e Limite de Dados
    Acessar Rede Movel
    Acessar Alerta e Limite de Dados
    Verificar Status Alerta Uso Dados
    Voltar Para Rede e Internet

Cenário 07: Desabilitar a Seleção de Rede Automática
    Acessar Secao Avancada
    Swipe    start_x=360    start_y=1100    end_x=360    end_y=800    duration=2s
    Verificar Status Selecao Rede Automatica

Cenário 08: Nomes dos Pontos de Acesso
    Acessar Secao Avancada
    Swipe    start_x=360    start_y=1100    end_x=360    end_y=800    duration=2s
    Acessar Nomes Pontos de Acesso
    Voltar Para Rede e Internet

Cenário 09: Validar SIM Card Ativo e Com Internet
    Acessar Tela de Rede e Internet
    Validar SIM Card e Internet
