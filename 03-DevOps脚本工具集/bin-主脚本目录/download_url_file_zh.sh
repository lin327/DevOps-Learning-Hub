#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: download_url_file.sh
#  所在目录: bin-主脚本目录
#  说明: 本文件为 download_url_file.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2024-08-28 23:01:46 +0200 (Wed, 28 Aug 2024)
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
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/../lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Downloads a given URL file using wget or curl

First tries wget if available with continuation and noclobber support

Alternatively falls back to using curl with atomic tmp and move to not cause
race conditions with files that are in frequent use

Designed to be called from adjacent download_*.sh scripts to deduplicate code
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="<url>"

help_usage "$@"

num_args 1 "$@"

download_url="$1"

timestamp "Downloading: $download_url"
echo >&2

filename="${download_url##*/}"

if type -P wget &>/dev/null; then
    wget -cO "$filename" "$download_url"
else
    tmpfile="$(mktemp)"
    curl --fail "$download_url" > "$tmpfile"
    unalias mv &>/dev/null || :
    mv -fv "$tmpfile" "$filename"
fi

timestamp "Download complete: $filename"
