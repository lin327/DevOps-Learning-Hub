# flux2-kustomize-helm-example

[![test](https://github.com/fluxcd/flux2-kustomize-helm-example/workflows/test/badge.svg)](https://github.com/flux2-kustomize-helm-example/actions)
[![e2e](https://github.com/fluxcd/flux2-kustomize-helm-example/workflows/e2e/badge.svg)](https://github.com/fluxcd/flux2-kustomize-helm-example/actions)
[![license](https://img.shields.io/github/license/fluxcd/flux2-kustomize-helm-example.svg)](https://github.com/fluxcd/flux2-kustomize-helm-example/blob/main/LICENSE)

本示例假设一个包含两个集群的场景：staging（预发布）和 production（生产）。
最终目标是利用 Flux 和 Kustomize 管理两个集群，同时最小化重复声明。

我们将配置 Flux 使用 `HelmRepository` 和 `HelmRelease` 自定义资源来安装、测试和升级演示应用。
Flux 将监控 Helm 仓库，并根据语义化版本范围自动升级 Helm release 到最新的 chart 版本。

## 前置要求

你需要 Kubernetes 1.33 或更新版本的集群。
如需快速本地测试，可使用 [Kubernetes kind](https://kind.sigs.k8s.io/docs/user/quick-start/)。
其他任何 Kubernetes 安装方式也同样适用。

按照本指南操作，你需要一个 GitHub 账号和一个可以创建仓库的
[个人访问令牌](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)
（勾选 `repo` 下的所有权限）。

在 macOS 或 Linux 上使用 Homebrew 安装 Flux CLI：

```sh
brew install fluxcd/tap/flux
```

或使用 Bash 脚本下载预编译二进制文件安装 CLI：

```sh
curl -s https://fluxcd.io/install.sh | sudo bash
```

## 仓库结构

Git 仓库包含以下顶层目录：

- **apps** 目录包含每个集群自定义配置的 Helm release
- **infrastructure** 目录包含通用基础设施工具，如 Envoy Gateway 和 cert-manager
- **clusters** 目录包含每个集群的 Flux 配置

```
├── apps
│   ├── base
│   ├── production 
│   └── staging
├── infrastructure
│   ├── configs
│   └── controllers
└── clusters
    ├── production
    └── staging
```

### 应用配置

应用配置分为：

- **apps/base/** 目录包含命名空间和 Helm release 定义
- **apps/production/** 目录包含生产环境的 Helm release values
- **apps/staging/** 目录包含预发布环境的 values

```
./apps/
├── base
│   └── podinfo
│       ├── kustomization.yaml
│       ├── namespace.yaml
│       ├── release.yaml
│       └── repository.yaml
├── production
│   ├── kustomization.yaml
│   └── podinfo-values.yaml
└── staging
    ├── kustomization.yaml
    └── podinfo-values.yaml
```

在 **apps/base/podinfo/** 目录中，有一个 Flux `HelmRelease`，包含两个集群的通用 values：

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: podinfo
  namespace: podinfo
spec:
  interval: 50m
  releaseName: podinfo
  chart:
    spec:
      chart: podinfo
      sourceRef:
        kind: HelmRepository
        name: podinfo
        namespace: flux-system
  values:
    httpRoute:
      enabled: true
      parentRefs:
        - name: envoy
          namespace: envoy-gateway-system
          sectionName: http
      hostnames:
        - podinfo.local
      rules:
        - matches:
            - path:
                type: PathPrefix
                value: /
```

在 **apps/staging/** 目录中，有一个 Kustomize patch，包含预发布环境的特定 values：

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: podinfo
spec:
  chart:
    spec:
      version: ">=1.0.0-alpha"
  test:
    enable: true
  values:
    httpRoute:
      hostnames:
        - podinfo.staging
```

注意 `version: ">=1.0.0-alpha"` 配置 Flux 自动升级 `HelmRelease` 到包含 alpha、beta 和预发布版本的最新 chart 版本。

在 **apps/production/** 目录中，有一个 Kustomize patch，包含生产环境的特定 values：

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: podinfo
  namespace: podinfo
spec:
  chart:
    spec:
      version: ">=1.0.0"
  values:
    httpRoute:
      hostnames:
        - podinfo.production
```

注意 `version: ">=1.0.0"` 配置 Flux 自动升级 `HelmRelease` 到最新的稳定 chart 版本（alpha、beta 和预发布版本将被忽略）。

### 基础设施

基础设施分为：

- **infrastructure/controllers/** 目录包含 Kubernetes 控制器的命名空间和 Helm release 定义
- **infrastructure/configs/** 目录包含 Kubernetes 自定义资源，如证书签发器和网络策略

```
./infrastructure/
├── configs
│   ├── cluster-issuers.yaml
│   ├── gateway.yaml
│   └── kustomization.yaml
└── controllers
    ├── cert-manager.yaml
    ├── envoy-gateway.yaml
    └── kustomization.yaml
```

在 **infrastructure/controllers/** 目录中，有如下 Flux 定义：

```yaml
apiVersion: source.toolkit.fluxcd.io/v1
kind: OCIRepository
metadata:
  name: cert-manager
  namespace: cert-manager
spec:
  interval: 24h
  url: oci://quay.io/jetstack/charts/cert-manager
  layerSelector:
    mediaType: "application/vnd.cncf.helm.chart.content.v1.tar+gzip"
    operation: copy
  ref:
    semver: "1.x"
---
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: cert-manager
  namespace: cert-manager
spec:
  interval: 12h
  chartRef:
    kind: OCIRepository
    name: cert-manager
  values:
    crds:
      enabled: true
      keep: false
    config:
      enableGatewayAPI: true
```

注意在 `OCIRepository` 中配置 Flux 每 24 小时检查新的 chart 版本。如果发现匹配 `semver: 1.x` 约束的更新版本，Flux 将相应升级 release。

在 **infrastructure/configs/** 目录中有 Kubernetes 自定义资源，如 Let's Encrypt 签发器：

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    # 将邮箱地址替换为你自己的联系邮箱
    email: fluxcdbot@users.noreply.github.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt
    solvers:
      - http01:
          gatewayHTTPRoute:
            parentRefs:
              - name: envoy
                namespace: envoy-gateway-system
                kind: Gateway
```

在 **clusters/production/infrastructure.yaml** 中，我们将 Let's Encrypt 服务器值替换为生产 API：

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: infra-configs
  namespace: flux-system
spec:
  # ...省略
  dependsOn:
    - name: infra-controllers
  patches:
    - patch: |
        - op: replace
          path: /spec/acme/server
          value: https://acme-v02.api.letsencrypt.org/directory
      target:
        kind: ClusterIssuer
        name: letsencrypt
```

注意通过 `dependsOn` 告诉 Flux 先安装或升级控制器，然后再安装配置。这确保 Kubernetes CRD 在集群上注册后，Flux 才应用任何自定义资源。

### 集群配置

集群配置位于 **clusters/** 目录下的各自子目录中，包含：

- **artifacts.yaml** 包含一个 `ArtifactGenerator`，将单体仓库拆分为基础设施和应用制品
- **infrastructure.yaml** 包含 Flux `Kustomization` 定义，用于协调基础设施控制器和配置
- **apps.yaml** 包含 Flux `Kustomization` 定义，用于协调特定集群的应用 Kustomize overlay

```
./clusters/
├── production
│   ├── apps.yaml
│   ├── artifacts.yaml
│   └── infrastructure.yaml
└── staging
    ├── apps.yaml
    ├── artifacts.yaml
    └── infrastructure.yaml
```

在 **clusters/staging/** 目录中有 Flux Kustomization 定义，例如：

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: apps
  namespace: flux-system
spec:
  dependsOn:
    - name: infra-configs
  interval: 1h
  retryInterval: 2m
  timeout: 5m
  sourceRef:
    kind: ExternalArtifact
    name: apps
  path: ./staging
  prune: true
  wait: true
```

通过 `path: ./staging` 配置 Flux 同步应用的 staging Kustomize overlay，通过 `dependsOn` 告诉 Flux 等待基础设施配置安装完成后再应用应用配置。

注意 `ExternalArtifact` 源由 `ArtifactGenerator` 从 **apps/base** 和 **apps/staging** 目录的内容生成。`ArtifactGenerator` 允许我们将单体仓库拆分为更小的制品，可以独立同步。对 **apps/** 目录之外文件的更改不会触发应用 Kustomization 的协调。

## 使用 Flux CLI 引导

在你的个人 GitHub 账号上 Fork 此仓库，并导出 GitHub 访问令牌、用户名和仓库名：

```sh
export GITHUB_TOKEN=<your-token>
export GITHUB_USER=<your-username>
export GITHUB_REPO=<repository-name>
```

验证 staging 集群满足前置要求：

```sh
flux check --pre
```

将 kubectl 上下文设置为 staging 集群并引导 Flux：

```sh
flux bootstrap github \
    --components-extra=source-watcher \
    --context=staging \
    --owner=${GITHUB_USER} \
    --repository=${GITHUB_REPO} \
    --branch=main \
    --personal \
    --path=clusters/staging
```

引导命令将 Flux 组件的清单提交到 `clusters/staging/flux-system` 目录，并在 GitHub 上创建一个只读访问权限的部署密钥，以便集群内拉取更改。

观察 Helm release 在 staging 上的安装：

```console
$ watch flux get helmreleases --all-namespaces

NAMESPACE            NAME                REVISION SUSPENDED READY MESSAGE 
cert-manager         cert-manager        1.19.1   False     True  Helm install succeeded
envoy-gateway-system envoy-gateway       1.8.0    False     True  Helm install succeeded
podinfo              podinfo             6.11.2   False     True  Helm install succeeded
```

验证演示应用可通过 Envoy Gateway 访问：

```console
$ kubectl -n envoy-gateway-system port-forward \
    $(kubectl -n envoy-gateway-system get svc -l gateway.envoyproxy.io/owning-gateway-name=envoy -o name) 8080:80 &

$ curl -H "Host: podinfo.staging" http://localhost:8080
{
  "hostname": "podinfo-59489db7b5-lmwpn",
  "version": "6.11.2"
}
```

在 production 上引导 Flux，设置上下文和路径为 production 集群：

```sh
flux bootstrap github \
    --components-extra=source-watcher \
    --context=production \
    --owner=${GITHUB_USER} \
    --repository=${GITHUB_REPO} \
    --branch=main \
    --personal \
    --path=clusters/production
```

观察 production 协调：

```console
$ flux get kustomizations --watch

NAME                    REVISION                    READY   MESSAGE
flux-system             main@sha1:a7be7dff          True    Applied revision: main@sha1:a7be7dff
infra-controllers       latest@sha256:c0ac3648      True    Applied revision: latest@sha256:c0ac3648
infra-configs           latest@sha256:c0ac3648      True    Applied revision: latest@sha256:c0ac3648
apps                    latest@sha256:26785ee4      True    Applied revision: latest@sha256:26785ee4
```

## 使用 Flux Operator 引导

[Flux Operator](https://github.com/controlplaneio-fluxcd/flux-operator) 提供了 Flux CLI 引导流程的替代方案。它通过基于声明式 API [FluxInstance](https://fluxoperator.dev/docs/crd/fluxinstance/) 全自动化 Flux 控制器的安装、配置和升级，消除了跨集群管理 Flux 的运维负担。

使用 Homebrew 安装 Flux Operator CLI：

```sh
brew install controlplaneio/tap/flux-operator
```

在 staging 集群上安装 Flux Operator 并引导 Flux：

```sh
flux-operator install \
    --kube-context=staging \
    --instance-components-extra=source-watcher \
    --instance-sync-url=https://github.com/${GITHUB_USER}/${GITHUB_REPO} \
    --instance-sync-ref=refs/heads/main \
    --instance-sync-path=clusters/staging \
    --instance-sync-creds=git:${GITHUB_TOKEN}
```

该命令部署 Flux Operator 并创建一个 `FluxInstance` 资源，管理 Flux 控制器的生命周期并从指定的 GitHub 仓库路径同步清单。也可以通过 `flux-operator install -f fluxinstance.yaml` 提供 `FluxInstance` 清单文件。

> [!TIP]
> 在生产环境中，Flux Operator 可以通过 Helm、Terraform/OpenTofu 或直接从 OperatorHub 安装。
> 更多详情请参阅 [Flux Operator 文档](https://fluxoperator.dev/docs/guides/install/)。

列出集群上 Flux 管理的所有资源：

```console
$ flux-operator -n flux-system tree ks flux-system
Kustomization/flux-system/flux-system
├── Kustomization/flux-system/apps
│   ├── Namespace/podinfo
│   ├── HelmRelease/podinfo/podinfo
│   │   ├── ConfigMap/podinfo/podinfo-redis
│   │   ├── Service/podinfo/podinfo-redis
│   │   ├── Service/podinfo/podinfo
│   │   ├── Deployment/podinfo/podinfo
│   │   ├── Deployment/podinfo/podinfo-redis
│   │   └── HTTPRoute/podinfo/podinfo
│   └── HelmRepository/podinfo/podinfo
├── Kustomization/flux-system/infra-configs
│   ├── ClusterIssuer/letsencrypt
│   ├── GatewayClass/envoy
│   └── Gateway/envoy-gateway-system/envoy
├── Kustomization/flux-system/infra-controllers
│   ├── Namespace/cert-manager
│   ├── Namespace/envoy-gateway-system
│   ├── HelmRelease/cert-manager/cert-manager
│   ├── HelmRelease/envoy-gateway-system/envoy-gateway
│   ├── OCIRepository/cert-manager/cert-manager
│   └── OCIRepository/envoy-gateway-system/gateway-helm
└── ArtifactGenerator/flux-system/flux-system
```

使用 Flux Operator 引导 Flux 有以下优势：

- 该 operator 不需要 Git 仓库的写入权限，支持 [GitHub Apps](https://fluxoperator.dev/docs/instance/sync/#sync-from-a-git-repository-using-github-app-auth) 和其他 OIDC 提供商。
- 生产集群可配置为从 [Git tags](https://fluxoperator.dev/docs/instance/customization/#cluster-sync-semver-range) 同步状态，而不是从 main 分支，实现从 staging 到 production 的安全变更推进。
- Flux 控制器及其 CRD 的升级完全自动化（可通过 `FluxInstance` [distribution](https://fluxoperator.dev/docs/crd/fluxinstance/#distribution-version) 字段自定义）。
- `FluxInstance` API 允许配置多租户锁定、网络策略、持久化存储、分片和 Flux 控制器的垂直扩展。
- 该 operator 允许在 [GitLess 模式](https://fluxoperator.dev/gitless-gitops/) 下引导 Flux，集群状态以 OCI 制品形式存储在容器镜像仓库中。
- 该 operator 通过 [ResourceSet](https://fluxoperator.dev/docs/resourcesets/introduction/) API 扩展 Flux 的自助服务能力，旨在降低 GitOps 工作流的复杂性。

要将现有 Flux 安装迁移到 Flux Operator，请参阅[引导迁移指南](https://fluxoperator.dev/docs/guides/migration/)。

## 测试

对 Kubernetes 清单或仓库结构的任何更改都应在合并到 main 分支并在集群上同步之前，在 CI 中进行验证。

本仓库包含以下 GitHub CI 工作流：

* [test](./.github/workflows/test.yaml) 工作流使用 [kubeconform](https://github.com/yannh/kubeconform) 验证 Kubernetes 清单和 Kustomize overlay
* [e2e](./.github/workflows/e2e.yaml) 工作流在 CI 中启动 Kubernetes 集群，在 Kubernetes Kind 中运行 Flux 测试 staging 设置
