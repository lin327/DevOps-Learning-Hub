#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: main.py
所在目录: app
说明: 本文件为 main.py 的中文注释版本
"""

# ? 原始文件内容
#!/usr/bin/env python
# coding=utf-8

from flask import Flask
from flask import make_response

import json
from flask_wtf.csrf import CSRFProtect
from werkzeug.exceptions import NotFound

# OpenRefactory Warning: The 'Flask' method creates a Flask app
# without Cross-Site Request Forgery (CSRF) protection.
app = Flask(__name__)
CSRFProtect(app)

with open("./users.json", "r") as f:
    users = json.load(f)


@app.route("/", methods=['GET'])
def index():
    return pretty_json({
        "resources": {
            "users": "/users",
            "user": "/users/<username>",
        },
        "current_uri": "/"
    })


@app.route("/users", methods=['GET'])
def all_users():
    return pretty_json(users)


@app.route("/users/<username>", methods=['GET'])
def user_data(username):
    if username not in users:
        raise NotFound

    return pretty_json(users[username])


@app.route("/users/<username>/something", methods=['GET'])
def user_something(username):
    raise NotImplementedError()


def pretty_json(arg):
    response = make_response(json.dumps(arg, sort_keys=True, indent=4))
    response.headers['Content-type'] = "application/json"
    return response


def create_test_app():
    # OpenRefactory Warning: The 'Flask' method creates a Flask app
    # without Cross-Site Request Forgery (CSRF) protection.
    app = Flask(__name__)
    CSRFProtect(app)
    return app


if __name__ == "__main__":
    app.run(port=5000)
