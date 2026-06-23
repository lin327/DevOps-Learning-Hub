#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_powershell_ubuntu.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_powershell_ubuntu.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-03-09 22:38:36 +0000 (Mon, 09 Mar 2020)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# Installs PowerShell on Ubuntu
#
# https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

sudo=""
[ $EUID -eq 0 ] || sudo=sudo

if type -P pwsh &>/dev/null; then
    echo "PowerShell is already installed"
    exit 0
fi

if ! grep -q '^DISTRIB_ID=Ubuntu' /etc/*release; then
    echo "Not Ubuntu"
    exit 1
fi

# Ubuntu 16.04 and 18.04 - 18.10 onwards use Snap, will require updates
# 16.04 works, 18.04 has broken package dependency
if grep -E '^DISTRIB_RELEASE=(19|18\.10)' /etc/*release; then
    # assigned in lib
    # shellcheck disable=SC2154
    $sudo snap install powershell --classic
else
    version="$(awk -F= '/^DISTRIB_RELEASE=/{print $2}' /etc/*release)"
    opts="-o DPkg::Lock::Timeout=1200"
    $sudo apt-get update $opts
    $sudo apt-get install -y $opts wget apt-transport-https
    wget -q "https://packages.microsoft.com/config/ubuntu/$version/packages-microsoft-prod.deb"
    $sudo dpkg -i packages-microsoft-prod.deb
    $sudo apt-get update $opts
    $sudo apt-get install -y $opts powershell
fi
