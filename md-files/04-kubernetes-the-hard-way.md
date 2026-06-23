# Kubernetes The Hard Way（从零开始学 Kubernetes）

本教程将带你以最"硬核"的方式搭建 Kubernetes 集群。本指南不适合寻找一键自动化部署工具的人。Kubernetes The Hard Way 专为学习优化，意味着你需要走更长的路，以确保你理解引导 Kubernetes 集群所需的每一个任务。

> 本教程的成果不应被视为生产就绪版本，社区支持也可能有限，但这不应阻止你学习！

## 版权声明

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />本作品采用 <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议</a> 进行许可。

## 目标受众

本教程的目标受众是希望理解 Kubernetes 基础原理以及核心组件如何协同工作的人。

## 集群详情

Kubernetes The Hard Way 将引导你搭建一个基本的 Kubernetes 集群，所有控制平面组件运行在单个节点上，外加两个工作节点，足以学习核心概念。

组件版本：

* [kubernetes](https://github.com/kubernetes/kubernetes) v1.32.x
* [containerd](https://github.com/containerd/containerd) v2.1.x
* [cni](https://github.com/containernetworking/cni) v1.6.x
* [etcd](https://github.com/etcd-io/etcd) v3.6.x

## 实验步骤

本教程需要四（4）台 ARM64 或 AMD64 架构的虚拟机或物理机，连接在同一网络。

* [前置准备](docs/01-prerequisites.md)
* [设置跳板机](docs/02-jumpbox.md)
* [配置计算资源](docs/03-compute-resources.md)
* [配置 CA 并生成 TLS 证书](docs/04-certificate-authority.md)
* [生成 Kubernetes 认证配置文件](docs/05-kubernetes-configuration-files.md)
* [生成数据加密配置和密钥](docs/06-data-encryption-keys.md)
* [引导 etcd 集群](docs/07-bootstrapping-etcd.md)
* [引导 Kubernetes 控制平面](docs/08-bootstrapping-kubernetes-controllers.md)
* [引导 Kubernetes 工作节点](docs/09-bootstrapping-kubernetes-workers.md)
* [配置 kubectl 远程访问](docs/10-configuring-kubectl.md)
* [配置 Pod 网络路由](docs/11-pod-network-routes.md)
* [冒烟测试](docs/12-smoke-test.md)
* [清理](docs/13-cleanup.md)
