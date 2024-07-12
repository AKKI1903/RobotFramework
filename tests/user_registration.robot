*** Settings ***
Resource    ../Resource/keywords.resource

*** Test Cases ***
User Registration and Verification
    Open Browser And Navigate to Registration Form
    Fill Registration Form and Submit

Get Registration Link and Complete Registration
    Create Imap Client    ${IMAP_SERVER}    ${EMAIL}    ${EMAIL_PASSWORD}
    ${email_body}=    keywords.Get Latest Email    False
    ${registration_link}=    keywords.Extract Registration Link    ${email_body}    
    Access Registration Link from Mail    ${registration_link}
    Verify User is Logged in
