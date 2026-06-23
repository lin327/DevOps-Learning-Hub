#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: tests.py
所在目录: Flask容器CI
说明: 本文件为 tests.py 的中文注释版本
"""

# ? 原始文件内容
#!/usr/bin/env python
# coding=utf-8

import unittest

from app import main


class TestCase(unittest.TestCase):

    def setUp(self):
        self.app = main.app.test_client()

    def test_main_page(self):
        response = self.app.get('/', follow_redirects=True)
        self.assertEqual(response.status_code, 200)

    def test_users_page(self):
        response = self.app.get('/users', follow_redirects=True)
        self.assertEqual(response.status_code, 200)


if __name__ == '__main__':
    unittest.main()
