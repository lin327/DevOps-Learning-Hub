#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: url_extract_redirects.sh
#  所在目录: bin-主脚本目录
#  说明: 本文件为 url_extract_redirects.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2025-01-11 01:56:41 +0700 (Sat, 11 Jan 2025)
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
Extracts the URLs from a given string arg, file or standard input,
queries each one and outputs the redirected urls instead to stdout

Uses adjacent script:

    urlextract.sh
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="[<url_or_file_with_url>]"

help_usage "$@"

max_args 1 "$@"

"$srcdir/urlextract.sh" "$@" |
while read -r url; do
    log "Resolving final redirect for URL: $url" >&2
    # curl follow redirects and print only the final URL
    # the -I header flag is a bit risky in case the server doesn't give redirects in the headers
    # but we don't want to waste time downloading large ISO file URLs such as in Packer templates
    # when trying to find outdated redirected URLs to replace
    result="$(command curl -sSLfI -o /dev/null -w '%{http_code} %{url_effective}' "$url" || :)"
    http_code="$(awk '{print $1}' <<< "$result")"
    final_url=$(cut -d' ' -f2- <<< "$result")
    if [ "$http_code" == 200 ]; then
        echo "$final_url"
    else
        warn "failed to resolve URL, outputting original only: $url"
        echo "$url"
    fi
done
