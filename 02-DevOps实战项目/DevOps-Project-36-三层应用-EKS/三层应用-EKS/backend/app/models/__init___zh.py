#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: __init__.py
所在目录: models
说明: 本文件为 __init__.py 的中文注释版本
"""

# ? 原始文件内容
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# Import models here
from .models import Topic, Question

# Make models available at package level
__all__ = ['db', 'Topic', 'Question']
