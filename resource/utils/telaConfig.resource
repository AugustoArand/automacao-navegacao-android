*** Settings ***
Library    AppiumLibrary
Library    DateTime
Library    OperatingSystem
Library    String

*** Keywords ***
Acessar Tela Configurações Terminal
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