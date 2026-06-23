#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: check_sbt_build.sh
#  所在目录: checks-检查脚本
#  说明: 本文件为 check_sbt_build.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
# shellcheck disable=SC2230
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-06-30 14:46:43 +0100 (Thu, 30 Jun 2016)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -eu #o pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=lib/utils.sh
. "$srcdir/lib/utils.sh"

build_files="$(find "${1:-.}" -name build.sbt)"

if [ -z "$build_files" ]; then
    # shellcheck disable=SC2317
    return 0 &>/dev/null ||
    exit 0
fi

section "S B T"

start_time="$(start_timer)"

if type -P sbt &>/dev/null; then
    type -P sbt
    sbt --version
    echo
    grep -v '/target/' <<< "$build_files" |
    sort |
    while read -r build_sbt; do
        pushd "$(dirname "$build_sbt")" >/dev/null
        echo "Validating $build_sbt"
        echo q | sbt reload || exit $?
        popd >/dev/null
        echo
    done
else
    echo "SBT not found in \$PATH, skipping maven pom checks"
fi

time_taken "$start_time"
section2 "SBT checks passed"
echo
