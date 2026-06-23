#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: nodejs.sh
#  所在目录: .bash.d
#  说明: 本文件为 nodejs.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
# shellcheck disable=SC2230
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: circa 2019 (forked from .bashrc)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#                                    N o d e
# ============================================================================ #

bash_tools="${bash_tools:-$(dirname "${BASH_SOURCE[0]}")/..}"

# shellcheck disable=SC1090,SC1091
#. "$bash_tools/.bash.d/os_detection.sh"

#type add_PATH &>/dev/null || . "$bash_tools/.bash.d/paths.sh"

# output from 'npm bin'
if [ -d ~/node_modules/.bin ]; then
    add_PATH ~/node_modules/.bin
fi

if [ -d "$bash_tools/node_modules/.bin" ]; then
    add_PATH "$bash_tools/node_modules/.bin"
fi

alias lsnodebin='ls -d ~/node_modules/.bin/* 2>/dev/null'
alias llnodebin='ls -ld ~/node_modules/.bin/* 2>/dev/null'
