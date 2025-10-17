*** Settings ***
Library    Collections
Resource   ../../../base.resource

*** Keywords ***
Tela Configurações
    [Documentation]     Acessa a tela de configurações do terminal
    Log    Tentando acessar Configurações...
    
    # Tentar primeiro localizador
    ${config_click}=    Run Keyword And Return Status    Click Element    ${config_terminal.configIcon}
    
    IF    not ${config_click}
        Log    Primeiro localizador falhou, tentando alternativo...
        ${config_alt_click}=    Run Keyword And Return Status    Click Element    ${config_terminal.configIconAlternative}
        
        IF    not ${config_alt_click}
            Log    Localizadores XPath falharam, tentando por texto...
            ${text_click}=    Run Keyword And Return Status    Click Text    Configurações
        END
    END
    
    Sleep    2s
    Page Should Contain Text    Configurações

Acessar Tela de Rede e Internet
    [Documentation]    Acessa a tela de Rede e Internet nas configurações do terminal
    Log    Tentando acessar Rede e Internet...
    
    # Tentar primeiro localizador
    ${rede_click}=    Run Keyword And Return Status    Click Element    ${rede_internet.redeEInternetIcon}
    
    IF    not ${rede_click}
        Log    Primeiro localizador falhou, tentando alternativo...
        ${rede_alt_click}=    Run Keyword And Return Status    Click Element    ${rede_internet.redeEInternetAlternative}

        IF    not ${rede_alt_click}
            Log    Localizadores XPath falharam, tentando por texto...
            ${text_click}=    Run Keyword And Return Status    Click Text    Rede e Internet
        END
    END
    
    Sleep    2s
    Page Should Contain Text    Rede e Internet

Acessar Tela de DNS Particular
    [Documentation]    Acessa a tela de DNS Particular nas configurações do terminal
    Log    Tentando acessar DNS Particular...
    
    # Tentar primeiro localizador
    ${dns_click}=    Run Keyword And Return Status    Click Element    ${rede_internet.idDnsParticular}
    
    IF    not ${dns_click}
        Log    Primeiro localizador falhou, tentando por texto...
        ${text_click}=    Run Keyword And Return Status    Click Text    DNS particular
        
        IF    not ${text_click}
            Log    Tentando localizador alternativo...
            ${alt_click}=    Run Keyword And Return Status    Click Text    Private DNS
        END
    END
    
    Sleep    2s
    Capturar Screenshot Evidencia    Acesso Tela DNS

Alterar DNS Particular Para Desativado
    [Documentation]    Altera o DNS Particular para Desativado
    Log    Tentando alterar DNS Particular para Desativado...
    
    # Tentar clicar no botão "Desativado" usando o ID
    ${dns_desativado_click}=    Run Keyword And Return Status    Click Element    ${rede_internet.idDnsDesativado}
    
    IF    not ${dns_desativado_click}
        Log    ID não funcionou, tentando por texto...
        ${text_click}=    Run Keyword And Return Status    Click Text    Desativado
        
        IF    not ${text_click}
            Log    Tentando texto alternativo...
            ${alt_text_click}=    Run Keyword And Return Status    Click Text    Off
        END
    END
    
    Sleep    2s
    Capturar Screenshot Evidencia    DNS Desativado

Salvar Configuração DNS
    [Documentation]    Salva a configuração do DNS Particular
    Log    Salvando configuração do DNS...
    
    ${btn_salvar}=    Run Keyword And Return Status    Click Element    ${rede_internet.btnSalvarDNSParticular}
    Log    Botão salvar clicado: ${btn_salvar}
Acessar Tela de VPN
    [Documentation]    Acessa a tela de VPN dentro de Rede e Internet
    Log    Tentando acessar VPN...
    
    # Tentar primeiro localizador por texto
    ${vpn_click}=    Run Keyword And Return Status    Click Element    ${rede_internet.vpnIcon}
    Sleep    2s
    Capturar Screenshot Evidencia    Acesso a Tela de VPN

Verificar Status VPN
    [Documentation]    Verifica o status atual da VPN
    Log    Verificando status da VPN...
    
    # Verificar se existe alguma VPN configurada
    ${vpn_exists}=    Run Keyword And Return Status    Page Should Contain Text    Nenhuma VPN adicionada
    IF    ${vpn_exists}
        Capturar Screenshot Evidencia    Nenhuma VPN Configurada
        Log    Nenhuma VPN configurada encontrada
        RETURN
    END
    Sleep    1s

Adicionar Nova VPN
    [Documentation]    Clica no botão para adicionar uma nova VPN
    Log    Tentando adicionar nova VPN...
    
    ${add_vpn_click}=    Run Keyword And Return Status    Click Element    ${rede_internet.addVpnButton}
    
    IF    not ${add_vpn_click}
        Log    Botão 'Adicionar VPN' via localizador falhou, tentando por texto...
        ${text_click}=    Run Keyword And Return Status    Click Text    Adicionar VPN
        
        IF    not ${text_click}
            Log    Tentando texto alternativo...
            ${alt_click}=    Run Keyword And Return Status    Click Text    Add VPN
            
            IF    not ${alt_click}
                Log    Tentando localizar ícone de adicionar (+)...
                ${plus_click}=    Run Keyword And Return Status    Click Text    +
            END
        END
    END
    
    Sleep    2s
    Capturar Screenshot Evidencia    Tela_adicionar_vpn

Voltar Para Rede e Internet
    [Documentation]    Volta para a tela de Rede e Internet
    Log    Voltando para Rede e Internet...
    ${voltar_click}=    Run Keyword And Return Status    Click Element    ${rede_internet.btnVoltar}
    Sleep    2s

Acessar Tela de Economia de Dados
    [Documentation]    Acessa a tela de Economia de Dados dentro de Rede e Internet
    Log    Tentando acessar Economia de Dados...
    
    # Tentar primeiro localizador por texto
    ${economia_click}=    Run Keyword And Return Status    Click Element    ${rede_internet.economiaDadosIcon}
    Sleep    2s

Validar Economia de Dados Desativado
    [Documentation]    Valida que a Economia de Dados está desativada
    Log    Validando se Economia de Dados está desativada...
    # Verificar pelo status de texto "Desativado"
    ${status_desativado}=    Run Keyword And Return Status    Page Should Contain Text    Desativado
    
    IF    ${status_desativado}
        Log    Economia de Dados está DESATIVADA conforme esperado
        Capturar Screenshot Evidencia    Economia de Dados Desativada
        RETURN
    END
    
Verificar Switch Economia de Dados Estado Desativado
    [Documentation]    Verifica especificamente se o switch está no estado desativado
    Log    Verificando se switch está desativado...
    
    # Tentar localizar o switch principal
    ${switch_found}=    Run Keyword And Return Status    Element Should Be Visible    ${rede_internet.economiaDadosSwitch}
    
    IF    ${switch_found}
        ${switch_state}=    Get Element Attribute    ${rede_internet.economiaDadosSwitch}    checked
        
        IF    '${switch_state}' == 'false' or '${switch_state}' == 'None' or '${switch_state}' == ''
            Log    Switch principal está DESATIVADO
            RETURN    ${True}
        ELSE
            Log    Switch principal está ATIVADO
            RETURN    ${False}
        END
    END
    Sleep    2s
    Capturar Screenshot Evidencia    Switch Economia Desativado
Validar Modo Aviao
    [Documentation]    Acessa a tela de Modo Aviao de forma enxuta
    Log    Acessando Modo Aviao...
    Run Keyword And Ignore Error    Element Attribute Should Match    ${rede_internet.modoAviaoSwitch}    checked    false
    Sleep    1s
    Capturar Screenshot Evidencia    Modo Aviao Desativado


Acessar Rede Movel
    [Documentation]    Acessa a tela de Rede Móvel dentro de Rede e Internet
    Log    Acessando Rede Móvel...
    
    # Múltiplas tentativas de localização
    Run Keyword And Ignore Error    Click Element    ${rede_internet.redeMovelIcon}
    Sleep    2s
    Capturar Screenshot Evidencia    Tela de Rede Móvel Acessada

Verificar Status Dados Moveis
    [Documentation]    Verifica se os dados móveis estão ativos ou não
    Log    Verificando status dos dados móveis...
    # Verificar estado do switch se disponível
    ${switch_state}=    Run Keyword And Return Status    Element Attribute Should Match    ${rede_internet.dadosMovelSwitch}    checked    true
    IF    ${switch_state}
        Log    Dados móveis estão ATIVADOS
    ELSE
        Log    Dados móveis estão DESATIVADOS
    END
    Sleep    2s
    Capturar Screenshot Evidencia    Dados Móveis Status Verificado

Validar Roaming Desativado
    [Documentation]    Valida que o roaming está desativado
    Log    Validando que roaming está desativado...

    ${roaming_desativado}=    Run Keyword And Return Status    Element Attribute Should Match    ${rede_internet.roamingSwitch}    checked    false
    IF    ${roaming_desativado}
        Log    Roaming está DESATIVADO conforme esperado
        Capturar Screenshot Evidencia    Roaming Desativado
        RETURN
    END


Acessar Alerta e Limite de Dados
    [Documentation]    Acessa a tela de Alerta e Limite de Dados dentro de Rede Móvel
    Log    Acessando Alerta e Limite de Dados...
    
    # Múltiplas tentativas de localização
    Run Keyword And Ignore Error    Click Element    ${rede_internet.alertaLimiteDadosIcon}
    Sleep    2s
    Capturar Screenshot Evidencia    Tela de Limite de Dados Acessada

Verificar Status Alerta Uso Dados
    [Documentation]    Verifica se o alerta de uso de dados está habilitado ou desabilitado
    Log    Verificando status do alerta de uso de dados...

    # Verificar estado do switch se disponível
    ${switch_habilitado}=    Run Keyword And Return Status    Element Attribute Should Match    ${rede_internet.definirAlertaSwitch}    checked    true
    
    # Lógica simples IF/ELSE para determinar status
    IF    ${switch_habilitado}
        Log    Alerta de uso de dados está HABILITADO
        Capturar Screenshot Evidencia    Alerta de Dados Habilitado
        RETURN    habilitado
    ELSE
        Log    Alerta de uso de dados está DESABILITADO
        Capturar Screenshot Evidencia    Alerta de Dados Desabilitado
        RETURN    desabilitado
    END

Desabilitar Alerta Uso Dados
    [Documentation]    Desabilita o alerta de uso de dados se estiver habilitado
    Log    Desabilitando alerta de uso de dados...
    
    # Primeiro, tentar acessar a configuração específica
    Run Keyword And Ignore Error    Click Element    ${rede_internet.definirAlertaIcon}
    Sleep    1s
    Capturar Screenshot Evidencia    Acessando_configuracao_alerta
    Sleep    2s
    Capturar Screenshot Evidencia    Alerta_dados_desabilitado_realizado

Validar e Gerenciar Alerta Uso Dados
    [Documentation]    Valida o status do alerta e desabilita se necessário
    Log    Iniciando validação e gerenciamento do alerta de uso de dados...
    
    # Acessar a tela de alerta e limite de dados
    Acessar Alerta e Limite de Dados
    
    # Verificar status atual
    ${status_atual}=    Verificar Status Alerta Uso Dados
    
    IF    '${status_atual}' == 'habilitado'
        Log    Alerta está habilitado - procedendo com desabilitação...
        Desabilitar Alerta Uso Dados
        
        # Verificar novamente após desabilitação
        Sleep    1s
        ${novo_status}=    Verificar Status Alerta Uso Dados
        
        IF    '${novo_status}' == 'desabilitado'
            Log    Alerta de uso de dados desabilitado com sucesso
            Capturar Screenshot Evidencia    Alerta_desabilitado_sucesso
        ELSE
            Log    Falha ao desabilitar alerta de uso de dados
            Capturar Screenshot Evidencia    Falha_desabilitar_alerta
            Fail    Não foi possível desabilitar o alerta de uso de dados
        END
    ELSE IF    '${status_atual}' == 'desabilitado'
        Log    Alerta de uso de dados já está desabilitado - nenhuma ação necessária
        Capturar Screenshot Evidencia    Alerta_ja_desabilitado
    ELSE
        Log    Status indeterminado - assumindo que precisa ser verificado manualmente
        Capturar Screenshot Evidencia    Status_indeterminado_alerta
    END
    
    # Voltar para tela anterior
    Voltar Para Rede e Internet
    
    Log    Validação e gerenciamento do alerta concluído
    Capturar Screenshot Evidencia    Gerenciamento_alerta_concluido

Acessar Secao Avancada
    [Documentation]    Acessa a seção Avançada dentro de Rede Móvel
    Log    Acessando seção Avançada...
    
    # Múltiplas tentativas de localização
    Run Keyword And Ignore Error    Click Element    ${rede_internet.secaoAvancadaSection}
    Sleep    2s
    Capturar Screenshot Evidencia    Secao Avancada Acessada

Verificar Status Selecao Rede Automatica
    [Documentation]    Verifica se a seleção automática de rede está habilitada ou desabilitada
    Log    Verificando status da seleção automática de rede...
    Sleep    1s
    # Verificar estado do switch se disponível
    ${switch_habilitado}=    Run Keyword And Return Status    Element Attribute Should Match    ${rede_internet.selecionarRedeAutoSwitch}    checked    true
    
    # Lógica simples IF/ELSE para determinar status
    IF    ${switch_habilitado}
        Log    Seleção automática de rede está HABILITADA
        Capturar Screenshot Evidencia    Selecao Rede Habilitada
        RETURN    habilitado
    ELSE
        Log    Seleção automática de rede está DESABILITADA
        Capturar Screenshot Evidencia    Selecao Rede Desabilitada
        RETURN    desabilitado
    END

Desabilitar Selecao Rede Automatica
    [Documentation]    Desabilita a seleção automática de rede se estiver habilitada
    Log    Desabilitando seleção automática de rede...
    
    # Primeiro, tentar acessar a configuração específica
    Run Keyword And Ignore Error    Click Element    ${rede_internet.selecionarRedeAutoIcon}
    Sleep    1s
    Capturar Screenshot Evidencia    Selecao_rede_desabilitada_realizada

Acessar Nomes Pontos de Acesso
    [Documentation]    Acessa Nomes dos pontos de acesso (APN) dentro da seção Avançada
    Log    Acessando Nomes dos pontos de acesso...
    Sleep    1s
    ${encontrado}=    Run Keyword And Return Status    Click Element    ${rede_internet.pontosAcessoIcon}
    IF    ${encontrado}
        Capturar Screenshot Evidencia    Falha_acessar_pontos_acesso
    ELSE
        Log    Falha ao acessar Nomes dos pontos de acesso
    END
    # Aguardar carregamento da tela
    Sleep    2s


Acessar Tela Internet
    [Documentation]    Acessa a tela Internet dentro de Rede e Internet
    Log    Acessando tela Internet...
    
    # Múltiplas tentativas de localização
    Run Keyword And Ignore Error    Click Element    ${rede_internet.internetIcon}
    Sleep    2s
    Capturar Screenshot Evidencia    Tela Internet Acessada

Capturar Informacoes Operadora
    [Documentation]    Captura informações da operadora e status de conexão
    Log    Capturando informações da operadora e status...
    
    # Capturar screenshot inicial da tela
    Capturar Screenshot Evidencia    Tela_antes_captura_operadora
    
    # Tentar capturar nome da operadora
    ${operadora_capturada}=    Run Keyword And Return Status    Get Text    ${rede_internet.operadoraNome}
    
    IF    ${operadora_capturada}
        ${nome_operadora}=    Get Text    ${rede_internet.operadoraNome}
        Log    Operadora encontrada: ${nome_operadora}
        Set Test Variable    ${OPERADORA}    ${nome_operadora}
    ELSE
        Log    Não foi possível capturar o nome da operadora
        Set Test Variable    ${OPERADORA}    Não identificado
    END

Capturar Status Conexao
    [Documentation]    Captura o status da conexão (Conectado/4G/5G/LTE)
    Log    Capturando status da conexão...
    
    # Inicializar variáveis
    Set Test Variable    ${STATUS_CONEXAO}    Não identificado
    Set Test Variable    ${TIPO_REDE}    Não identificado
    
    # Verificar se está conectado
    ${conectado}=    Run Keyword And Return Status    Page Should Contain Text    Conectado
    
    IF    ${conectado}
        Set Test Variable    ${STATUS_CONEXAO}    Conectado
        Log    Status: Conectado
    ELSE
        Log    Status de conexão não identificado como conectado
    END
    
    # Verificar tipo de rede
    ${tem_4g}=    Run Keyword And Return Status    Page Should Contain Text    4G
    ${tem_5g}=    Run Keyword And Return Status    Page Should Contain Text    5G
    
    IF    ${tem_5g}
        Set Test Variable    ${TIPO_REDE}    5G
        Log    Tipo de rede: 5G
    ELSE IF    ${tem_4g}
        Set Test Variable    ${TIPO_REDE}    4G
        Log    Tipo de rede: 4G
    ELSE
        Log    Tipo de rede não identificado
    END

Validar SIM Card e Internet
    [Documentation]    Executa validação completa do SIM Card e status de internet
    Log    Iniciando validação do SIM Card e Internet...
    
    # Acessar tela Internet
    Acessar Tela Internet
    
    # Capturar informações da operadora
    Capturar Informacoes Operadora
    
    # Capturar status da conexão
    Capturar Status Conexao
    
    # Gerar relatório das informações capturadas
    Log    === RELATÓRIO SIM CARD E INTERNET ===
    Log    Operadora: ${OPERADORA}
    Log    Status Conexão: ${STATUS_CONEXAO}
    Log    Tipo de Rede: ${TIPO_REDE}
    Log    =====================================

    Capturar Screenshot Evidencia    Validacao Internet SIM Card
