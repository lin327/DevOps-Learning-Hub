# DevOps 学习中心

一个全面的 DevOps 学习资源库，整合了 11 个精选的开源项目，为 DevOps 工程师、SRE 和云原生从业者提供一站式学习平台。

## ✨ 特性

- 📚 **2,600+ 道练习题** - 涵盖 Linux、Docker、Kubernetes、AWS 等 42 个技术主题
- 🛠️ **40 个实战项目** - 从入门到高级的 DevOps 项目
- 📜 **1,000+ 个脚本** - 覆盖云平台、CI/CD、数据库、监控等自动化场景
- 🎯 **交互式路线图** - 前端、后端、DevOps、AI 等方向的学习路径
- 🌐 **中文支持** - 所有文件均配有中文注释和说明

## 📁 包含项目

| 项目 | 内容 | 文件数量 |
|------|------|---------|
| [01-DevOps练习题库](./01-DevOps练习题库/) | 2,600+ 道面试题和练习 | 2,500+ |
| [02-DevOps实战项目](./02-DevOps实战项目/) | 40 个真实项目案例 | 1,200+ |
| [03-DevOps脚本工具集](./03-DevOps脚本工具集/) | 1,000+ 个自动化脚本 | 1,000+ |
| [04-K8s手动部署教程](./04-K8s手动部署教程/) | 从零搭建 Kubernetes 集群 | 100+ |
| [05-Flux2-GitOps示例](./05-Flux2-GitOps示例/) | GitOps 风格的集群管理 | 50+ |
| [06-Prometheus监控方案](./06-Prometheus监控方案/) | 完整的监控栈部署 | 100+ |
| [07-Docker-ELK日志系统](./07-Docker-ELK日志系统/) | 日志收集分析平台 | 150+ |
| [08-Ansible自动化示例](./08-Ansible自动化示例/) | 配置管理自动化 | 300+ |
| [09-GitHub工作流模板](./09-GitHub工作流模板/) | CI/CD 工作流模板 | 200+ |
| [10-开发者学习路线图](./10-开发者学习路线图/) | 交互式学习路径 | 5,000+ |
| [11-从零构建技术指南](./11-从零构建技术指南/) | 28 类技术项目教程 | 50+ |

## 🚀 快速开始

### 克隆仓库

```bash
git clone git@github.com:lin327/DevOps-Learning-Hub.git
cd DevOps-Learning-Hub
```

### 选择学习路径

1. **面试准备**: 查看 [01-DevOps练习题库](./01-DevOps练习题库/)
2. **技能提升**: 按 [10-开发者学习路线图](./10-开发者学习路线图/) 规划学习
3. **动手实践**: 从 [04-K8s手动部署教程](./04-K8s手动部署教程/) 开始
4. **自动化运维**: 学习 [03-DevOps脚本工具集](./03-DevOps脚本工具集/) 和 [08-Ansible自动化示例](./08-Ansible自动化示例/)

## 🎯 适合人群

- DevOps 工程师
- SRE（站点可靠性工程师）
- 云原生开发者
- 运维工程师
- 准备面试的求职者

## 📚 学习建议

### 初学者

1. 从 [01-DevOps练习题库](./01-DevOps练习题库/) 的基础题目开始
2. 学习 [04-K8s手动部署教程](./04-K8s手动部署教程/) 理解 Kubernetes 原理
3. 尝试 [02-DevOps实战项目](./02-DevOps实战项目/) 中的入门项目

### 中级

1. 完成 [01-DevOps练习题库](./01-DevOps练习题库/) 的进阶题目
2. 学习 [03-DevOps脚本工具集](./03-DevOps脚本工具集/) 中的自动化脚本
3. 实践 [08-Ansible自动化示例](./08-Ansible自动化示例/) 中的配置管理

### 高级

1. 挑战 [02-DevOps实战项目](./02-DevOps实战项目/) 中的高级项目
2. 学习 [05-Flux2-GitOps示例](./05-Flux2-GitOps示例/) 中的 GitOps 实践
3. 部署 [06-Prometheus监控方案](./06-Prometheus监控方案/) 和 [07-Docker-ELK日志系统](./07-Docker-ELK日志系统/)

## 📊 学习流程图

### 🎯 完整学习路径

```mermaid
graph TD
    A([🚀 开始 DevOps 学习之旅]) --> B{📌 选择学习方向}
    
    %% 面试准备分支
    B -->|面试准备| C[📝 01-DevOps练习题库]
    C --> C1[🔧 Linux 基础]
    C --> C2[🐳 Docker 容器]
    C --> C3[☸️ Kubernetes]
    C --> C4[☁️ AWS 云服务]
    C --> C5[🌐 网络基础]
    C --> C6[🔒 安全基础]
    
    C1 --> C1a[文件系统管理]
    C1 --> C1b[用户权限管理]
    C1 --> C1c[进程管理]
    C1 --> C1d[Shell 脚本编程]
    
    C2 --> C2a[镜像构建]
    C2 --> C2b[容器运行]
    C2 --> C2c[网络配置]
    C2 --> C2d[存储卷管理]
    
    C3 --> C3a[Pod 管理]
    C3 --> C3b[Service 暴露]
    C3 --> C3c[Deployment 部署]
    C3 --> C3d[Helm 包管理]
    
    C4 --> C4a[EC2 实例]
    C4 --> C4b[S3 存储]
    C4 --> C4c[VPC 网络]
    C4 --> C4d[IAM 权限]
    
    C5 --> C5a[TCP/IP 协议]
    C5 --> C5b[DNS 解析]
    C5 --> C5c[负载均衡]
    C5 --> C5d[防火墙配置]
    
    C6 --> C6a[SSH 密钥管理]
    C6 --> C6b[SSL/TLS 证书]
    C6 --> C6c[安全组配置]
    C6 --> C6d[密钥管理服务]
    
    %% 技能提升分支
    B -->|技能提升| D[🗺️ 10-开发者学习路线图]
    D --> D1[🎨 前端开发]
    D --> D2[⚙️ 后端开发]
    D --> D3[🔧 DevOps]
    D --> D4[🤖 AI/ML]
    D --> D5[📱 移动开发]
    
    D1 --> D1a[HTML/CSS]
    D1 --> D1b[JavaScript]
    D1 --> D1c[React/Vue]
    D1 --> D1d[TypeScript]
    
    D2 --> D2a[Node.js]
    D2 --> D2b[Python]
    D2 --> D2c[Go]
    D2 --> D2d[Java]
    
    D3 --> D3a[Linux]
    D3 --> D3b[Docker]
    D3 --> D3c[Kubernetes]
    D3 --> D3d[CI/CD]
    
    D4 --> D4a[机器学习]
    D4 --> D4b[深度学习]
    D4 --> D4c[自然语言处理]
    D4 --> D4d[计算机视觉]
    
    D5 --> D5a[Android]
    D5 --> D5b[iOS]
    D5 --> D5c[Flutter]
    D5 --> D5d[React Native]
    
    %% 动手实践分支
    B -->|动手实践| E[🛠️ 04-K8s手动部署教程]
    E --> E1[📋 环境准备]
    E1 --> E1a[准备 Linux 服务器]
    E1 --> E1b[安装必要工具]
    E1 --> E1c[配置网络环境]
    
    E --> E2[🔐 证书生成]
    E2 --> E2a[CA 证书]
    E2 --> E2b[API Server 证书]
    E2 --> E2c[Worker Node 证书]
    
    E --> E3[📦 etcd 部署]
    E3 --> E3a[安装 etcd]
    E3 --> E3b[配置集群]
    E3 --> E3c[验证数据存储]
    
    E --> E4[🎛️ 控制平面部署]
    E4 --> E4a[API Server]
    E4 --> E4b[Controller Manager]
    E4 --> E4c[Scheduler]
    
    E --> E5[💻 Worker 节点部署]
    E5 --> E5a[kubelet]
    E5 --> E5b[kube-proxy]
    E5 --> E5c[容器运行时]
    
    E --> E6[🧪 集群验证]
    E6 --> E6a[部署测试应用]
    E6 --> E6b[服务发现测试]
    E6 --> E6c[网络连通性测试]
    
    %% 自动化运维分支
    B -->|自动化运维| F[📜 03-DevOps脚本工具集]
    F --> F1[☁️ 云平台脚本]
    F1 --> F1a[AWS 自动化]
    F1 --> F1b[GCP 自动化]
    F1 --> F1c[Azure 自动化]
    
    F --> F2[🔄 CI/CD 脚本]
    F2 --> F2a[Jenkins 脚本]
    F2 --> F2b[GitHub Actions]
    F2 --> F2c[GitLab CI]
    
    F --> F3[🐳 Docker 脚本]
    F3 --> F3a[镜像管理]
    F3 --> F3b[容器管理]
    F3 --> F3c[网络配置]
    
    F --> F4[☸️ Kubernetes 脚本]
    F4 --> F4a[集群管理]
    F4 --> F4b[应用部署]
    F4 --> F4c[监控告警]
    
    F --> F5[📊 监控脚本]
    F5 --> F5a[Prometheus]
    F5 --> F5b[Grafana]
    F5 --> F5c[ELK Stack]
    
    %% 进阶学习
    C1a --> G[📈 掌握基础知识]
    C2a --> G
    C3a --> G
    C4a --> G
    C5a --> G
    C6a --> G
    
    D1a --> H[🎯 选择技术栈]
    D2a --> H
    D3a --> H
    D4a --> H
    D5a --> H
    
    E6a --> I[💡 理解底层原理]
    
    F1a --> J[⚡ 提升运维效率]
    F2a --> J
    F3a --> J
    F4a --> J
    F5a --> J
    
    %% 中级水平
    G --> K([🏆 中级水平])
    H --> K
    I --> K
    J --> K
    
    %% 高级学习路径
    K --> L{🔬 选择高级方向}
    
    %% 监控与日志方向
    L -->|监控与日志| M[📊 监控体系]
    M --> M1[06-Prometheus监控方案]
    M1 --> M1a[指标采集]
    M1 --> M1b[告警规则]
    M1 --> M1c[Grafana 仪表盘]
    M1 --> M1d[Alertmanager 告警]
    
    M --> M2[07-Docker-ELK日志系统]
    M2 --> M2a[Elasticsearch 存储]
    M2 --> M2b[Logstash 处理]
    M2 --> M2c[Kibana 可视化]
    M2 --> M2d[Filebeat 采集]
    
    M1a --> M3[监控指标设计]
    M1b --> M3
    M1c --> M3
    M1d --> M3
    M2a --> M4[日志分析平台]
    M2b --> M4
    M2c --> M4
    M2d --> M4
    
    %% CI/CD 流水线方向
    L -->|CI/CD 流水线| N[🔄 持续集成/持续部署]
    N --> N1[09-GitHub工作流模板]
    N1 --> N1a[CI 工作流]
    N1 --> N1b[CD 工作流]
    N1 --> N1c[安全扫描]
    N1 --> N1d[自动化测试]
    
    N --> N2[05-Flux2-GitOps示例]
    N2 --> N2a[GitOps 原理]
    N2 --> N2b[Kustomize 配置]
    N2 --> N2c[Helm 发布]
    N2 --> N2d[Flux 控制器]
    
    N1a --> N3[流水线设计]
    N1b --> N3
    N1c --> N3
    N1d --> N3
    N2a --> N4[GitOps 实践]
    N2b --> N4
    N2c --> N4
    N2d --> N4
    
    %% 云原生技术方向
    L -->|云原生技术| O[☁️ 云原生架构]
    O --> O1[11-从零构建技术指南]
    O1 --> O1a[构建数据库]
    O1 --> O1b[构建 Web 服务器]
    O1 --> O1c[构建操作系统]
    O1 --> O1d[构建编译器]
    
    O --> O2[02-DevOps实战项目]
    O2 --> O2a[微服务架构]
    O2 --> O2b[容器编排]
    O2 --> O2c[服务网格]
    O2 --> O2d[无服务器架构]
    
    O1a --> O3[技术深度]
    O1b --> O3
    O1c --> O3
    O1d --> O3
    O2a --> O4[架构设计]
    O2b --> O4
    O2c --> O4
    O2d --> O4
    
    %% 配置管理方向
    L -->|配置管理| P[⚙️ 自动化配置]
    P --> P1[08-Ansible自动化示例]
    P1 --> P1a[Playbook 编写]
    P1 --> P1b[Role 设计]
    P1 --> P1c[Inventory 管理]
    P1 --> P1d[变量与模板]
    
    P --> P2[基础设施即代码]
    P2 --> P2a[Terraform]
    P2 --> P2b[Pulumi]
    P2 --> P2c[CloudFormation]
    
    P1a --> P3[配置管理]
    P1b --> P3
    P1c --> P3
    P1d --> P3
    P2a --> P4[IaC 实践]
    P2b --> P4
    P2c --> P4
    
    %% 高级水平
    M3 --> Q([🥇 高级水平])
    M4 --> Q
    N3 --> Q
    N4 --> Q
    O3 --> Q
    O4 --> Q
    P3 --> Q
    P4 --> Q
    
    %% 专家水平
    Q --> R{🎖️ 选择专家方向}
    
    R -->|SRE| S[🔧 站点可靠性工程]
    S --> S1[故障排查]
    S --> S2[性能优化]
    S --> S3[容量规划]
    S --> S4[混沌工程]
    
    R -->|架构师| T[🏛️ 解决方案架构]
    T --> T1[系统设计]
    T --> T2[技术选型]
    T --> T3[成本优化]
    T --> T4[安全架构]
    
    R -->|技术专家| U[💎 技术深度]
    U --> U1[内核优化]
    U --> U2[网络协议]
    U --> U3[存储系统]
    U --> U4[分布式系统]
    
    S1 --> V([👑 DevOps 专家])
    S2 --> V
    S3 --> V
    S4 --> V
    T1 --> V
    T2 --> V
    T3 --> V
    T4 --> V
    U1 --> V
    U2 --> V
    U3 --> V
    U4 --> V
    
    %% 样式定义
    style A fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    style B fill:#fff3e0,stroke:#e65100,stroke-width:2px
    style K fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px
    style Q fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    style V fill:#ffcdd2,stroke:#b71c1c,stroke-width:2px
    style L fill:#e8f5e8,stroke:#1b5e20,stroke-width:2px
    style R fill:#fff8e1,stroke:#f57f17,stroke-width:2px
```

### 📋 学习阶段详解

```mermaid
graph LR
    subgraph "🌱 初学者阶段"
        A1[Linux 基础] --> A2[Docker 入门]
        A2 --> A3[K8s 基础]
        A3 --> A4[基础练习题]
    end
    
    subgraph "🌿 中级阶段"
        B1[自动化脚本] --> B2[CI/CD 流水线]
        B2 --> B3[监控告警]
        B3 --> B4[配置管理]
    end
    
    subgraph "🌳 高级阶段"
        C1[架构设计] --> C2[性能优化]
        C2 --> C3[安全加固]
        C3 --> C4[故障排查]
    end
    
    subgraph "🏔️ 专家阶段"
        D1[SRE 实践] --> D2[技术领导]
        D2 --> D3[架构决策]
        D3 --> D4[技术布道]
    end
    
    A4 --> B1
    B4 --> C1
    C4 --> D1
    
    style A1 fill:#e8f5e8
    style B1 fill:#e3f2fd
    style C1 fill:#fce4ec
    style D1 fill:#fff3e0
```

### 🛠️ 技术栈学习路径

```mermaid
graph TD
    subgraph "容器化技术"
        A1[Docker] --> A2[Docker Compose]
        A2 --> A3[Kubernetes]
        A3 --> A4[Helm]
        A4 --> A5[服务网格]
    end
    
    subgraph "CI/CD 工具"
        B1[GitHub Actions] --> B2[Jenkins]
        B2 --> B3[GitLab CI]
        B3 --> B4[ArgoCD]
        B4 --> B5[FluxCD]
    end
    
    subgraph "监控体系"
        C1[Prometheus] --> C2[Grafana]
        C2 --> C3[Alertmanager]
        C3 --> C4[ELK Stack]
        C4 --> C5[Jaeger]
    end
    
    subgraph "自动化工具"
        D1[Ansible] --> D2[Terraform]
        D2 --> D3[Pulumi]
        D3 --> D4[CloudFormation]
    end
    
    subgraph "云平台"
        E1[AWS] --> E2[Azure]
        E2 --> E3[GCP]
        E3 --> E4[阿里云]
    end
    
    A5 --> F[云原生架构师]
    B5 --> F
    C5 --> F
    D4 --> F
    E4 --> F
    
    style A1 fill:#e3f2fd
    style B1 fill:#e8f5e8
    style C1 fill:#fce4ec
    style D1 fill:#fff3e0
    style E1 fill:#f3e5f5
    style F fill:#c8e6c9
```

### 🎯 学习时间规划

```mermaid
gantt
    title DevOps 学习时间规划
    dateFormat  YYYY-MM-DD
    section 基础阶段
    Linux 基础           :done, des1, 2024-01-01, 30d
    Docker 入门          :done, des2, after des1, 20d
    K8s 基础             :done, des3, after des2, 30d
    基础练习题           :done, des4, after des3, 20d
    
    section 中级阶段
    自动化脚本           :active, des5, after des4, 30d
    CI/CD 流水线         :des6, after des5, 30d
    监控告警             :des7, after des6, 30d
    配置管理             :des8, after des7, 30d
    
    section 高级阶段
    架构设计             :des9, after des8, 40d
    性能优化             :des10, after des9, 30d
    安全加固             :des11, after des10, 30d
    故障排查             :des12, after des11, 30d
    
    section 专家阶段
    SRE 实践             :des13, after des12, 60d
    技术领导             :des14, after des13, 60d
    架构决策             :des15, after des14, 60d
    技术布道             :des16, after des15, 60d
```

### 🔄 学习循环

```mermaid
graph LR
    A[学习] --> B[实践]
    B --> C[总结]
    C --> D[分享]
    D --> A
    
    A --> A1[阅读文档]
    A --> A2[观看教程]
    A --> A3[参加培训]
    
    B --> B1[动手实验]
    B --> B2[项目实战]
    B --> B3[故障模拟]
    
    C --> C1[记录笔记]
    C --> C2[整理知识]
    C --> C3[查漏补缺]
    
    D --> D1[写博客]
    D --> D2[做分享]
    D --> D3[帮他人]
    
    style A fill:#e1f5fe
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
```

## 🔧 技术栈

- **容器化**: Docker, Kubernetes
- **CI/CD**: GitHub Actions, Jenkins, GitLab CI
- **监控**: Prometheus, Grafana, ELK Stack
- **自动化**: Ansible, Terraform
- **云平台**: AWS, Azure, GCP

## 📖 文档

- 每个项目目录下都有详细的 README 文件
- 所有文件均配有中文注释版本（`*_zh.md` 或 `*_zh.sh`）
- 项目说明文档: [项目说明.md](./项目说明.md)

## 🤝 贡献

欢迎提交 Pull Request 添加更多学习资源！

## 📄 许可证

本项目包含多个开源项目，请查看各项目目录下的 LICENSE 文件了解具体许可协议。

## 🔗 相关链接

- [GitHub 仓库](https://github.com/lin327/DevOps-Learning-Hub)
- [项目说明](./项目说明.md)

---

**开始你的 DevOps 学习之旅吧！** 🚀
