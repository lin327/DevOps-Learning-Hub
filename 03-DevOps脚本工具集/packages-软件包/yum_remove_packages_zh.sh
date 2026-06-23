#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: yum_remove_packages.sh
#  所在目录: packages-软件包
#  说明: 本文件为 yum_remove_packages.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/bin/sh
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-02-15 21:31:10 +0000 (Fri, 15 Feb 2019)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# Remove RPM packages in a forgiving way - useful for uninstalling development packages no longer needed eg. to minimize size of Docker images

set -eu
[ -n "${DEBUG:-}" ] && set -x

echo "Removing RPM Packages"

packages=""
for arg; do
    if [ -f "$arg" ]; then
        echo "adding packages from file:  $arg"
        packages="$packages $(sed 's/#.*//;/^[[:space:]]*$$/d' "$arg")"
        echo
    else
        packages="$packages $arg"
    fi
    # uniq
    packages="$(echo "$packages" | tr ' ' ' \n' | sort -u | tr '\n' ' ')"
done

if [ -z "$packages" ]; then
    exit 0
fi

SUDO=""
# shellcheck disable=SC2039
[ "${EUID:-$(id -u)}" != 0 ] && SUDO=sudo

if [ -n "${NO_FAIL:-}" ]; then
    # shellcheck disable=SC2086
    if ! $SUDO yum remove -y $packages; then
        for package in $packages; do
            if rpm -q "$package"; then
                $SUDO yum remove -y "$package" || :
            fi
        done
    fi
else
    # must install separately to check install succeeded because yum install returns 0 when some packages installed and others didn't
    for package in $packages; do
        rpm -q "$package" || $SUDO yum remove -y "$package"
    done
fi
