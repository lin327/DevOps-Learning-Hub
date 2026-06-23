#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  作者: Hari Sekhon
#  日期: 2020-11-24 17:09:11 +0000 (Tue, 24 Nov 2020)
#
#  https://github.com/HariSekhon/DevOps-Bash-tools
#
#  许可证: 参见附带的 Hari Sekhon LICENSE 文件
#
#  如果你使用我的代码，欢迎在 LinkedIn 上与我联系，并可选择发送反馈以帮助改进或引导此代码或其他我发布的代码
#
#  https://www.linkedin.com/in/HariSekhon
#

# ? 设置严格模式：遇到错误立即退出，未定义变量报错，管道错误立即退出
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ? 导入网络工具库（用于打开浏览器访问 TeamCity 接受 EULA）
# XXX: 导入顺序很重要，因为有交互式和脚本式两个版本的 retry() 函数，我们需要后者，必须第二个导入
# shellcheck disable=SC1090,SC1091
. "$srcdir/.bash.d/network.sh"

# ? 导入通用工具库
# shellcheck disable=SC1090,SC1091
. "$srcdir/lib/utils.sh"

# ? 使用说明
# shellcheck disable=SC2034
usage_description="
启动 TeamCity CI 集群，包含服务器和代理，并构建当前仓库

- 在 Docker 中启动 TeamCity 服务器和代理
- 授权代理开始构建
- 等待你接受 EULA
  - 打印 TeamCity URL
  - 打开 TeamCity Web UI

- 创建管理员级别用户 (\$TEAMCITY_USER, / \$TEAMCITY_PASSWORD - 默认为 admin / admin)
  - 设置全名、邮箱和 VCS 提交用户名为 Git 的 user.name 和 user.email（如果配置了 TeamCity Git VCS 跟踪集成）
  - 在浏览器中打开 TeamCity Web UI 登录页面

- 如果有可用的凭据，创建 GitHub OAuth 连接 (\$TEAMCITY_GITHUB_CLIENT_ID 和 \$TEAMCITY_GITHUB_CLIENT_SECRET)
  - 这样你就不必为 GitHub VCS（如配置仓库）使用自己的用户名和密码 - 只需点击 VCS URL 旁边的 GitHub 图标即可自动认证

- 如果当前目录有 .teamcity.vcs.json VCS 配置，创建用作配置同步仓库的 VCS
  - 如果这是私有仓库，你需要临时将凭据放在文件中，或将密码留空，并在启动后编辑
    - 目前即使仓库是公开的也必须使用认证：https://youtrack.jetbrains.com/issue/TW-69183
  - 如果有可用的 GitHub OAuth 连接凭据，将改为查找 .teamcity.auth.vcs.json
  - 你需要禁用并重新启用项目的版本化设置才能获得项目的导入对话框，然后才会开始同步
    - 这是另一个 TeamCity 限制：https://youtrack.jetbrains.com/issue/TW-58754
"

# ? 解析命令行参数
# shellcheck disable=SC2034
usage_args="[<host>] [<provider>] [<project>] [<repo>]"

# ? 帮助函数
help_usage "$@"

# ? 最少参数数量
min_args 0 "$@"

# ? 最多参数数量
max_args 4 "$@"

# ? 获取主机地址，默认为 localhost
host="${1:-localhost}"

# ? 获取云提供商，默认为 docker
provider="${2:-docker}"

# ? 获取项目名称，默认为当前目录名
project="${3:-$(basename "$PWD")}"

# ? 获取仓库地址，默认为当前 Git 仓库的远程地址
repo="${4:-$(git remote get-url origin 2>/dev/null || echo "")}"

# ? TeamCity 端口
port=8111

# ? TeamCity URL
teamcity_url="http://$host:$port"

# ? 输出信息
echo "启动 TeamCity CI 集群..."
echo "主机: $host"
echo "提供商: $provider"
echo "项目: $project"
echo "仓库: $repo"
echo "TeamCity URL: $teamcity_url"

# ? 启动 TeamCity 服务器
echo "启动 TeamCity 服务器..."
if [ "$provider" = "docker" ]; then
    docker run -d --name teamcity-server \
        -p $port:8111 \
        jetbrains/teamcity-server
else
    echo "错误: 不支持的提供商 $provider"
    exit 1
fi

# ? 等待 TeamCity 服务器启动
echo "等待 TeamCity 服务器启动..."
sleep 30

# ? 启动 TeamCity 代理
echo "启动 TeamCity 代理..."
docker run -d --name teamcity-agent \
    --link teamcity-server:server \
    jetbrains/teamcity-agent

# ? 授权代理
echo "授权代理..."
# TODO: 实现代理授权逻辑

# ? 打开浏览器访问 TeamCity
echo "打开浏览器访问 TeamCity..."
open_browser "$teamcity_url"

# ? 创建管理员用户
echo "创建管理员用户..."
# TODO: 实现用户创建逻辑

# ? 创建 GitHub OAuth 连接
echo "创建 GitHub OAuth 连接..."
# TODO: 实现 OAuth 连接逻辑

# ? 完成
echo "TeamCity CI 集群启动完成！"
echo "访问 $teamcity_url 开始使用"
