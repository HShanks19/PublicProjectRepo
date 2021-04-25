import unittest
from flask import url_for
from flask_testing import TestCase

from application import app, db
from application.models import Users
from os import getenv

class TestBase(TestCase):
    def create_app(self):
        config_name = 'testing'
        app.config.update(SQLALCHEMY_DATABASE_URI=('mysql+pymysql://root:password@mysqldb.c7d3rtdqfpxc.eu-west-2.rds.amazonaws.com:3306/testdb'), SECRET_KEY=('rgsuhqwfo47ti8'), WTF_CSRF=False, DEBUG=True)
        return app
    
    def setUp(self):
        db.session.commit()
        db.drop_all()
        db.create_all()

        test_user1 = Users(userName="testuser1")
        test_user2 = Users(userName="testuser2")

        db.session.add(test_user1)
        db.session.add(test_user2)
        db.session.commit()
    
    def tearDown(self):
        db.session.remove()
        db.drop_all()

class TestViews(TestBase):
    def test_db_return(self):
        response = self.client.get(url_for('get_users'))
        self.assertEqual(response.status_code, 200)
