##############################################################################
# Dependencies you will need to rendering requests, jinja templates, and Oauth
# https://copilot.microsoft.com/shares/vQLqNAfQEewvPxt7fUXph
##############################################################################
from flask import Flask, request, redirect, url_for, session, render_template, session
from flask_socketio import SocketIO, emit # Used to connect the lab SSH back to the Python Flask App
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user
from requests_oauthlib import OAuth2Session
from oauthlib.oauth2 import TokenExpiredError
import uuid
import logging
from systemd.journal import JournalHandler
from dotenv import load_dotenv
import os, threading, re, time, requests
from datetime import datetime, timezone
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import select
from sqlalchemy.dialects.mysql import CHAR # adding imports that specifically bring in the defined char
from sqlalchemy.dialects.postgresql import UUID # adding uuid()
from sqlalchemy import Column, String, func # different syntax to explicitly call for the uuid() func
import urllib3
import socket

##############################################################################
# Setting up some built in application logging to the internal journalctl
# Initialize logging object to send logs to the journal
##############################################################################
logger = logging.getLogger('your-project')
journald_handler = JournalHandler()
journald_handler.setFormatter(logging.Formatter('[%(levelname)s] %(message)s'))
logger.addHandler(journald_handler)
logger.setLevel(logging.INFO)

##############################################################################
# Instantiate the .env file 
load_dotenv()
##############################################################################

##############################################################################
# Instantiate application
##############################################################################
app = Flask(__name__)
socketio = SocketIO(app) # might move to helper function, called multiple times to instantiate multiple times
##############################################################################
#Initialize SQL Alchemy DB object for SQL
##############################################################################
CONNECTION_STRING = 'mysql+pymysql://' + DBUSER + ':' + DBPASS + '@' + DBURL + '/' + DATABASENAME 
app.config['SQLALCHEMY_DATABASE_URI'] = CONNECTION_STRING
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Comment(db.Model):
    __tablename__ = 'comment'
    ID = db.Column(db.Integer, primary_key=True)
    PosterName = db.Column(CHAR(32),nullable=False)
    Title = db.Column(CHAR(32),nullable=False)
    Content = db.column(CHAR(500),nullable=False)

'''These are additional examples to show different contexts
class Users(db.Model):
    __tablename__ = 'Users'  # trying to explicitly set the table name to 'Users' so there is no lowercase
    email = db.Column(db.String, primary_key=True)
    # id = db.Column(db.String(36), unique=True, nullable=False)
    id = Column(CHAR(36), unique=True, server_default=func.uuid()) # new id declaration
    last_login = db.Column(db.DateTime, nullable=False)
    admin_status = db.Column(db.Integer, nullable=False)
'''

'''These are additional examples to show different contexts
class Labs(db.Model):
    __tablename__ = 'Labs'  # trying to explicitly set the table name so there is no lowercase
    # id = db.Column(db.String(36), unique=True, nullable=False)
    id = Column(CHAR(36), server_default=func.uuid(), unique=True) # new id declaration
    lab_number = db.Column(db.Integer, primary_key=True)
    launch_id = db.Column(CHAR(36),nullable=False,default=0)
    lab_complete = db.Column(db.Integer, nullable=False, default=0)
    grade = db.Column(db.Float, nullable=True)
    last_attempt = db.Column(db.DateTime, nullable=False)
    email = db.Column(db.String(255), primary_key=True)
'''
##############################################################################
# Create Helper functions for DB access
# https://copilot.microsoft.com/shares/MiPTDp2uEjHMXBJyHTJBF
##############################################################################
# This will check if the user already exists in the DB else create
# Working example
def check_or_create_user(email):
    existing = db.session.execute(select(Users).filter_by(email=email)).scalar_one_or_none()
    if existing:
        return None  # or handle as needed
    new_user = Users(email=email, last_login=datetime.now(timezone.utc))
    db.session.add(new_user)
    db.session.commit()
    return new_user

def select_filtered(model, **filters):
    stmt = select(model).filter_by(**filters)
    return db.session.scalars(stmt).all()

def create_lab_entry(email,lab_number,launch_id):
    new_lab = Labs(
        lab_number=lab_number,
        launch_id=launch_id,
        email=email,
        last_attempt=datetime.now(timezone.utc),
        lab_complete=0
    )
    db.session.add(new_lab)
    db.session.commit()
    return new_lab

##############################################################################
# Flask-Login setup
##############################################################################
app.secret_key = 'APP_SECRET' # Change to point to the vault instance EDIT: Added Manually, add back as 'APP_SECRET'
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

##############################################################################
# OAuth configuration example -- your REDIRECTION_URI will be different
##############################################################################
authorization_base_url = 'https://accounts.google.com/o/oauth2/auth'
token_url = 'https://accounts.google.com/o/oauth2/token'
redirect_uri = 'https://system22h200.itm.iit.edu/callback'
scope = ['profile', 'email']

##############################################################################
# Read secrets from .env file
# Make a decision to have .env variables be ALL CAPS or lower case
##############################################################################
# Extract username and password
client_id = os.getenv('client_id')
client_secret = os.getenv('client_secret')
APP_SECRET = os.getenv('APP_SECRET')
DBUSER = os.getenv('DBUSER')
DBPASS = os.getenv('DBPASS')
DBURL = os.getenv('DBURL')
DATABASENAME = os.getenv('DATABASENAME')


##########################
class User(UserMixin):
    pass

@login_manager.user_loader
def load_user(user_id): #This function does not get called, what is it for?
    user = User()
    user.id = user_id
    return user

@app.route('/')
def index():
    if 'google_token' in session:
        google = OAuth2Session(client_id, token=session['google_token'])
        try:
            response = google.get('https://www.googleapis.com/oauth2/v3/userinfo').json()
            if 'email' in response:
                #global user_info #Why is this global?
                user_info = response
                user = User()
                user.id = user_info["email"]
                # Store email in Session Variable so other functions can access it
                session['email'] = user_info["email"] #Isn't this redundant with user.id?
                session['uid'] = user_info["sub"]
                ######################################################################################
                '''
                When you call login_user(user):
                
                Stores the user’s ID in the session
                Flask‑Login calls user.get_id() (provided by UserMixin or your own implementation) and 
                saves that ID in Flask’s session cookie.
                This is how Flask‑Login remembers who you are between requests.

                Marks the user as authenticated
                For the rest of the request (and future requests in the same session), current_user 
                will be set to your user object.
                current_user.is_authenticated will return True.

                Triggers login signals
                Sends the user_logged_in signal, which you can hook into for logging, auditing, or
                other side effects.
                Optionally remembers the user
                If you pass remember=True, Flask‑Login will set a long‑lived “remember me” cookie so 
                the user stays logged in even after closing the browser.
                '''                
                login_user(user)
                # Helper function to check if user exists and if not create in DB
                user_in_application = check_or_create_user(user_info['email'])
                # Function to query all of the current lab progress per user account
                lab = select_filtered(Labs, email=user_info['email'])
                # This checks for the UID problem if you reload the index page after a packer/terraform rebuild
                # if user_in_application is None:
                # return redirect(url_for('.index')) 
                # else:
                return render_template('welcome.html', lab_results=lab, uid = user_info["sub"], email=user_info["email"])
            else:
                return render_template('index.html') #Render template instead?
        except TokenExpiredError:
            if 'refresh_token' in session['google_token']:
                # Refresh expired token
                token = google.refresh_token(
                    token_url,
                    client_id=client_id,
                    client_secret=client_secret,
                    refresh_token=session['google_token'].get('refresh_token')
                )
                session['google_token'] = token
                #return render_template('dashboard.html', lab_results=lab, uid = user_info["sub"], email=user_info["email"])
                return render_template('index.html')
            else:
                # Session expired
                return render_template('index.html')#Where is the login page?
    return render_template('index.html')

@app.route('/login')
def login():
    google = OAuth2Session(client_id, redirect_uri=redirect_uri, scope=scope)
    authorization_url, state = google.authorization_url(authorization_base_url, access_type='offline', prompt='consent')
    session['oauth_state'] = state
    return redirect(authorization_url)

@app.route('/callback')
def callback():
    google = OAuth2Session(client_id, state=session['oauth_state'], redirect_uri=redirect_uri)
    token = google.fetch_token(token_url, client_secret=client_secret, authorization_response=request.url)
    session['google_token'] = token
    return redirect(url_for('.index'))

@app.route('/logout')
@login_required
def logout():
    session.pop('google_token', None)
    return redirect(url_for('.index'))

@app.route("/welcome")
@login_required
def welcome():
    return render_template("welcome.html")
