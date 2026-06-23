# Hari Sekhon - DevOps Bash 工具集

1000+ DevOps Shell 脚本和高级 Bash 环境。

快速、高级系统工程、自动化、API 调用、简化 CLI 等。

被众多 [GitHub 仓库](https://github.com/search?o=desc&q=user%3Aharisekhon+type%3Arepository&type=Repositories)、数十个 [DockerHub 构建](https://hub.docker.com/r/harisekhon) 和 600+ [CI 构建](https://harisekhon.github.io/CI-CD/) 广泛使用。

---

## 概述

- 针对多种流行 DevOps 技术的脚本，详见下方[索引](#索引)
- 常用工具的高级配置：[Git](https://git-scm.com/)、[vim](https://www.vim.org/)、[screen](https://www.gnu.org/software/screen/)、[tmux](https://github.com/tmux/tmux/wiki)、[PostgreSQL psql](https://www.postgresql.org/) 等
- 大多数主流 CI 产品的 CI 配置
- API 脚本：自动处理认证、令牌等细节，只需提供 `/path/endpoint` 即可快速查询流行 API
- 高级 Bash 环境 - `.bashrc` + `.bash.d/*.sh` - 别名、函数、着色、动态 Git 和 Shell 行为增强、跨 Linux 发行版和 Mac 的自动路径配置
- 安装最佳系统工具包：
  [AWS CLI](https://aws.amazon.com/cli/)、
  [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/)、
  [GCloud SDK](https://cloud.google.com/sdk)、
  [Terraform](https://www.terraform.io/)、
  [GitHub CLI](https://github.com/cli/cli)、
  [Kubernetes kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)、
  [Helm](https://helm.sh/)、
  [Docker-Compose](https://docs.docker.com/compose/)、
  [jq](https://stedolan.github.io/jq/) 等

---

## 目录结构

| 目录 | 用途 |
|------|------|
| `install/` | 流行开源软件的安装脚本和 GitHub releases 二进制下载 |
| `configs/` | ViM、top、Screen、Tmux、MySQL、PostgreSQL 等常用技术的配置文件 |
| `setup/` | 安装脚本、软件包列表、额外配置、Mac OS X 设置等 |
| `.bash.d/` | 交互式库（别名、函数、自动补全） |
| `lib/` | 脚本和 CI 库 |

---

## 索引

脚本按以下技术/平台分类组织：

### 云平台
- **AWS** - EC2、S3、IAM、RDS、CloudFront、Route53 等
- **GCP** - GCE、GCS、BigQuery 等
- **Azure** - 虚拟机、存储等
- **Digital Ocean** - Droplet 管理

### 容器与编排
- **Docker** - 镜像管理、容器操作
- **Kubernetes** - 集群管理、资源操作
- **Helm** - Chart 管理

### 数据库
- **PostgreSQL** - 管理、备份、监控
- **MySQL** - 管理、优化
- **Redis** - 缓存管理
- **MongoDB** - 文档操作

### CI/CD
- **Jenkins** - 流水线管理
- **GitHub Actions** - 工作流自动化
- **GitLab CI** - CI/CD 配置

### 监控与日志
- **Prometheus** - 指标查询
- **Grafana** - 仪表盘管理
- **Elasticsearch** - 日志搜索

### 网络与安全
- **SSL/TLS** - 证书管理
- **DNS** - 域名解析
- **防火墙** - 规则管理

### 系统管理
- **Linux** - 系统巡检、用户管理、进程管理
- **Mac** - macOS 特定工具
- **Git** - 仓库管理、高级操作

### API 工具
- 自动处理认证的 API 查询脚本
- 支持 GitHub、GitLab、Jira、Slack 等流行 API

---

## 安装

```sh
git clone https://github.com/HariSekhon/DevOps-Bash-tools.git
cd DevOps-Bash-tools
# 查看 setup/ 目录进行初始设置
```

或使用 Docker：

```sh
docker run -it harisekhon/bash-tools
```

---

## 作者

Hari Sekhon

云与大数据工程师，英国

（前 Cloudera 员工、前 Hortonworks 顾问）

---

## 许可证

MIT
