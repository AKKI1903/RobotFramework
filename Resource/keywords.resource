*** Settings ***
Library    Browser 
Library    imap_actions.py
Library    RPA.Email.ImapSmtp    
Library    RPA.RobotLogListener
Library    String
Library    Collections
Variables  variables.py 

*** Variables ***
${EMAIL}                   ankush180393@gmail.com
${EMAIL_PASSWORD}          mjih nqjs lhph ldus     #asep mnxt fkzf jcce  # Use the generated app password here mjih nqjs lhph ldus   
${IMAP_SERVER}             imap.gmail.com
${IMAP_PORT}               993
${REGISTRATION_EMAIL_SUBJECT}    Registration Confirmation
${REGISTRATION_LINK_REGEX}    https://mein\.tagesspiegel\.de/verify-token/[^\s"']+
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
    ${email_body}=    imap_actions.Get Latest Email    ${unread}
    [Return]    ${email_body}


Extract Registration Link
    [Arguments]    ${email_body}    
    ${matches}=    Get Regexp Matches    ${email_body}    ${REGISTRATION_LINK_REGEX}
    ${registration_link}=    Set Variable    ${matches}[0]
    [Return]    ${registration_link}

Access Registration Link from Mail
    [Arguments]    ${link}
    New Browser    headless=False
    New Page    ${link}
    Set Viewport Size    1920    1080
    Sleep    1s
    Set Selector Prefix    ${IFRAME_SELECTOR_PASSWORD}
    Click    ${ACCEPT_ALL}
    Sleep    1
    Set Selector Prefix    ${None}
    Wait For Elements State    ${FOCUS_PASSWORD_PAGE}    visible
    Sleep    2s

    Fill Text    ${CREATE_PASSWORD}    Abc
    Fill Text    ${CONFIRM_PASSWORD}    XYZ
    Click    ${SAVE}
    Sleep    120s


Check Email Connection
    Check Connection

Print First Email Subject
    imap_actions.Print First Email Subject