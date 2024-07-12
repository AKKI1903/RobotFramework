from RPA.Email.ImapSmtp import ImapSmtp
from typing import List, Dict


class EmailHandler:
    def __init__(self, imap_server: str, email_account: str, email_password: str):
        self.imap_client = ImapSmtp()
        self.imap_client.authorize(account=email_account, password=email_password, imap_server=imap_server)
        self.connected = True

    def get_latest_email(self, unread=True):
        criterion = 'UNSEEN' if unread else 'ALL'
        emails = self.imap_client.list_messages(criterion=criterion)
        if emails:
            latest_email = emails[-1]
            print(f"Latest email keys: {latest_email.keys()}")
            return str(latest_email)  # Return the whole email as a string for debugging
        return None

# Functions to expose as keywords

email_handler_instance = None

def create_email_handler(server: str, username: str, password: str):
    global email_handler_instance
    email_handler_instance = EmailHandler(server, username, password)

def get_latest_email(unread=True):
    global email_handler_instance
    return email_handler_instance.get_latest_email(unread=unread)

def extract_registration_link(email_body: str):
    global email_handler_instance
    return email_handler_instance.extract_registration_link(email_body)
