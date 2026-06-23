#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: paste_from_clipboard_upon_changes.sh
#  所在目录: bin-主脚本目录
#  说明: 本文件为 paste_from_clipboard_upon_changes.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2025-05-29 05:50:44 +0200 (Thu, 29 May 2025)
#
#  https///github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Watches for clipboard changes and when detected pastes from the system clipboard on Linux or Mac to stdout

Redirect this to a file for diffing

Uses adjacent script paste_from_clipboard.sh
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="<polling_interval_seconds>"

help_usage "$@"

max_args 1 "$@"

polling_interval_seconds="${1:-0.5}"

if ! is_float "$polling_interval_seconds"; then
    usage "First argument for polling interval seconds must be a float"
fi

last_clipboard=""

while true; do
    log "Checking current clipboard contents"
    current_clipboard="$("$srcdir/paste_from_clipboard.sh")"
    log "Comparing current clipboard contents to previous clipboard contents"
    if [ "$current_clipboard" != "$last_clipboard" ]; then
        log "Clipboard changed, outputting:"
        echo "$current_clipboard"
    fi
    last_clipboard="$current_clipboard"
    log "Sleeping for $polling_interval_seconds seconds"
    sleep "$polling_interval_seconds"
done
