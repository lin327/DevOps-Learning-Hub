#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_rpmforge.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_rpmforge.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2012-06-25 15:20:39 +0100
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

if grep -qi "NAME=Fedora" /etc/*release; then
    echo "Detected Fedora, skipping rpmforge install..."
    exit 0
fi

if rpm -q rpmforge-release; then
    echo "rpmforge-release rpm is already installed, skipping..."
    #exit 0
fi

if yum repolist | grep -qi '\<rpmforge\>'; then
    echo "rpmforge yum repo already detected in yum repolist, skipping..."
    #exit 0
fi

[ $EUID -eq 0 ] && sudo="" || sudo=""

rpm -qi wget || yum install -y wget

major_release="$(grep -ho '[[:digit:]]' /etc/*release | head -n1)"
arch="$(uname -m)"

rpm_url="$(
    curl -sS http://repoforge.org/use/ |
    grep -Eo "http://repository.it4i.cz/mirrors/repoforge/redhat/el$major_release/en/$arch/.*\\.$arch\\.rpm"
)"

wget -t 5 --retry-connrefused -O /tmp/repoforge.rpm "$rpm_url"
$sudo rpm -ivh /tmp/repoforge.rpm
rm -f -- /tmp/repoforge.rpm
