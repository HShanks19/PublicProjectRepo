from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from os import getenv

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:password@mysqldb.c7d3rtdqfpxc.eu-west-2.rds.amazonaws.com:3306/users'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'rgsuhqwfo47ti8'
db = SQLAlchemy(app)

from application import routes
