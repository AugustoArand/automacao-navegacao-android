*** Settings ***
Library    AppiumLibrary

*** Variables ***
${REMOTE_URL}           http://localhost:4723/wd/hub
${AUTOMATION_NAME}      UIAutomator2
${PLATFORM_NAME}        Android
${PLATFORM_VERSION}     16
${DEVICE_NAME}          Google Pixel 7 Pro


*** Keywords ***
Open App
    [Documentation]    Abre a aplicação Android usando Appium
    Open Application    
    ...    remote_url=${REMOTE_URL}
    ...    automationName=${AUTOMATION_NAME}
    ...    platformName=${PLATFORM_NAME}
    ...    disableIdLocatorAutocompletion=${True}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    deviceName=${DEVICE_NAME}

Open Device
    [Documentation]    Abre o dispositivo Android usando Appium
    Open Application
    ...    remote_url=http://localhost:4723/wd/hub
    ...    platformName=Android
    ...    platformVersion=15
    ...    deviceName=S23 FE de Augusto
    ...    automationName=UiAutomator2
    ...    newCommandTimeout=3600
    ...    connectHardwareKeyboard=${True}
    ...    disableIdLocatorAutocompletion=${True}
 