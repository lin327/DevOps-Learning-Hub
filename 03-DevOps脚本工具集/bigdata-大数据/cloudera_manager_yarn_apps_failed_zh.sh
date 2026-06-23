#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: cloudera_manager_yarn_apps_failed.sh
#  所在目录: bigdata-大数据
#  说明: 本文件为 cloudera_manager_yarn_apps_failed.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-01-23 16:13:06 +0000 (Thu, 23 Jan 2020)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# Script to fetch failed Yarn Apps / jobs via Cloudera Manager API
#
# Dumps the raw JSON for further processing, see cloudera_manager_yarn_apps.sh for the format

# Tested on Cloudera Enterprise 5.10

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$srcdir/cloudera_manager_yarn_apps.sh" |
jq -r '.applications[] | select(.state | test("RUNNING|SUCCEEDED|FINISHED|ACCEPTED") | not)'
