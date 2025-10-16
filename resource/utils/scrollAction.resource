*** Settings ***
Resource   ../../base.resource

*** Keywords ***
Scroll Down On Screen
    [Documentation]    Realiza um scroll para baixo na tela
    [Arguments]    ${start_x}=540    ${start_y}=500    ${end_x}=540    ${end_y}=1500    ${duration}=1000
    
    # Método 1: Scroll simples de cima para baixo
    Swipe    start_x=${start_x}    start_y=${start_y}    end_x=${end_x}    end_y=${end_y}    duration=${duration}
    
    Log    Scroll down realizado: (${start_x}, ${start_y}) -> (${end_x}, ${end_y})

Scroll Down In Element
    [Documentation]    Realiza scroll para baixo dentro de um elemento específico
    [Arguments]    ${element_locator}    ${duration}=1000
    
    # Aguardar elemento estar visível
    Wait Until Element Is Visible    ${element_locator}    10s
    
    # Obter localização e tamanho do elemento
    ${element_location}=    Get Element Location    ${element_locator}
    ${element_size}=    Get Element Size    ${element_locator}
    
    # Calcular coordenadas do scroll dentro do elemento (centro horizontal, de cima para baixo)
    ${center_x}=    Evaluate    ${element_location['x']} + ${element_size['width']} // 2
    ${start_y}=     Evaluate    ${element_location['y']} + ${element_size['height']} * 0.2
    ${end_y}=       Evaluate    ${element_location['y']} + ${element_size['height']} * 0.8
    
    # Executar scroll de cima para baixo dentro do elemento
    Swipe    start_x=${center_x}    start_y=${start_y}    end_x=${center_x}    end_y=${end_y}    duration=${duration}
    
    Log    Scroll down realizado no elemento ${element_locator}: (${center_x}, ${start_y}) -> (${center_x}, ${end_y})

Scroll Down On 720x1280 Screen
    [Documentation]    Realiza um scroll para baixo na tela 720x1280
    [Arguments]    ${duration}=2s
    
    Swipe    start_x=360    start_y=200    end_x=360    end_y=1000    duration=${duration}
    
    Log    Scroll down realizado na tela 720x1280

Scroll Down Multiple Times
    [Documentation]    Realiza múltiplos scrolls para baixo
    [Arguments]    ${times}=3    ${interval}=0.5s    ${duration}=1000
    
    FOR    ${i}    IN RANGE    ${times}
        Scroll Down On Screen    duration=${duration}
        Sleep    ${interval}
    END
    
    Log    Realizados ${times} scrolls para baixo

Scroll Down Until Element Visible
    [Documentation]    Realiza scroll para baixo até que um elemento específico fique visível
    [Arguments]    ${element_locator}    ${max_scrolls}=10    ${scroll_duration}=1000    ${wait_timeout}=2s
    
    ${scroll_count}=    Set Variable    0
    
    WHILE    ${scroll_count} < ${max_scrolls}
        ${element_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${element_locator}    ${wait_timeout}
        
        IF    ${element_visible}
            Log    Elemento ${element_locator} encontrado após ${scroll_count} scrolls
            BREAK
        END
        
        Scroll Down On Screen    duration=${scroll_duration}
        ${scroll_count}=    Evaluate    ${scroll_count} + 1
        Sleep    0.5s
    END
    
    IF    ${scroll_count} >= ${max_scrolls}
        Fail    Elemento ${element_locator} não foi encontrado após ${max_scrolls} tentativas de scroll
    END

Scroll Down With Touch Action
    [Documentation]    Realiza scroll para baixo usando Touch Action
    [Arguments]    ${start_x}=540    ${start_y}=500    ${end_x}=540    ${end_y}=1500    ${duration}=1000
    
    # Criar Touch Action para scroll
    ${touch_action}=    Create Touch Action
    Press    ${start_x}    ${start_y}
    Wait    ${duration}
    Move To    ${end_x}    ${end_y}
    Release
    Perform    ${touch_action}
    
    Log    Scroll down com Touch Action realizado: (${start_x}, ${start_y}) -> (${end_x}, ${end_y})