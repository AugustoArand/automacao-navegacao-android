*** Settings ***
Resource    ../base.resource
Test Setup    Open App
Test Teardown    Close All Applications

*** Test Cases ***
Cenario: Acessar o Menu de apps
    Swipe Up On Screen
    Wait Until Element Is Visible    ${menuApp.appList}    10s
