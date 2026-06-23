#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_sdkman.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_sdkman.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
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

# Installs SDKMan

# https://sdkman.io/install

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

curl -sS "https://get.sdkman.io" | bash
