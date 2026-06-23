#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: getawless.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 getawless.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/bin/bash
set -e

# Download latest awless binary from Github

ARCH_UNAME="$(uname -m)"
if [[ "$ARCH_UNAME" == "x86_64" ]]; then
	ARCH="amd64"
else
	ARCH="386"
fi

EXT="tar.gz"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	OS="darwin"
elif [[ "$OSTYPE" == "win32" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] ; then
	OS="windows"
	EXT="zip"
else
	echo "No awless binary available for OS '$OSTYPE'. You may want to use go to install awless with 'go get -u github.com/wallix/awless'"
  exit
fi

# broken SSL cert as documented here - https://github.com/wallix/awless/issues/278
#LATEST_VERSION=`curl -fs https://updates.awless.io | grep -oE "v[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"`
LATEST_VERSION="$(curl -s https://api.github.com/repos/wallix/awless/releases/latest | awk '/"tag_name":/ {print $2}' | sed 's/[",]//g')"

FILENAME=awless-$OS-$ARCH.$EXT

DOWNLOAD_URL="https://github.com/wallix/awless/releases/download/$LATEST_VERSION/$FILENAME"

echo "Downloading awless from $DOWNLOAD_URL"

if ! curl --fail -o "$FILENAME" -L "$DOWNLOAD_URL"; then
    exit
fi

echo ""
echo "extracting $FILENAME to ./awless"

if [[ "$OS" == "windows" ]]; then
	echo 'y' | unzip $FILENAME > /dev/null
else
	tar -xzf $FILENAME
fi

echo "removing $FILENAME"
rm -- "$FILENAME"
chmod +x ./awless

echo ""
echo "awless successfully installed to ./awless"
echo ""
echo "don't forget to add it to your path, with, for example, 'sudo mv -- awless /usr/local/bin/' "
echo ""
echo "then, for autocompletion, run:"
echo "    [bash] echo 'source <(awless completion bash)' >> ~/.bashrc"
echo "    OR"
echo "    [zsh]  echo 'source <(awless completion zsh)' >> ~/.zshrc"
