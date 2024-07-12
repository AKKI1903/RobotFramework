*** Settings ***
Library    Browser 
Library    imap_actions.py
Library    String
Variables  variables.py 

*** Keywords ***
Open Browser And Navigate to Registration Form
    [Documentation]    Opens the Tagesspiegel website and navigates to the registration page.
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
    [Documentation]    Fills out the registration form with test data.
    Set Selector Prefix    ${REGISTRATION_IFRAME}
    Set Browser Timeout    30s
    Wait For Elements State    ${REGISTRATION_BUTTON}    visible
    Click    ${REGISTRATION_BUTTON}
    Wait For Elements State    ${EMAIL_INPUT}    visible
    Fill Text    ${EMAIL_INPUT}    ${EMAIL}
    Fill Text    ${FIRST_NAME}    Andrew
    Fill Text    ${LAST_NAME}    Smith
    Click    ${REGISTRATION}
    Sleep    5s

Create Imap Client
    [Arguments]    ${server}    ${username}    ${password}
    Create Email Handler    ${server}    ${username}    ${password}

Get Latest Email
    [Arguments]    ${unread}
    ${email_body}=    imap_actions.Get Latest Email    ${unread}
    [Return]    ${email_body}


Extract Registration Link
    [Documentation]    Retrieves the latest email from the test email account.
    [Arguments]    ${email_body}    
    ${matches}=    Get Regexp Matches    ${email_body}    ${REGISTRATION_LINK_REGEX}
    ${registration_link}=    Set Variable    ${matches}[0]
    [Return]    ${registration_link}

Access Registration Link from Mail
    [Documentation]    Follows the registration link and completes the process. Create and save password.
    [Arguments]    ${link}
    New Browser    headless=False
    New Page    ${link}
    Set Viewport Size    1920    1080
    Set Selector Prefix    ${IFRAME_SELECTOR_PASSWORD}
    Click    ${ACCEPT_ALL}
    Set Selector Prefix    ${None}
    Wait For Elements State    ${FOCUS_PASSWORD_PAGE}    visible
    Fill Text    ${CREATE_PASSWORD}    ${NEW_PASSWORD}
    Fill Text    ${CONFIRM_PASSWORD}    ${NEW_PASSWORD}
    Click    ${SAVE}
    Sleep    5s
    ${current_url} =    Get Url
    Should Be Equal    ${current_url}    ${EXPECTED_URL}
    Close Page

Verify User is Logged in
    [Documentation]    Verifies that the user is successfully registered and logged in.
    New Page    ${BASE_URL}
    Set Viewport Size    1920    1080
    Wait For Elements State    ${MEIN_KONTO}    visible
    Click    ${MEIN_KONTO}
    ${element} =    Wait For Elements State    id=myAccount-panel    visible
    Wait For Elements State    ${MEIN_PROFIL}    visible
    Click    ${MEIN_PROFIL}
    Wait For Elements State    css=#tab-personal-data    visible    timeout=5s 
    ${profile_email_element}=    Get Element    ${EMAIL_VALUE}
    ${profile_email}=    Get Text    ${profile_email_element}
    Should Be Equal As Strings    ${profile_email}    ${EMAIL}
