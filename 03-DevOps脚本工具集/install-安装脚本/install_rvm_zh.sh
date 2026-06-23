#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_rvm.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_rvm.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/bin/sh
#
#  Author: Hari Sekhon
#  Date: 2019-10-04 16:36:18 +0100 (Fri, 04 Oct 2019)
#        (circa 2016 originally)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/HariSekhon
#

# Installs Ruby RVM

set -eu
[ -n "${DEBUG:-}" ] && set -x

if type apk >/dev/null 2>&1; then
    apk --no-cache add bash curl procps
elif type apt-get >/dev/null 2>&1; then
    opts="-o DPkg::Lock::Timeout=1200"
    apt-get update $opts
    apt-get install -y $opts curl procps
elif type yum >/dev/null 2>&1; then
    echo "rhel based systems aleady have curl"
fi

exec bash <<EOF

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -sSL https://get.rvm.io | bash -s stable --rails

EOF
