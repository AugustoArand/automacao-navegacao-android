*** Settings ***
Library    AppiumLibrary    timeout=30

# Utils
Resource    resource/utils/openApp.resource
Resource    resource/utils/swipeAction.resource
Resource    resource/utils/scrollAction.resource
Resource    resource/utils/screenshotUtils.resource
Resource    resource/utils/telaConfig.resource

# Locators
Variables    resource/locators/emulador/chromeLocator.yml
Variables    resource/locators/emulador/menuAppLocators.yml
Variables    resource/locators/emulador/configLocators.yml
Variables    resource/locators/my_device/configLocators.yml
Variables    resource/locators/gpos760/configLocators.yml
Variables    resource/locators/configAutomation/configLocators.yml
Variables    resource/locators/configAutomation/dispConectados.yml

# Pages
Resource    resource/pages/emulador/chromePage.resource
Resource    resource/pages/emulador/configPage.resource
Resource    resource/pages/my_device/configPage.resource
Resource    resource/pages/gpos760/configPage.resource
Resource    resource/pages/configAutomation/configPiloto.resource
Resource    resource/pages/configAutomation/dispConectados.resource

*** Variables ***
${PLATFORM_NAME}    Android
${DEVICE_NAME}    GPOS820
${VERSION_ANDROID}    13
${NUMERO_FIRMWARE}    V4.0.1
${VERSAO_HARDWARE}    V4.0.1
${NUMERO_SERIE}       4101012546000945
${NUMERO_LOGICO}      
${NUMERO_VERSAO}      
