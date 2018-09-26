# README

## This web app require:

* Rail 5.2.1
* Ruby 2.5.0
* sqlite in development
* PostgreSQL in production

## Getting started

Clone the repo, ensure you have the **minimagick** library installed on your computer and all requirements.
The application require a file called **.env** for work in development, in this file are stored all secret key for sending email and run the Google Oauth, so you should create this file and fill it with:
```
EMAIL_CLIENT=YOUR_EMAIL_CLIENT_HERE
EMAIL_PASSWORD=YOUR_EMAIL_PASSWORD_HERE
CLIENT_SECRET=YOUR_CLIENT_SECRET_FOR_GOOGLE_OAUTH
CLIENT_ID=YOUR_CLIENT_ID_FOR_GOOGLE_OAUTH
```
For run the application you should enter ```bin/delayed_job start``` command before ```rails s```.

More in the wiki
