#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: multi.sh
#  所在目录: scripts
#  说明: 本文件为 multi.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/bin/bash
#
# Multi-server tests for the orchestration example.
set -e

# Other commands from the book.
ansible multi -b -m dnf -a "name=chrony state=present"
ansible multi -m stat -a "path=/etc/environment"
ansible multi -m copy -a "src=/etc/hosts dest=/tmp/hosts"
ansible multi -b -m fetch -a "src=/etc/hosts dest=/tmp"
ansible multi -m file -a "dest=/tmp/test mode=644 state=directory"
ansible multi -m file -a "dest=/tmp/test state=absent"
ansible multi -b -B 3600 -P 0 -a "dnf -y update"
