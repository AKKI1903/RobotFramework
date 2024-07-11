from RPA.Email.ImapSmtp import ImapSmtp
import re

class EmailHandler:
    def __init__(self, imap_server, email_account, email_password):
        self.imap_client = ImapSmtp()
        self.imap_client.authorize(account=email_account, password=email_password, imap_server=imap_server)
        self.connected = True

    def list_emails(self, unread=True):
        criterion = 'UNSEEN' if unread else 'ALL'
        emails = self.imap_client.list_messages(criterion=criterion)
        return sorted(emails, key=lambda x: x.get('date', ''), reverse=True)
    
    def get_latest_email(self, unread=True):
        emails = self.list_emails(unread=unread)
        if emails:
            latest_email = emails[-1]
            return self.imap_client.list_messages(latest_email['uid'])
        return None

    def extract_registration_link(self, email_body, regex):
        match = re.search(regex, email_body)
        if match:
            return match.group(0)
        return None

# Functions to expose as keywords

email_handler_instance = None

def create_email_handler(server, username, password):
    global email_handler_instance
    email_handler_instance = EmailHandler(server, username, password)

def list_emails(unread=True):
    global email_handler_instance
    return email_handler_instance.list_emails(unread=unread)

def get_latest_email(unread=True):
    global email_handler_instance
    return email_handler_instance.get_latest_email(unread=unread)

def extract_registration_link(email_body, regex):
    global email_handler_instance
    return email_handler_instance.extract_registration_link(email_body, regex)

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
