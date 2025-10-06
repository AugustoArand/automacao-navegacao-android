*** Settings ***
Library    AppiumLibrary
Library    DateTime
Library    OperatingSystem
Library    String

*** Keywords ***
Capturar Screenshot
    [Documentation]    Captura um screenshot da tela atual
    [Arguments]    ${filename}=${EMPTY}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${screenshot_filename}=    Set Variable If    '${filename}' == '${EMPTY}'    screenshot_${timestamp}.png    ${filename}
    ${screenshot_path}=    Set Variable    ${EXECDIR}/log/${screenshot_filename}
    Create Directory    ${EXECDIR}/log
    Capture Page Screenshot    ${screenshot_path}
    Log    Screenshot capturado: ${screenshot_path}
    [Return]    ${screenshot_path}

Capturar Screenshot Com Descricao
    [Documentation]    Captura um screenshot com uma descrição personalizada
    [Arguments]    ${descricao}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${safe_description}=    Replace String    ${descricao}    ${SPACE}    _
    ${safe_description}=    Replace String    ${safe_description}    /    -
    ${safe_description}=    Replace String    ${safe_description}    \\    -
    ${screenshot_filename}=    Set Variable    ${safe_description}_${timestamp}.png
    ${screenshot_path}=    Capturar Screenshot    ${screenshot_filename}
    [Return]    ${screenshot_path}

Capturar Screenshot Em Falha
    [Documentation]    Captura um screenshot quando ocorre uma falha no teste
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${screenshot_filename}=    Set Variable    falha_${timestamp}.png
    ${screenshot_path}=    Capturar Screenshot    ${screenshot_filename}
    Log    Screenshot de falha capturado: ${screenshot_path}    WARN
    [Return]    ${screenshot_path}

Capturar Screenshot Evidencia
    [Documentation]    Captura um screenshot como evidência de execução de um passo
    [Arguments]    ${passo}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${safe_step}=    Replace String    ${passo}    ${SPACE}    _
    ${safe_step}=    Replace String    ${safe_step}    /    -
    ${safe_step}=    Replace String    ${safe_step}    \\    -
    ${screenshot_filename}=    Set Variable    evidencia_${safe_step}_${timestamp}.png
    ${screenshot_path}=    Capturar Screenshot    ${screenshot_filename}
    Log    Evidência capturada para o passo: ${passo}
    [Return]    ${screenshot_path}