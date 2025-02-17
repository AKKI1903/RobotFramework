import os

# Environment selection
# Set this to 'production', 'staging', or 'test1', or use an environment variable
CURRENT_ENV = os.getenv('TEST_ENVIRONMENT', 'production')

# Environment URLs
ENV_URLS = {
    'production': 'https://www.tagesspiegel.de/',
    'staging': 'https://staging.tagesspiegel.de/',
    'test1': 'https://test1.tagesspiegel.de/'
}

# Base URL (dynamically set based on the current environment)
BASE_URL = ENV_URLS.get(CURRENT_ENV, ENV_URLS['production'])

IFRAME_SELECTOR = 'css=iframe#sp_message_iframe_1038892'        
IFRAME_SELECTOR_PASSWORD = 'css=iframe#sp_message_iframe_1117797'

FOCUS_MAIN_PAGE = 'xpath=//*[@id="page-container"]'
ANMELDEN_SELECTOR = '//*[@id="sso-menu"]/div/a/span/span'
REGISTRATION_IFRAME = 'css=iframe#modal-iframe'

ACCEPT_ALL = '>>>    //button[@title="Alle akzeptieren"]'
REGISTRATION_BUTTON = '>>>    //button[@data-nav-item="register"]'
REGISTRATION = '>>>    //button[@value="Jetzt registrieren"]'
SAVE = 'xpath=//button[@value="Speichern"]'

EMAIL_INPUT = '>>>    //*[@id="forms/formRegistration_email"]'
FIRST_NAME = '>>>    //*[@id="forms/formRegistration_forename"]'
LAST_NAME = '>>>    //*[@id="forms/formRegistration_surname"]'
CREATE_PASSWORD = '//*[@id="forms/formSetPassword_password"]'
CONFIRM_PASSWORD = 'xpath=//*[@id="forms/formSetPassword_password_confirmation"]'

FOCUS_PASSWORD_PAGE = 'xpath=//*[@action="/sso/set-password"]'

EXPECTED_URL = f'https://mein.{CURRENT_ENV}.tagesspiegel.de/' if CURRENT_ENV != 'production' else 'https://mein.tagesspiegel.de/'

MEIN_KONTO = '//*[@id="myAccount-control"]/span[2]'
MEIN_PROFIL = 'xpath=//*[@id="myAccount-panel"]/div/a[1]'
EMAIL_VALUE = 'xpath=//*[@id="tab-personal-data"]/div/section/div[1]/span[4]/span[2]'

REGISTRATION_LINK_REGEX = r"https://mein\.tagesspiegel\.de/verify-token/[^\s\"']+"
NEW_PASSWORD = "YourNewPassword123"

# Email configuration
EMAIL = "anthony.smith.1991.01@gmail.com"
EMAIL_PASSWORD = "asep mnxt fkzf jcce"  
IMAP_SERVER = "imap.gmail.com"
IMAP_PORT = 993