#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_parquet-tools.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_parquet-tools.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
# shellcheck disable=SC2230
#
#  Author: Hari Sekhon
#  Date: 2019-09-17
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/HariSekhon
#

# Installs Parquet Tools to local ~/bin
#
# add ~/bin/parquet-tools-* to $PATH (automatically detected and done via advanced bashrc in this repo)

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

PARQUET_VERSION="${PARQUET_VERSION:-1.5.0}"

zipfile="parquet-tools-$PARQUET_VERSION-bin.zip"
zipdir="${zipfile%-bin.zip}"

URL="${URL:-http://search.maven.org/remotecontent?filepath=com/twitter/parquet-tools/$PARQUET_VERSION/$zipfile}"

# unreliable that HOME is set, ensure shell evaluates to the right thing before we use it
[ -n "${HOME:-}" ] || HOME=~

bin="${BIN:-$HOME/bin}"

mkdir -pv "$bin"

cd "$bin"

if type -P parquet-cat &>/dev/null; then
    echo "parquet-tools already found in \$PATH:"
    echo
    dirname "$(which parquet-cat)"
elif [ -f "$zipdir/parquet-cat" ]; then
    echo "parquet-tools already installed in local dir ($PWD/$zipdir)"
else
    echo "parquet-tools not found in \$PATH, nor in the local ${zipfile%.zip} directory"
    echo
    echo "downloading parquet-tools to $bin"
    wget -t 100 --retry-connrefused -c -O "$zipfile" "$URL"
    echo
    echo "unzipping parquet-tools"
    unzip -- "$zipfile"
    echo
    echo "chmod'ing 0755 parquet-tools-*"
    chmod 0755 parquet-tools-*
    echo
    echo "removing zipfile"
    rm -f -- "$zipfile"
    echo
    echo "Done"
fi

echo
echo "Ensure $bin/${zipfile%.zip} is in the \$PATH (it's auto-detected in new shells if sourcing this repo's .bashrc)"
echo
