#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: run.py
所在目录: backend
说明: 本文件为 run.py 的中文注释版本
"""

# ? 原始文件内容
from app import create_app

app = create_app()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
