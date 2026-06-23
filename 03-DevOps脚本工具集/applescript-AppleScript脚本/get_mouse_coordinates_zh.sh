#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: get_mouse_coordinates.sh
#  所在目录: applescript-AppleScript脚本
#  说明: 本文件为 get_mouse_coordinates.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

MouseTools -location
