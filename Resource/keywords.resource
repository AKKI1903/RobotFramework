*** Settings ***
Library    Browser 
Library    imap_actions.py
Library    RPA.Email.ImapSmtp    
Library    RPA.RobotLogListener
Variables  variables.py

*** Variables ***
${EMAIL}                   anthony.smith.1991.01@gmail.com
${EMAIL_PASSWORD}          asep mnxt fkzf jcce  # Use the generated app password here
${IMAP_SERVER}             imap.gmail.com
${IMAP_PORT}               993
${REGISTRATION_EMAIL_SUBJECT}    Registration Confirmation
${REGISTRATION_LINK_REGEX}    (?i)https://registration-link\.example\.com/\S+
${NEW_PASSWORD}            YourNewPassword123!

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
    Set Browser Timeout    30s
    Wait For Elements State    ${REGISTRATION_BUTTON}    visible
    Click    ${REGISTRATION_BUTTON}
    Wait For Elements State    ${EMAIL_INPUT}    visible
    Fill Text    ${EMAIL_INPUT}    test@example.com
    Fill Text    ${FIRST_NAME}    Abc
    Fill Text    ${LAST_NAME}    XYZ
    Click    ${REGISTRATION}
    Sleep    5s

Create Imap Client
    [Arguments]    ${server}    ${username}    ${password}
    Create Email Handler    ${server}    ${username}    ${password}

List Emails
    [Arguments]    ${unread}
    ${emails}=    imap_actions.List Emails    ${unread}
    [Return]    ${emails}

Get Latest Email
    [Arguments]    ${unread}
    ${latest_email}=    imap_actions.Get Latest Email    ${unread}
    [Return]    ${latest_email}


Extract Registration Link
    [Arguments]    ${email_body}    ${regex}
    ${registration_link}=    imap_actions.Extract Registration Link    ${email_body}    ${regex}
    [Return]    ${registration_link}

Access Registration Link from Mail
    [Arguments]    ${link}
    New Browser    headless=False
    New Page    ${link}
    Wait For Elements State    name=createPassword    visible
    Fill Text    name=createPassword    ${NEW_PASSWORD}
    Fill Text    name=confirmPassword    ${NEW_PASSWORD}
    Click    xpath=//button[@type="submit"]

Check Email Connection
    Check Connection

Print First Email Subject
    imap_actions.Print First Email Subject