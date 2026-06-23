# Elastic 技术栈 (ELK) - Docker 部署

[![Elastic Stack version](https://img.shields.io/badge/Elastic%20Stack-9.4.2-00bfb3?style=flat&logo=elastic-stack)](https://www.elastic.co/blog/category/releases)
[![Build Status](https://github.com/deviantony/docker-elk/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/deviantony/docker-elk/actions/workflows/ci.yml?query=branch%3Amain)

使用 Docker 和 Docker Compose 运行最新版本的 [Elastic 技术栈][elk-stack]。

它使你能够利用 Elasticsearch 的搜索/聚合能力和 Kibana 的可视化能力来分析任何数据集。

基于 Elastic 的[官方 Docker 镜像][elastic-docker]：

* [Elasticsearch](https://github.com/elastic/elasticsearch/tree/main/distribution/docker)
* [Logstash](https://github.com/elastic/logstash/tree/main/docker)
* [Kibana](https://github.com/elastic/kibana/tree/main/src/dev/build/tasks/os_packages/docker_generator)

其他可用的技术栈变体：

* [`tls`](https://github.com/deviantony/docker-elk/tree/tls)：在 Elasticsearch、Kibana（可选）和 Fleet 中启用 TLS 加密

> [!IMPORTANT]
> 默认启用 [Platinum][subscriptions] 功能，[试用][license-mngmt]期为 **30 天**。试用期结束后，你将无缝保留对 Open Basic 许可证中所有免费功能的访问权限，无需手动干预，也不会丢失任何数据。参阅[如何禁用付费功能](#如何禁用付费功能)部分来取消此行为。

---

## 快速开始

```sh
docker compose up setup
```

```sh
docker compose up
```

---

## 设计理念

docker-elk 的主要目标是让 Elastic 技术栈尽可能容易上手。它**不是生产就绪部署的蓝图**，而是一个促进调整和探索的_模板_。

作者相信良好的文档胜过精心设计的自动化。项目的默认配置刻意保持最小化和无偏见。初始设置不依赖任何外部依赖，使用尽可能少的脚本来启动运行。

---

## 目录

1. [要求](#要求)
   * [主机设置](#主机设置)
   * [Docker Desktop](#docker-desktop)
     * [Windows](#windows)
     * [macOS](#macos)
1. [使用方法](#使用方法)
   * [启动技术栈](#启动技术栈)
   * [初始设置](#初始设置)
     * [设置用户认证](#设置用户认证)
     * [注入数据](#注入数据)
   * [清理](#清理)
   * [版本选择](#版本选择)
1. [配置](#配置)
   * [如何配置 Elasticsearch](#如何配置-elasticsearch)
   * [如何配置 Kibana](#如何配置-kibana)
   * [如何配置 Logstash](#如何配置-logstash)
   * [如何禁用付费功能](#如何禁用付费功能)
   * [如何扩展 Elasticsearch 集群](#如何扩展-elasticsearch-集群)
   * [如何重新执行设置](#如何重新执行设置)
   * [如何通过编程方式重置密码](#如何通过编程方式重置密码)
1. [可扩展性](#可扩展性)
   * [如何添加插件](#如何添加插件)
   * [如何启用提供的扩展](#如何启用提供的扩展)
1. [JVM 调优](#jvm-调优)
   * [如何指定服务使用的内存量](#如何指定服务使用的内存量)
   * [如何启用远程 JMX 连接](#如何启用远程-jmx-连接)
1. [进阶](#进阶)
   * [插件和集成](#插件和集成)

## 要求

### 主机设置

* [Docker Engine][docker-install] 版本 **18.06.0** 或更新
* [Docker Compose][compose-install] 版本 **2.0.0** 或更新
* 1.5 GB 内存

> [!NOTE]
> 特别是在 Linux 上，确保你的用户有与 Docker 守护进程交互的[所需权限][linux-postinstall]。

默认情况下，技术栈暴露以下端口：

* 5044：Logstash Beats 输入
* 50000：Logstash TCP 输入
* 9600：Logstash 监控 API
* 9200：Elasticsearch HTTP
* 9300：Elasticsearch TCP 传输
* 5601：Kibana

> [!WARNING]
> Elasticsearch 的[引导检查][bootstrap-checks]被故意禁用，以便于在开发环境中设置 Elastic 技术栈。对于生产环境，建议用户按照 Elasticsearch 文档中的说明设置主机：[重要系统配置][es-sys-config]。

### Docker Desktop

#### Windows

如果使用 _Docker Desktop for Windows_ 的传统 Hyper-V 模式，确保为 `C:` 驱动器启用[文件共享][desktop-filesharing]。

#### macOS

_Docker Desktop for Mac_ 的默认配置仅允许从 `/Users/`、`/Volume/`、`/private/`、`/tmp` 和 `/var/folders` 挂载文件。确保仓库克隆到这些位置之一，或按照[文档][desktop-filesharing]说明添加更多位置。

## 使用方法

> [!WARNING]
> 每次切换分支或更新已有技术栈的[版本](#版本选择)时，必须使用 `docker compose build` 重新构建技术栈镜像。

### 启动技术栈

将此仓库克隆到运行技术栈的 Docker 主机：

```sh
git clone https://github.com/deviantony/docker-elk.git
```

然后执行以下命令初始化 docker-elk 所需的 Elasticsearch 用户和组：

```sh
docker compose up setup
```

可选（但强烈推荐），使用以下命令为 Kibana 生成加密密钥，并将其输出复制到 Kibana 配置文件（`kibana/config/kibana.yml`）：

```sh
docker compose up kibana-genkeys
```

如果一切顺利且设置无错误完成，启动其他技术栈组件：

```sh
docker compose up
```

> [!NOTE]
> 也可以通过在上述命令后添加 `-d` 标志在后台（分离模式）运行所有服务。

等待约一分钟让 Kibana 初始化，然后在浏览器中打开 <http://localhost:5601> 访问 Kibana Web UI，使用以下（默认）凭据登录：

* 用户名：*elastic*
* 密码：*changeme*

> [!NOTE]
> 首次启动时，`elastic`、`logstash_internal` 和 `kibana_system` Elasticsearch 用户使用 [`.env`](.env) 文件中定义的密码值初始化（默认为 _"changeme"_）。第一个是[内置超级用户][builtin-users]，后两个分别用于 Kibana 和 Logstash 与 Elasticsearch 的通信。此任务仅在技术栈_首次_启动时执行。要在初始化_后_更改用户密码，请参阅下一节的说明。

### 初始设置

#### 设置用户认证

> [!NOTE]
> 参阅 [Elasticsearch 安全设置][es-security] 禁用认证。

> [!WARNING]
> 从 Elastic v8.0.0 开始，不再可能使用引导的特权 `elastic` 用户运行 Kibana。

默认为所有用户设置的 _"changeme"_ 密码是**不安全的**。为提高安全性，我们将所有用户的密码重置为随机密钥。

1. 重置默认用户密码

    以下命令重置 `elastic`、`logstash_internal` 和 `kibana_system` 用户的密码。请记下它们。

    ```sh
    docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user elastic
    ```

    ```sh
    docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user logstash_internal
    ```

    ```sh
    docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user kibana_system
    ```

    如有需要（例如要通过 Beats 和其他组件[收集监控信息][ls-monitoring]），可随时对其他[内置用户][builtin-users]重复此操作。

1. 在配置文件中替换用户名和密码

    将 `.env` 文件中 `elastic` 用户的密码替换为上一步生成的密码。其值不被任何核心组件使用，但[扩展](#如何启用提供的扩展)使用它连接 Elasticsearch。

    > [!NOTE]
    > 如果不打算使用提供的任何[扩展](#如何启用提供的扩展)，或更喜欢创建自己的角色和用户来认证这些服务，可以在技术栈初始化后安全地从 `.env` 文件中删除 `ELASTIC_PASSWORD` 条目。

    将 `.env` 文件中 `logstash_internal` 用户的密码替换为上一步生成的密码。其值在 Logstash 管道文件（`logstash/pipeline/logstash.conf`）中引用。

    将 `.env` 文件中 `kibana_system` 用户的密码替换为上一步生成的密码。其值在 Kibana 配置文件（`kibana/config/kibana.yml`）中引用。

    有关这些配置文件的更多信息，请参阅下方的[配置](#配置)部分。

1. 重启 Logstash 和 Kibana 以使用新密码重新连接 Elasticsearch

    ```sh
    docker compose up -d logstash kibana
    ```

> [!NOTE]
> 在[保护 Elastic 技术栈][sec-cluster]中了解更多关于 Elastic 技术栈安全性的信息。

#### 注入数据

在浏览器中打开 <http://localhost:5601> 启动 Kibana Web UI，使用以下凭据登录：

* 用户名：*elastic*
* 密码：*<你生成的 elastic 密码>*

技术栈完全配置好后，可以开始注入一些日志条目。

附带的 Logstash 配置允许你通过 TCP 端口 50000 发送数据。例如，可以使用以下命令之一（取决于安装的 `nc` 版本）将日志文件 `/path/to/logfile.log` 的内容通过 Logstash 注入 Elasticsearch：

```sh
# 执行 `nc -h` 确定你的 `nc` 版本

cat /path/to/logfile.log | nc -q0 localhost 50000          # BSD
cat /path/to/logfile.log | nc -c localhost 50000           # GNU
cat /path/to/logfile.log | nc --send-only localhost 50000  # nmap
```

也可以加载 Kibana 安装提供的示例数据。

### 清理

Elasticsearch 数据默认持久化在卷中。

要完全关闭技术栈并删除所有持久化数据，使用以下 Docker Compose 命令：

```sh
docker compose --profile=setup down -v
```

### 版本选择

此仓库与 Elastic 技术栈最新版本保持一致。`main` 分支跟踪当前主版本（9.x）。

要使用不同版本的核心 Elastic 组件，只需更改 [`.env`](.env) 文件中的版本号。如果升级现有技术栈，记得使用 `docker compose build` 命令重新构建所有容器镜像。

> [!IMPORTANT]
> 在执行技术栈升级之前，始终注意每个组件的[官方升级说明][upgrade]。

旧版主版本也在单独的分支上受支持：

* [`release-8.x`](https://github.com/deviantony/docker-elk/tree/release-8.x)：8.x 系列
* [`release-7.x`](https://github.com/deviantony/docker-elk/tree/release-7.x)：7.x 系列（已停止维护）
* [`release-6.x`](https://github.com/deviantony/docker-elk/tree/release-6.x)：6.x 系列（已停止维护）
* [`release-5.x`](https://github.com/deviantony/docker-elk/tree/release-5.x)：5.x 系列（已停止维护）

## 配置

> [!IMPORTANT]
> 配置不会动态重新加载，任何配置更改后需要重启相应组件。

### 如何配置 Elasticsearch

Elasticsearch 配置存储在 [`elasticsearch/config/elasticsearch.yml`][config-es] 中。

也可以通过在 Compose 文件中设置环境变量来指定要覆盖的选项：

```yml
elasticsearch:

  environment:
    network.host: _non_loopback_
    cluster.name: my-cluster
```

更多详情请参阅：[在 Docker 中安装 Elasticsearch][es-docker]。

### 如何配置 Kibana

Kibana 默认配置存储在 [`kibana/config/kibana.yml`][config-kbn] 中。

也可以通过在 Compose 文件中设置环境变量来指定要覆盖的选项：

```yml
kibana:

  environment:
    SERVER_NAME: kibana.example.org
```

更多详情请参阅：[在 Docker 中安装 Kibana][kbn-docker]。

### 如何配置 Logstash

Logstash 配置存储在 [`logstash/config/logstash.yml`][config-ls] 中。

也可以通过在 Compose 文件中设置环境变量来指定要覆盖的选项：

```yml
logstash:

  environment:
    LOG_LEVEL: debug
```

更多详情请参阅：[配置 Docker 中的 Logstash][ls-docker]。

### 如何禁用付费功能

你可以在试用期到期前取消正在进行的试用——从而恢复到基本许可证——通过 Kibana 的[许可证管理][license-mngmt]面板，或使用 Elasticsearch 的 `start_basic` [许可证 API][license-apis]。请注意，如果许可证未在试用期到期前切换为 `basic` 或升级，第二种方法是恢复 Kibana 访问权限的唯一方式。

通过将 Elasticsearch 的 `xpack.license.self_generated.type` 设置值从 `trial` 更改为 `basic`（参阅[许可证设置][license-settings]）来更改许可证类型，**仅在初始设置之前有效**。试用开始后，从 `trial` 到 `basic` 的功能丢失_必须_使用第一段描述的两种方法之一来确认。

### 如何扩展 Elasticsearch 集群

按照 Wiki 中的说明操作：[扩展 Elasticsearch](https://github.com/deviantony/docker-elk/wiki/Elasticsearch-cluster)

### 如何重新执行设置

要重新运行设置容器并重新初始化 `.env` 文件中定义了密码的所有用户，只需再次 "up" `setup` Compose 服务：

```console
$ docker compose up setup
 ⠿ Container docker-elk-elasticsearch-1  Running
 ⠿ Container docker-elk-setup-1          Created
Attaching to docker-elk-setup-1
...
docker-elk-setup-1  | [+] User 'monitoring_internal'
docker-elk-setup-1  |    ⠿ User does not exist, creating
docker-elk-setup-1  | [+] User 'beats_system'
docker-elk-setup-1  |    ⠿ User exists, setting password
docker-elk-setup-1 exited with code 0
```

### 如何通过编程方式重置密码

如果因任何原因无法使用 Kibana 更改用户（包括[内置用户][builtin-users]）密码，可以使用 Elasticsearch API 实现相同效果。

以下示例重置 `elastic` 用户的密码（注意 URL 中的 "/user/elastic"）：

```sh
curl -XPOST -D- 'http://localhost:9200/_security/user/elastic/_password' \
    -H 'Content-Type: application/json' \
    -u elastic:<your current elastic password> \
    -d '{"password" : "<your new password>"}'
```

## 可扩展性

### 如何添加插件

要为任何 ELK 组件添加插件，你需要：

1. 在相应的 `Dockerfile` 中添加 `RUN` 语句（例如 `RUN logstash-plugin install logstash-filter-json`）
1. 在服务配置中添加相关的插件代码配置（例如 Logstash 输入/输出）
1. 使用 `docker compose build` 命令重新构建镜像

### 如何启用提供的扩展

[`extensions`](extensions) 目录中提供了一些扩展。这些扩展提供不属于标准 Elastic 技术栈的功能，但可用于通过额外集成来丰富它。

这些扩展的文档在各个子目录中按扩展提供。其中一些需要对默认 ELK 配置进行手动更改。

## JVM 调优

### 如何指定服务使用的内存量

Elasticsearch 和 Logstash 的启动脚本可以从环境变量的值追加额外的 JVM 选项，允许用户调整每个组件可使用的内存量：

| 服务          | 环境变量      |
|---------------|---------------|
| Elasticsearch | ES_JAVA_OPTS  |
| Logstash      | LS_JAVA_OPTS  |

为了适应内存有限的环境（Docker Desktop for Mac 默认只有 2 GB），`docker-compose.yml` 文件中堆大小分配默认上限为 Elasticsearch 512 MB，Logstash 256 MB。如需覆盖默认 JVM 配置，编辑 `docker-compose.yml` 文件中对应的环境变量。

例如，增加 Logstash 的最大 JVM 堆大小：

```yml
logstash:

  environment:
    LS_JAVA_OPTS: -Xms1g -Xmx1g
```

未设置这些选项时：

* Elasticsearch 启动时的 JVM 堆大小[自动确定][es-heap]。
* Logstash 启动时使用固定的 1 GB JVM 堆大小。

### 如何启用远程 JMX 连接

与 Java 堆内存（见上文）一样，可以指定 JVM 选项来启用 JMX 并在 Docker 主机上映射 JMX 端口。

使用以下内容更新 `{ES,LS}_JAVA_OPTS` 环境变量（JMX 服务映射到端口 18080，可自行更改）。不要忘记将 `-Djava.rmi.server.hostname` 选项更新为 Docker 主机的 IP 地址（替换 **DOCKER_HOST_IP**）：

```yml
logstash:

  environment:
    LS_JAVA_OPTS: -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.port=18080 -Dcom.sun.management.jmxremote.rmi.port=18080 -Djava.rmi.server.hostname=DOCKER_HOST_IP -Dcom.sun.management.jmxremote.local.only=false
```

## 进阶

### 插件和集成

参阅以下 Wiki 页面：

* [外部应用](https://github.com/deviantony/docker-elk/wiki/External-applications)
* [流行集成](https://github.com/deviantony/docker-elk/wiki/Popular-integrations)
