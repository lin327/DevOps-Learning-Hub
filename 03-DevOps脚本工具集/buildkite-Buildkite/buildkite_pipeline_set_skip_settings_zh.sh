#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: buildkite_pipeline_set_skip_settings.sh
#  所在目录: buildkite-Buildkite
#  说明: 本文件为 buildkite_pipeline_set_skip_settings.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-12-17 15:07:11 +0000 (Thu, 17 Dec 2020)
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
Sets given BuildKite pipelines to skip intermediate queued builds and also cancel running builds in favour of the latest build

If not pipelines are given, iterates over all pipelines
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="[<pipeline>]"

help_usage "$@"

set_pipeline_settings(){
    local pipeline="$1"
    echo "Setting pipeline '$pipeline' to skip intermediate queued builds and cancel intermediate running builds"
    "$srcdir/buildkite_api.sh" "/organizations/{organization}/pipelines/$pipeline" -X PATCH -d '{ "skip_queued_branch_builds": true, "cancel_running_branch_builds": true }' >/dev/null
    echo
    "$srcdir/buildkite_pipeline_skip_settings.sh" "$pipeline"
}

if [ $# -gt 0 ]; then
    for pipeline in "$@"; do
        set_pipeline_settings "$pipeline"
    done
else
    for pipeline in $("$srcdir/buildkite_pipelines.sh"); do
        set_pipeline_settings "$pipeline"
    done
fi
