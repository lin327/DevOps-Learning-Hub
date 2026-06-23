![](https://github.com/vegasbrianc/prometheus/workflows/prometheus%20test/badge.svg)

# 目录

- 简介
  - [概述](#a-prometheus--grafana-docker-compose-stack)
  - [前置要求](#pre-requisites)
  - [安装与配置](#installation--configuration)
    - [添加数据源和仪表盘](#add-datasources-and-dashboards)
    - [旧方式安装仪表盘](#install-dashboards-the-old-way)
    - [告警](#alerting)
    - [测试告警](#test-alerts)
    - [添加额外数据源](#add-additional-datasources)
  - [使用 Traefik 部署 Prometheus 技术栈](#deploy-prometheus-stack-with-traefik)
  - [安全注意事项](#security-considerations)
    - [生产环境安全](#production-security)
  - [故障排除](#troubleshooting)
    - [Mac 用户](#mac-users)
  - [使用本仓库的有趣项目](#interesting-projects-that-use-this-repo)

# Prometheus & Grafana docker-compose 技术栈

以下是使用 Play-With-Docker (PWD) 快速启动 [Prometheus](http://prometheus.io/) 技术栈的方法，包含 Prometheus、Grafana 和 Node scraper，用于监控 Docker 基础设施。下方的"在 PWD 中尝试"按钮可让你一键部署整个 Prometheus 技术栈，快速测试是否满足需求。

[![在 PWD 中尝试](https://github.com/play-with-docker/stacks/raw/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/vegasbrianc/prometheus/master/pwd-stack.yml)

# 前置要求

在开始安装 Prometheus 技术栈之前，请确保在 Docker 主机上安装了最新版本的 Docker 和 [Docker Swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/)。使用 Docker for Mac 或 Docker for Windows 时，Docker Swarm 会自动安装。

# 安装与配置

将项目克隆到本地 Docker 主机。

如果需要更改监控目标或修改配置，请编辑 [/prometheus/prometheus.yml](prometheus/prometheus.yml) 文件。`targets` 部分定义了 Prometheus 应监控的内容。文件中定义的名称实际上来源于 docker-compose 文件中的服务名称。如需更改服务名称，可在 `docker-compose.yml` 文件中添加 `container_name` 参数。

配置完成后，启动服务。在 /prometheus 项目目录下运行以下命令：

    $ HOSTNAME=$(hostname) docker stack deploy -c docker-stack.yml prom

`docker stack deploy` 命令会将整个 Grafana 和 Prometheus 技术栈自动部署到 Docker Swarm。默认情况下，cAdvisor 和 node-exporter 设置为全局部署，会自动传播到 Swarm 中的每个 Docker 主机。

Grafana 仪表盘可通过以下地址访问：`http://<主机 IP 地址>:3000`，例如 http://192.168.10.1:3000

    用户名 - admin
    密码 - foobar（密码存储在 `/grafana/config.monitoring` 环境变量文件中）

检查新创建的技术栈状态：

    $ docker stack ps prom

查看运行中的服务：

    $ docker service ls

查看特定服务的日志

    $ docker service logs prom_<服务名称>

## 添加数据源和仪表盘

Grafana 5.0.0 版本引入了 provisioning 概念，允许我们自动化添加数据源和仪表盘。`/grafana/provisioning/` 目录包含 `datasources` 和 `dashboards` 子目录，其中的 YAML 文件用于指定应安装的数据源或仪表盘。

如需自动化安装额外仪表盘，只需将仪表盘 `JSON` 文件复制到 `/grafana/provisioning/dashboards`，下次启动 Grafana 时会自动配置。

## 旧方式安装仪表盘

我创建了一个仪表盘模板，可在 [Grafana Docker Dashboard](https://grafana.net/dashboards/179) 获取。只需在 Grafana 菜单 -> Dashboards -> Import 中选择导入，提供仪表盘 ID [#179](https://grafana.net/dashboards/179)。

此仪表盘旨在帮助你入门监控。如有任何修改建议，请告知我，以便更新 Grafana 网站。

仪表盘模板如下：

![Grafana 仪表盘](https://raw.githubusercontent.com/vegasbrianc/prometheus/master/images/Dashboard.png)

Grafana 仪表盘 - `dashboards/Grafana_Dashboard.json`
告警仪表盘

## 告警

技术栈已添加告警功能，集成 Slack。已添加 2 个告警规则并进行管理。

告警规则          - `prometheus/alert.rules`
Slack 配置        - `alertmanager/config.yml`

Slack 配置需要创建自定义集成：
* 在浏览器中打开 Slack 团队 `https://<your-slack-team>.slack.com/apps`
* 点击右上角的 "build"
* 选择 "Send Messages" 下的 "Incoming Web Hooks" 链接
* 点击 "incoming webhook integration" 链接
* 选择频道
* 点击 "Add Incoming WebHooks integration"
* 将 Webhook URL 复制到 `alertmanager/config.yml` 的 URL 部分
* 填写 Slack 用户名和频道

查看 Prometheus 告警 `http://<主机 IP 地址>:9090/alerts`
查看 Alert Manager `http://<主机 IP 地址>:9093`

### 测试告警

快速测试告警的方法是停止一个服务。停止 node_exporter 容器后，你应该很快在 Slack 中看到告警到达。同时检查 Alert Manager 和 Prometheus Alerts 中的告警，了解它们在系统中的流转方式。

高负载测试告警 - `docker run --rm -it busybox sh -c "while true; do :; done"`

运行几分钟后，你会看到负载告警出现。然后 Ctrl+C 停止此容器。

### 添加额外数据源

现在需要创建 Prometheus 数据源，将 Grafana 连接到 Prometheus：
* 点击左上角的 `Grafana` 菜单（看起来像火球）
* 点击 `Data Sources`
* 点击绿色按钮 `Add Data Source`

**确保数据源名称 `Prometheus` 使用大写 `P`**

<img src="https://raw.githubusercontent.com/vegasbrianc/prometheus/master/images/Add_Data_Source.png" width="400" heighth="400">

# 安全注意事项

本项目旨在快速启动 Docker 和 Prometheus。项目中未实现安全措施，用户需自行实施防火墙/IpTables 和 SSL。

由于本模板用于入门，Prometheus 和告警服务暴露了端口，以便于故障排除和理解技术栈的工作原理。

## 使用 Traefik 部署 Prometheus 技术栈

要求同上。应启用 Swarm，仓库应克隆到 Docker 主机。

在 `docker-traefik-prometheus` 目录下运行：

    docker stack deploy -c docker-traefik-stack.yml traefik

验证所有服务已配置。每个服务的副本数应为 1/1
**注意：这可能需要几分钟**

    docker service ls

## Prometheus & Grafana 现在拥有主机名

* Grafana - http://grafana.localhost
* Prometheus - http://prometheus.localhost

## 检查指标

所有服务启动后，可以打开 Traefik 仪表盘。仪表盘应显示为 Grafana 和 Prometheus 配置的前端和后端。

    http://localhost:8080

查看 Traefik 现在以 Prometheus 指标格式产生的指标

    http://localhost:8080/metrics

## 登录 Grafana 并可视化指标

Grafana 是一个开源可视化工具，用于展示 Prometheus 收集的指标。接下来，打开 Grafana 查看 Traefik 仪表盘。
**注意：Firefox 无法正常使用以下 URL，请使用 Chrome**

    http://grafana.localhost

用户名：admin
密码：foobar

打开 Traefik 仪表盘并选择不同的可用后端

**注意：在 Grafana 右上角将默认 1 小时时间范围切换为 5 分钟。刷新几次后应该能看到数据开始流入**

# 生产环境安全：

以下是此技术栈的一些安全注意事项，帮助你入门：
* 移除 Prometheus 和告警服务的公开端口，仅允许访问 Grafana
* 使用 [jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy/) 或 [Traefik](https://traefik.io/) 配合 Let's Encrypt 为 Grafana 启用 SSL
* 通过反向代理 [jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy/) 或 [Traefik](https://traefik.io/) 为 cAdvisor、Prometheus 和告警服务添加用户认证，因为它们不支持用户认证
* 通过 HTTPS/SSL/TLS 终止所有服务/容器

# 故障排除

部分用户报告 Grafana 中没有数据显示。如遇此问题，请确保检查 Grafana 中查询的时间范围是否使用了当天日期和当前时间。

## Mac 用户

1. node-exporter 在 Mac 和 Linux 上的运行方式不同。Node-Exporter 不支持在 Mac 上运行，由于 Mac 和 Linux 操作系统的差异，无法从 Mac OS 收集指标。建议注释掉 `docker-compose.yml` 文件中的 node-exporter 部分，仅使用 cAdvisor。

2. 如果部署后发现 prometheus 和 alertmanager 服务因 "no suitable node" 处于待定状态，这是由于文件系统权限问题。请打开 Docker for Mac 偏好设置 -> File Sharing 菜单并添加以下内容：

![Docker for Mac 文件共享设置](https://github.com/vegasbrianc/prometheus/raw/master/images/mac-filesystem.png)

# 使用本仓库的有趣项目

多个项目使用了此 Prometheus 技术栈。以下是项目列表：

* [Docker Pulls](https://github.com/vegasbrianc/docker-pulls) - 使用 Prometheus 可视化 Docker Hub 拉取统计
* [GitHub Monitoring](https://github.com/vegasbrianc/github-monitoring) - 使用 Prometheus 监控 GitHub 项目
* [Traefik 反向代理/负载均衡器监控](https://github.com/vegasbrianc/docker-traefik-prometheus) - 使用 Prometheus 监控流行的反向代理/负载均衡器 Traefik
* [网络监控](https://github.com/maxandersen/internet-monitoring) - 使用 Prometheus 监控本地网络、互联网连接和速度
* [Dockerize Your Dev](https://github.com/RiFi2k/dockerize-your-dev) - Docker Compose 一个虚拟机，提供 LetsEncrypt / NGINX 代理自动配置、ELK 日志、Prometheus / Grafana 监控、Portainer GUI 等

*有使用本仓库的有趣项目？提交你的项目到列表中*
