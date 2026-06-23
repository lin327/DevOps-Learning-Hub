#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: app.sh
#  所在目录: scripts
#  说明: 本文件为 app.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/bin/bash
#
# App server orchestration ad-hoc tasks.
set -e

# Configure Django on app server.
ansible app -b -m dnf -a "name=python3-pip state=present"
ansible app -b -m pip -a "executable=pip3 name=django<4 state=present"

# Check Django version.
ansible app -a "python3 -m django --version"

# Other commands from the book.
# ansible app -b -a "systemctl status chronyd"
ansible app -b -m group -a "name=admin state=present"
ansible app -b -m user -a "name=johndoe group=admin createhome=yes"
ansible app -b -m user -a "name=johndoe state=absent remove=yes"
ansible app -b -m package -a "name=git state=present"
