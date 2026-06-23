#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: install_homebrew.sh
#  所在目录: install-安装脚本
#  说明: 本文件为 install_homebrew.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/usr/bin/env bash
#
#  Author: Hari Sekhon
#  Date: 2019-09-12
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/HariSekhon
#

# Install Homebrew on Mac OS X or Linux (used by AWS CLI on Linux)
#
# doesn't install on CentOS 6 any more
#
# https://github.com/Homebrew/brew/issues/7583#issuecomment-640379742

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
#srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if type -P brew &>/dev/null; then
    echo "HomeBrew already installed, skipping install..."
else
    echo "==================="
    echo "Installing HomeBrew"
    echo "==================="
    echo
    # root installs to first one, user installs to the latter
    for x in /home/linuxbrew/.linuxbrew/bin ~/.linuxbrew/bin; do
        if [ -d "$x" ]; then
            export PATH="$PATH:$x"
        fi
    done
    # can't install until homebrew is installed, and these should already be present
    #"$srcdir/../packages/install_packages_if_absent.sh" bash curl git sudo
    cmds=""
    if [ "$(uname -s)" = Linux ]; then
        # if we're in debug mode enable set -x inside the HomeBrew script so we can see what inside it is causing breakage
        if [ -n "${DEBUG_HOMEBREW:-}" ]; then
            cmds="set -x"
        fi
        {
            echo "$cmds"
            # LinuxBrew has migrated to HomeBrew now
            curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh
            # but this requires newer curl and fails many CI builds - https://github.com/Homebrew/install/issues/367
            #curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
        } |
        {
        # XXX: requires 'sudo' command to install now no matter whether run as root or a regular user :-/
        if [ "$EUID" -eq 0 ]; then
            user=linuxbrew
            echo "Installing HomeBrew on Linux as user $user"
            # Alpine has adduser
            id "$user" 2>/dev/null || useradd "$user" || adduser -D "$user"
            mkdir -p -v "/home/$user"
            chown -R "$user" "/home/$user"
            # can't just pass bash, and -s shell needs to be fully qualified path
            su "$user" -s /bin/bash
        else
            echo "Installing HomeBrew on Linux as user ${USER:-whoami}"
            # newer versions of HomeBrew require bash not sh due to use of [[
            bash
        fi
        }
    else
        echo "Installing HomeBrew on Mac as user ${USER:-whoami}"
        # now deprecated and replaced with the shell version below
        #curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
        bash -c "$(echo "$cmds"; curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
fi
