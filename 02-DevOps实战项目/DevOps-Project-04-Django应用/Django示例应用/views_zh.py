#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: views.py
所在目录: Django示例应用
说明: 本文件为 views.py 的中文注释版本
"""

# ? 原始文件内容
from django.http import HttpResponse


def hello_world(request):
    return HttpResponse("<html><body>Hello World</body></html>")
