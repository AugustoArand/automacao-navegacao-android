*** Settings ***
Resource   ../../base.resource

*** Keywords ***
Swipe Up On Screen
    [Documentation]    Realiza um swipe para cima na tela
    [Arguments]    ${start_x}=540    ${start_y}=1500    ${end_x}=540    ${end_y}=500    ${duration}=1000
    
    # Método 1: Swipe simples
    Swipe    start_x=${start_x}    start_y=${start_y}    end_x=${end_x}    end_y=${end_y}    duration=${duration}

Swipe Up In Overview Actions
    [Documentation]    Realiza swipe de baixo para cima na região overview_actions_view
    [Arguments]    ${duration}=1000
    
    # Locator do elemento
    ${element_locator}=    Set Variable    com.google.android.apps.nexuslauncher:id/overview_actions_view
    
    # Aguardar elemento estar visível
    Wait Until Element Is Visible    ${element_locator}    10s
    
    # Obter localização e tamanho do elemento
    ${element_location}=    Get Element Location    ${element_locator}
    ${element_size}=    Get Element Size    ${element_locator}
    
    # Calcular coordenadas do swipe dentro do elemento (centro horizontal, de baixo para cima)
    ${center_x}=    Evaluate    ${element_location['x']} + ${element_size['width']} // 2
    ${start_y}=     Evaluate    ${element_location['y']} + ${element_size['height']} * 0.8
    ${end_y}=       Evaluate    ${element_location['y']} + ${element_size['height']} * 0.2
    
    # Executar swipe de baixo para cima dentro do elemento
    Swipe    start_x=${center_x}    start_y=${start_y}    end_x=${center_x}    end_y=${end_y}    duration=${duration}
    
    Log    Swipe realizado no elemento overview_actions_view: (${center_x}, ${start_y}) -> (${center_x}, ${end_y})
