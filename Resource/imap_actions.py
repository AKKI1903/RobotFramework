import re
from RPA.Email.ImapSmtp import ImapSmtp
from typing import List, Dict


class EmailHandler:
    def __init__(self, imap_server: str, email_account: str, email_password: str):
        self.imap_client = ImapSmtp()
        self.imap_client.authorize(account=email_account, password=email_password, imap_server=imap_server)
        self.connected = True

    def list_emails(self, unread=True):
        criterion = 'UNSEEN' if unread else 'ALL'
        return self.imap_client.list_messages(criterion=criterion)

    def get_latest_email(self, unread=True):
        criterion = 'UNSEEN' if unread else 'ALL'
        emails = self.imap_client.list_messages(criterion=criterion)
        if emails:
            latest_email = emails[-1]
            print(f"Latest email keys: {latest_email.keys()}")
            return str(latest_email)  # Return the whole email as a string for debugging
        return None

    def fetch_full_message(self, mail_id):
        actions = [{"name": "fetch", "attributes": "(BODY.PEEK[])", "uid": True}]
        response = self.imap_client._do_actions_on_messages(mail_id, actions)
        return response[0]["Message"]

    def get_email_body_from_message(self, message):
        if message.is_multipart():
            for part in message.walk():
                if part.get_content_type() == "text/plain":
                    return part.get_payload()
        else:
            return message.get_payload()

    def extract_registration_link(self, email_body: str) -> str:
        match = re.search(email_body)
        if match:
            return match.group(0)
        return None

# Functions to expose as keywords

email_handler_instance = None

def create_email_handler(server: str, username: str, password: str) -> None:
    global email_handler_instance
    email_handler_instance = EmailHandler(server, username, password)

def list_emails(unread=True):
    global email_handler_instance
    return email_handler_instance.list_emails(unread=unread)

def get_latest_email(unread=True):
    global email_handler_instance
    return email_handler_instance.get_latest_email(unread=unread)

def extract_registration_link(email_body: str) -> str:
    global email_handler_instance
    return email_handler_instance.extract_registration_link(email_body)

def check_connection():
    global email_handler_instance
    if email_handler_instance and email_handler_instance.connected:
        print("Connection to the email server was successful.")
    else:
        print("Failed to connect to the email server.")

def print_first_email_subject():
    global email_handler_instance
    emails = email_handler_instance.list_emails()
    if emails:
        latest_email = email_handler_instance.get_latest_email()
        if latest_email:
            print(f"Subject of the first email: {latest_email['subject']}")
        else:
            print("No email content found.")
    else:
        print("No unread emails found.")
