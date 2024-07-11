*** Settings ***
Resource    ../Resource/keywords.resource

*** Test Cases ***
User Registration and Verification
    Open Browser And Navigate to Registration Form
    Fill Registration Form and Submit

Get Registration Link and Complete Registration
    Create Imap Client    ${IMAP_SERVER}    ${EMAIL}    ${EMAIL_PASSWORD}
    # Check Email Connection
    # keywords.Print First Email Subject
    # ${emails}=    keywords.List Emails    False
    ${latest_email}=    keywords.Get Latest Email    False
    ${registration_link}=    keywords.Extract Registration Link    ${latest_email.body}    ${REGISTRATION_LINK_REGEX}
    Log    Registration Link: ${registration_link}
    Access Registration Link from Mail    ${registration_link}
    
    