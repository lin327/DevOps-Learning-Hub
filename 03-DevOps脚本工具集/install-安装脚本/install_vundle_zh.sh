#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_vundle.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_vundle.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
# shellcheck disable=SC2230
#
#  Author: Hari Sekhon
#  Date: 2020-01-03 12:14:36 +0000 (Fri, 03 Jan 2020)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/HariSekhon
#

# Installs Vim plugin manager Vundle to $HOME/.vim/bundle/Vundle.vim

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

if ! type -P vim &>/dev/null; then
    echo "Vim not installed, aborting..."
    exit 1
fi

target=~/.vim/bundle/Vundle.vim

mkdir -pv "${target%/*}"

if ! [ -e "$target" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git "$target"
fi

date "+%F %T  Installing Vim Vundle plugins..."
# this tends to mess up the terminal and requires a reset afterwards
vim --not-a-term +PluginInstall +qall >/dev/null
date "+%F %T  Finished installing Vim Vundle plugins"
