#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: dockerhub_list_tags_by_last_updated.sh
#  所在目录: docker-Docker
#  说明: 本文件为 dockerhub_list_tags_by_last_updated.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#  args: centos
#
#  Author: Hari Sekhon
#  Date: 2020-09-14 15:43:04 +0100 (Mon, 14 Sep 2020)
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
Lists tags for a given DockerHub image using the DockerHub API, sorted by last updated timestamp descending (newest at the top)

Example:

    ${0##*/} centos

    ${0##*/} ubuntu

    ${0##*/} harisekhon/hbase
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="repo/image [<curl_options>]"

help_usage "$@"

min_args 1 "$@"

repo_image="$1"
shift || :

if ! [[ "$repo_image" =~ / ]]; then
    repo_image="library/$repo_image"
fi

get_tags(){
    local url_path="$1"
    local output
    shift || :
    output="$("$srcdir/dockerhub_api.sh" "$url_path" "$@")"
    jq -r '.results | sort_by(.last_updated) | reverse | .[] | [.name, .last_updated] | @tsv' <<< "$output"
    next="$(jq -r .next <<< "$output")"
    if [ -n "$next" ] && [ "$next" != null ]; then
        get_tags "$next"
    fi
}

get_tags "/repositories/$repo_image/tags" "$@" |
sort -k2r |
column -t
