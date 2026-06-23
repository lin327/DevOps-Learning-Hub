#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: db.sh
#  所在目录: scripts
#  说明: 本文件为 db.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/bin/bash
#
# Database server orchestration ad-hoc tasks.
set -e

# Configure MySQL (MariaDB) server.
ansible db -b -m dnf -a "name=mariadb-server state=present"
ansible db -b -m service -a "name=mariadb state=started enabled=yes"

# Configure firewalld.
ansible db -b -m dnf -a "name=firewalld state=present"
ansible db -b -m service -a "name=firewalld state=started enabled=yes"
ansible db -b -m firewalld -a "zone=database state=present permanent=yes"
ansible db -b -m firewalld -a "source=192.168.56.0/24 zone=database state=enabled permanent=yes"
ansible db -b -m firewalld -a "port=3306/tcp zone=database state=enabled permanent=yes"

# Configure DB user for Django.
ansible db -b -m dnf -a "name=python3-PyMySQL state=present"
ansible db -b -m mysql_user -a "name=django host=% password=12345 priv=*.*:ALL state=present"
