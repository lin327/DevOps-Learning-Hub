#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_sdkman_all_sdks.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_sdkman_all_sdks.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#
#  Author: Hari Sekhon
#  Date: 2019-10-08 16:48:17 +0100 (Tue, 08 Oct 2019)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/HariSekhon
#

# Installs SDKman's most commonly used build tools e.g Java, Scala, Groovy + Maven, SBT, Gradle
#
# you may need to run ./install_sdkman.sh first

set -eo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sdks="
java
scala
groovy
maven
gradle
sbt
"

if ! type sdk &>/dev/null; then
    "$srcdir/install_sdkman.sh"
fi

if [ -s ~/.sdkman/bin/sdkman-init.sh ]; then
    # shellcheck disable=SC1090,SC1091
    . ~/.sdkman/bin/sdkman-init.sh
fi

for x in $sdks; do
    set +o pipefail
    yes | sdk install "$x"
done
