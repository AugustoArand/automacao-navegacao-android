*** Settings ***
Library    AppiumLibrary    timeout=30

# Utils
Resource    resource/utils/openApp.resource
Resource    resource/utils/swipeAction.resource
Resource    resource/utils/screenshotUtils.resource

# Locators
Variables    resource/locators/chromeLocator.yml
Variables    resource/locators/menuAppLocators.yml
Variables    resource/locators/configLocators.yml
Variables    resource/locators/my_device/configLocators.yml

# Pages
Resource    resource/pages/chromePage.resource
Resource    resource/pages/configPage.resource
Resource    resource/pages/my_device/configPage.resource

*** Variables ***
${PLATFORM_NAME}    Android
