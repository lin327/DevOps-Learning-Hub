#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: config.py
所在目录: app
说明: 本文件为 config.py 的中文注释版本
"""

# ? 原始文件内容
import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'dev-secret-key')
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'postgresql://postgres:postgres@db:5432/devops_learning')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    DEBUG = bool(int(os.getenv('FLASK_DEBUG', '0')))
