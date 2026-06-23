#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_minikube.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_minikube.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
# shellcheck disable=SC2230
#
#  Author: Hari Sekhon
#  Date: early 2019
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/HariSekhon
#

# Installs MiniKube on Mac - needs VirtualBox to be installed first

#set -euo pipefail
set -u

#[ -n "${DEBUG:-}" ] &&
set -x

srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$(uname -s)" = Darwin ]; then
    if ! type -P minikube &>/dev/null; then
        if ! type -P brew &>/dev/null; then
            echo "HomeBrew needs to be installed first, trying to install now"
            "$srcdir/install_homebrew.sh"
        fi
        brew update
        brew cask install minikube
        brew install docker-machine-driver-xhyve
    fi
    brew_prefix="$(brew --prefix)"
    sudo chown root:wheel "$brew_prefix"/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    sudo chmod u+s "$brew_prefix"/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    if [ -z "${NO_START:-}" ] &&
       [ -z "${QUICK:-}" ]    &&
       ! minikube status | grep -i Running; then
        minikube start
    fi
else
    echo "Only Mac is supported at this time"
    exit 1
fi
