#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_circleci.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_circleci.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#
#  Author: Hari Sekhon
#  Date: 2020-03-10 14:34:41 +0000 (Tue, 10 Mar 2020)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/HariSekhon
#

# Installs Circle CI using Homebrew on Mac or direct download to ~/bin otherwise

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/../lib/utils.sh"

section "Installing Circle CI"

if type -P circleci &>/dev/null; then
    echo "circleci already installed"
    echo
    exit 0
fi

if is_mac; then
    "$srcdir/../packages/brew_install_packages.sh" circleci
else
    curl -fLSs https://circle.ci/cli | DESTDIR=~/bin bash
fi

# unreliable that HOME is set, ensure shell evaluates to the right thing before we use it
[ -n "${HOME:-}" ] || HOME=~

export PATH="$PATH:$HOME/bin"

if ! is_CI && [ -t 1 ]; then
    circleci setup
fi
