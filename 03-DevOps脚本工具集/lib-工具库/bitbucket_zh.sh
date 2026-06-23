#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: bitbucket.sh
#  所在目录: lib-工具库
#  说明: 本文件为 bitbucket.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-08-16 09:52:29 +0100 (Sun, 16 Aug 2020)
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
lib_srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$lib_srcdir/utils.sh"

get_bitbucket_user(){
    # reuse bitbucket_user between function calls for efficiency to save additional queries to the BitBucket API
    if [ -z "${bitbucket_user:-}" ]; then
        log "Attempting to infer username"
        if [ -n "${BITBUCKET_USER:-}" ]; then
            bitbucket_user="$BITBUCKET_USER"
            log "Using username '$bitbucket_user' from \$BITBUCKET_USER"
        else
            log "Querying BitBucket API for currently authenticated username"
            bitbucket_user="$("$lib_srcdir/../bitbucket/bitbucket_api.sh" /user | jq -r .username)"
            log "BitBucket API returned username '$bitbucket_user'"
        fi
    fi
    echo "$bitbucket_user"
}
