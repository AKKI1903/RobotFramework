*** Settings ***
Library    Browser

*** Variables ***
${BASE_URL}    https://www.tagesspiegel.de/
${IFRAME_SELECTOR}    css=iframe#sp_message_iframe_1038892    
${ACCEPT_ALL}    >>>    //button[@title="Alle akzeptieren"]    
${FOCUS_MAIN_PAGE}    xpath=//*[@id="page-container"]
${ANMELDEN_SELECTOR}    //*[@id="sso-menu"]/div/a/span/span     
${REGISTRATION_IFRAME}    css=iframe#modal-iframe
${REGISTRATION_BUTTON}    >>>    //button[@data-nav-item="register"]
${EMAIL_INPUT}    >>>    //*[@id="forms/formRegistration_email"]
${FIRST_NAME}    >>>    //*[@id="forms/formRegistration_forename"]    
${LAST_NAME}    >>>    //*[@id="forms/formRegistration_surname"]     
${REGISTRATION}    >>>    //button[@value="Jetzt registrieren"]     


*** Keywords ***
Open Browser And Navigate to Registration Form
    New Browser    headless=False
    Set Browser Timeout    10s
    New Page    ${BASE_URL}
    Set Viewport Size    1920    1080
    Set Selector Prefix    ${IFRAME_SELECTOR} 
    Click    ${ACCEPT_ALL}
    Log    Cookies accepted    console=True
    Set Selector Prefix    ${FOCUS_MAIN_PAGE}
    Wait For Elements State    ${ANMELDEN_SELECTOR}    visible
    Click    ${ANMELDEN_SELECTOR}

Fill Registration Form and Submit
    Set Selector Prefix    ${REGISTRATION_IFRAME}
    Wait For Elements State    ${REGISTRATION_BUTTON}    visible
    Sleep    2s
    Click    ${REGISTRATION_BUTTON}
    Wait For Elements State    ${EMAIL_INPUT}    visible
    Fill Text    ${EMAIL_INPUT}    test@example.com
    Fill Text    ${FIRST_NAME}    Abc
    Fill Text    ${LAST_NAME}    XYZ
    Click    ${REGISTRATION}
    Sleep    2s
    Take Screenshot
    Sleep    5s
    