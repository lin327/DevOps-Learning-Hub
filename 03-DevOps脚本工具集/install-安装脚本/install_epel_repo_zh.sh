#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_epel_repo.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_epel_repo.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-02-17 11:11:52 +0000 (Sun, 17 Feb 2019)
#        2013-07-17 21:27:25 +0100 (Wed, 17 Jul 2013)
#           (found older version)
#        2012-06-25 15:20:39 +0100
#           (originally an alias in .bashrc)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

if [ "${NO_FAIL:-}" ]; then
    set +eo pipefail
fi

if grep -qi 'NAME=.*Fedora' /etc/*release; then
    echo "Detected Fedora, skipping epel install..."
    exit 0
fi

if rpm -q epel-release; then
    echo "EPEL rpm is already installed, skipping..."
    exit 0
fi

[ $EUID -eq 0 ] && sudo="" || sudo=sudo

if $sudo yum repolist | grep -qi '\<epel\>'; then
    # accounts for custom internal EPEL mirrors which should have epel in the name
    echo "EPEL yum repo already detected in yum repolist, skipping..."
    exit 0
fi

if ! $sudo yum install -y epel-release; then
    rpm -qi wget || yum install -y wget
    major_release="$(grep -ho '[[:digit:]]' /etc/*release | head -n1)"
    wget -t 5 --retry-connrefused -O /tmp/epel.rpm "https://dl.fedoraproject.org/pub/epel/epel-release-latest-$major_release.noarch.rpm"
    $sudo rpm -ivh /tmp/epel.rpm
    rm -f -- /tmp/epel.rpm
fi
