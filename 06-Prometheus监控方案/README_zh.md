# Prometheus 监控方案

Docker Compose 部署的 Prometheus + Grafana 监控栈，包含 cAdvisor、node-exporter、Alertmanager。

---

## 📁 **目录结构**

| 目录 | 用途 |
|------|------|
| alertmanager-告警管理器 | Alertmanager 配置 |
| dashboards-仪表盘 | Grafana 仪表盘 JSON |
| grafana-Grafana配置 | Grafana 数据源配置 |
| prometheus-Prometheus配置 | Prometheus 采集配置 |

---

## 🚀 **如何使用**

1. 运行 docker-compose.yml 启动服务
2. 访问 Grafana 查看监控数据
3. 配置告警规则
