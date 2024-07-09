*** Settings ***
Library    Browser

*** Variables ***
${BASE_URL}    https://www.tagesspiegel.de/
${IFRAME_SELECTOR}    css=iframe#sp_message_iframe_1038892
${ACCEPT_ALL}    >>>    //button[@title="Alle akzeptieren"]
${FOCUS_MAIN_PAGE}    xpath=//*[@id="page-container"]
${ANMELDEN_SELECTOR}    //*[@id="sso-menu"]/div/a/span/span     # //*[@id="sso-menu"]/div/a/span/span  # /html/body/div[1]/div[2]/div[2]/div/header/div/div/div/div/div/a/span/span

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
    