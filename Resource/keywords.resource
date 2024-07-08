*** Settings ***
Library    Browser

*** Variables ***
${BASE_URL}    https://www.tagesspiegel.de/

*** Keywords ***
Open Browser And Navigate to Registration Form
    New Browser    headless=False
    New Page    ${BASE_URL}