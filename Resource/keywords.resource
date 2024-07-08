*** Settings ***
Library    Browser
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}    https://www.tagesspiegel.de/

*** Keywords ***
Open Browser And Navigate to Registration Form
    New Browser    headless=False
    New Page    ${BASE_URL}
    Set Viewport Size    1920    1080
    Sleep    2s
    Select Frame    title=Iframe title
    #Switch Page    iframe    title=Iframe title
    Wait For Elements State    css=button[title="Alle akzeptieren"]    visible
    Click    css=button[title="Alle akzeptieren"]
    Log    Cookies accepted    console=
    Wait For Elements State    text=Anmelden    visible
         