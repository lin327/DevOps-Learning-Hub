#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: blue.py
所在目录: test
说明: 本文件为 blue.py 的中文注释版本
"""

# ? 原始文件内容
# Ansible custom 'blue' test plugin definition.

def is_blue(string):
    ''' Return True if a valid CSS value of 'blue'. '''
    blue_values = [
        'blue',
        '#0000ff',
        '#00f',
        'rgb(0,0,255)',
        'rgb(0%,0%,100%)',
    ]
    if string in blue_values:
        return True
    else:
        return False

class TestModule(object):
    ''' Return dict of custom jinja tests. '''

    def tests(self):
        return {
            'blue': is_blue
        }
