#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_kubectl_plugin_krew.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_kubectl_plugin_krew.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: Wed Jan 8 05:46:28 2025 +0700
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
Installs the latest version of the kubectl krew plugin

Also pre-installs kubectl if not already present
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args=""

help_usage "$@"

num_args 0 "$@"

export HOME="${HOME:-$(cd && pwd)}"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if ! type -P kubectl &>/dev/null; then
    timestamp "Kubectl not installed, pre-installing..."
    echo
    "$srcdir/install_kubectl.sh"
    echo
fi

tmp="$(mktemp -d)"

cd "$tmp"

os="$(get_os)"

arch="$(get_arch)"

krew="krew-${os}_${arch}"

timestamp "Downloading latest $krew.tar.gz"
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/$krew.tar.gz"
echo

timestamp "Extracting $krew.tar.gz"
echo

tar zxvf "$krew.tar.gz"

echo

timestamp "Installing krew"
"./$krew" install krew
echo

timestamp "Install Complete"
