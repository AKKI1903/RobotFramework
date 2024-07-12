# Tagesspiegel User Registration Automation

This project automates the user registration process for the Tagesspiegel website using Robot Framework and Python.

## Project Overview

This automation suite performs the following tasks:
1. Navigates to the Tagesspiegel website
2. Fills out the registration form
3. Retrieves the registration confirmation email
4. Extracts the registration link from the email
5. Completes the registration process
6. Verifies successful user login

## Prerequisites

- Python 3.x
- Robot Framework
- Browser Library for Robot Framework
- RPA.Email.ImapSmtp Library
- Access to a Gmail account for email verification

## Project Structure

- `keywords.resource`: Contains Robot Framework keywords and variables
- `imap_actions.py`: Python module for email-related actions
- `user_registration.robot`: Main Robot Framework test suite
- `variables.py`: Contains variables used across the project

## Setup

1. Clone this repository
2. Install the required dependencies:
`pip install robotframework robotframework-browser rpa-framework`
3. Set up your email credentials in `variables.py` or use environment variables for sensitive information

## Running the Tests

To run the automation suite:

`robot -d results tests/user_registration.robot`

You can also set the environment before running your tests. Depening on your selection. 
`production`
`staging`
`test1`
By default it is set to Production.

`TEST_ENVIRONMENT=staging robot -d results tests/user_registration.robot`

