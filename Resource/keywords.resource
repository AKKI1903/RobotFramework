*** Settings ***
Library    Browser

*** Variables ***
${BASE_URL}    https://www.tagesspiegel.de/
${IFRAME_SELECTOR}    css=iframe#sp_message_iframe_1038892
${ACCEPT_ALL}    >>>    //button[@title="Alle akzeptieren"]

*** Keywords ***
Open Browser And Navigate to Registration Form
    New Browser    headless=False
    New Page    ${BASE_URL}
    Set Viewport Size    1920    1080
    Sleep    2s
    Set Selector Prefix    ${IFRAME_SELECTOR} 
    Click    ${ACCEPT_ALL}
    Log    Cookies accepted    console=True
