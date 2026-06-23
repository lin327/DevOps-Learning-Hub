#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: urlopen.sh
#  所在目录: bin-主脚本目录
#  说明: 本文件为 urlopen.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#  args: google.com
#
#  Author: Hari Sekhon
#  Date: 2020-10-06 18:59:32 +0100 (Tue, 06 Oct 2020)
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
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Opens the URL given as an arg, or first URL from standard input or a given file

Used by .vimrc to instantly open a URL on the given line in the editor

Very useful for quickly referencing inline documentation links found throughout my GitHub repos

Respects \$BROWER environment variable if set, otherwise tries to infer the mechanism on macOS or Linux
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="[<url_or_file_with_url>]"

help_usage "$@"

max_args 1 "$@"

browse(){
    # some likely catchall browsers on Linux
    local browsers=(
        xdg-open
        sensible-browser
        x-www-browser
        gnome-open
    )
    local url="$1"
    if [ -n "${BROWSER:-}" ]; then
        "$BROWSER" "$url"
    elif is_mac; then
        open "$url"
    else  # assume Linux
        for browser in "${browsers[@]}"; do
            if type -P "$browser" &>/dev/null; then
                "$browser" "$url" &
                return 0
            fi
        done
        die "ERROR: none of the following browsers were found in the \$PATH:

$(for browser in ${BROWSER:+"$BROWSER"} "${browsers[@]}"; do echo "$browser"; done)

Could not open the URL: $url
"
    fi
}
export -f browse

"$srcdir/urlextract.sh" "$@" |
# head -n1 because grep -m 1 can't be trusted and sometimes outputs more matches on subsequent lines
head -n1 |
while read -r url; do
    browse "$url"
done
