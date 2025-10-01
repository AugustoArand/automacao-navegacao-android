*** Settings ***
Resource   ../../base.resource

*** Keywords ***
Acessar Chrome
    [Documentation]    Abre o aplicativo Chrome no dispositivo Android
    Wait Until Element Is Visible    ${chrome.chromeApp}
    Click Element    ${chrome.chromeApp}

    # Verifica se o botão Skip aparece
    ${skip_exists}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${chrome.chromeSkip}    10s
    Run Keyword If    ${skip_exists}    Click Element    ${chrome.chromeSkip}

    # Verifica se o botão Negative aparece
    ${negative_exists}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${chrome.chromeNegativeButton}    10s
    Run Keyword If    ${negative_exists}    Click Element    ${chrome.chromeNegativeButton}

    # Se nenhum dos dois botões aparecer, valida apenas se o Chrome foi aberto na página inicial
    Run Keyword If    not ${skip_exists} and not ${negative_exists}    
    ...    Wait Until Element Is Visible    ${chrome.chromeHomePage}    10s