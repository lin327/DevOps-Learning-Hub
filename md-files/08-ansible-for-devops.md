# Ansible for DevOps 示例

[![CI](https://github.com/geerlingguy/ansible-for-devops/workflows/CI/badge.svg?event=push)](https://github.com/geerlingguy/ansible-for-devops/actions?query=workflow%3ACI) [![Molecule CI](https://github.com/geerlingguy/ansible-for-devops/workflows/Molecule%20CI/badge.svg?event=push)](https://github.com/geerlingguy/ansible-for-devops/actions?query=workflow%3A%22Molecule+CI%22)

本仓库包含为 [Ansible for DevOps](https://www.ansiblefordevops.com/) 一书各章节开发的 Ansible 示例，该书由 [Jeff Geerling](https://www.jeffgeerling.com/) 编写，介绍 [Ansible](http://www.ansible.com/) 的使用。

许多示例使用 Vagrant、VirtualBox 和 Ansible 在本地工作站上启动和配置虚拟机。

并非所有 playbook 都遵循 Ansible 的最佳实践，因为它们以教学为目的展示特定的 Ansible 功能。

## 书稿

本书书稿以 CC BY-SA 许可证发布，可在单独的仓库中公开获取：[Ansible for DevOps - 书稿](https://github.com/geerlingguy/ansible-for-devops-manuscript)。

## 示例与对应章节

以下是本仓库中所有示例的概览，按章节排列：

### 第 1 章

  - 无

### 第 2 章

  - [`first-ansible-playbook`](first-ansible-playbook/)：一个非常基础的 playbook，在 CentOS 上安装 `chronyd` 并确保其运行。

### 第 3 章

  - [`orchestration`](orchestration/)：一个简单的多虚拟机 Vagrant 配置和 Ansible 清单，用于测试使用 `ansible` 临时命令进行多服务器编排。

### 第 4 章

  - [`drupal`](drupal/)：单文件 playbook，在 Linux 主机上配置 LAMP 技术栈并安装 Drupal。
  - [`includes`](includes/)：与 [`drupal`](drupal/) 示例相同的 playbook，但使用 `include` 使 playbook 更易理解。
  - [`nodejs`](nodejs/)：单文件 playbook，在 Linux 主机上配置 Node.js 应用。
  - [`solr`](solr/)：单文件 playbook，在 Linux 主机上安装 Apache Solr。

### 第 5 章

  - 无

### 第 6 章

  - [`nodejs-role`](nodejs-role/)：与 [`nodejs`](nodejs/) 示例相同的 playbook，但使用 role 将 Node.js 相关内容拆分到独立的 `nodejs` role 中。
  - [`galaxy-role-servers`](galaxy-role-servers/)：几个简短的 playbook，展示如何利用 Ansible Galaxy 社区 role 轻松运行新服务器。

### 第 7 章

  - [`test-plugin`](test-plugin/)：一个简单的测试插件，验证给定值是否代表蓝色。
  - [`collection`](collection/)：一个本地 collection 示例，演示内容 collection 的基本结构。

### 第 8 章

  - [`dynamic-inventory`](dynamic-inventory/)：两个动态清单脚本示例（一个用 PHP，一个用 Python），供 Ansible 使用。

### 第 9 章

  - [`lamp-infrastructure`](lamp-infrastructure/)：基于 LAMP 的多服务器 Web 应用基础设施，专注于高可用和性能。
  - [`elk`](elk/)：Elasticsearch-Logstash-Kibana 技术栈的双服务器示例，一台服务器集中存储和可视化日志，另一台通过 Filebeat 发送日志。
  - [`gluster`](gluster/)：使用 Gluster 构建快速网络存储的双服务器示例。

### 第 10 章

  - [`deployments`](deployments/)：将 Ruby on Rails 应用部署到运行 Passenger 和 Nginx 的环境的 playbook。
  - [`deployments-balancer`](deployments-balancer/)：在 HAProxy 负载均衡器后端的 Web 服务器上实现零停机部署的 playbook。
  - [`deployments-rolling`](deployments-rolling/)：演示 Node.js 应用滚动部署到多台服务器的 playbook。

### 第 11 章

  - [`security`](security/)：包含许多安全自动化任务的 playbook，演示 Ansible 如何帮助自动化安全加固。

### 第 12 章

  - [`jenkins`](jenkins/)：安装和配置 Jenkins 用于 CI/CD 的 playbook。

### 第 13 章

  - [`molecule`](molecule/)：用于测试和开发 Ansible playbook 的 Molecule 示例，也可用于持续集成（CI）环境。
  - [`molecule-ci.yml` GitHub Actions 工作流](.github/workflows/molecule-ci.yml)：在 CI 环境中运行 `molecule` 示例的 GitHub Actions 工作流。

### 第 14 章

  - [`https-self-signed`](https-self-signed/)：生成自签名证书的 playbook。
  - [`https-letsencrypt`](https-letsencrypt/)：演示使用 Let's Encrypt 和 Ansible 进行自动化证书管理的 playbook。
  - [`https-nginx-proxy`](https-nginx-proxy/)：演示通过 Nginx 将 HTTPS 流量代理到 HTTP 后端的 playbook。

### 第 15 章

  - [`docker`](docker/)：演示 Ansible 管理 Docker 容器镜像能力的简单 playbook。
  - [`docker-hubot`](docker-hubot/)：稍复杂的 Ansible 管理和运行 Docker 容器镜像的示例。
  - [`docker-flask`](docker-flask/)：使用 Ansible playbook 在容器内构建的示例 Flask 应用。

### 第 16 章

  - [`kubernetes`](kubernetes/)：构建三节点 Kubernetes 集群的 playbook。

## 许可证

MIT

## 赞助商

* [TinyPilot](https://tinypilotkvm.com)：开源、低成本的 KVM over IP 解决方案，用于管理服务器。

以上赞助商通过 [GitHub Sponsors](https://github.com/sponsors/geerlingguy) 支持 Jeff Geerling。你也可以赞助 Jeff 的工作，帮助他持续改进这本书和 Ansible 开源工作！

## 购买本书

[![Ansible for DevOps 封面](https://s3.amazonaws.com/titlepages.leanpub.com/ansible-for-devops/medium)](https://www.ansiblefordevops.com/)

购买 [Ansible for DevOps](https://www.ansiblefordevops.com/) 的电子书或纸质版。
