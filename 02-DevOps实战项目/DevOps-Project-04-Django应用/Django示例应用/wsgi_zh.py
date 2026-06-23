#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: wsgi.py
所在目录: Django示例应用
说明: 本文件为 wsgi.py 的中文注释版本
"""

# ? 原始文件内容
"""
WSGI config for hello_world_django_app project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hello_world_django_app.settings')

application = get_wsgi_application()
