*** Settings ***
Resource    ../base.resource
Test Setup    Open App
Test Teardown    Close All Applications

*** Test Cases ***
Cenário: Acessar o Chrome
    Acessar Chrome
    