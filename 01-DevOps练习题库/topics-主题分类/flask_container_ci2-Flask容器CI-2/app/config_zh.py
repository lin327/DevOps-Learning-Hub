#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: config.py
所在目录: app
说明: 本文件为 config.py 的中文注释版本
"""

# ? 原始文件内容
#!/usr/bin/env python
# coding=utf-8

import os

basedir = os.path.abspath(os.path.dirname(__file__))

SECRET_KEY = 'shhh'
CSRF_ENABLED = True

SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'app.db')
