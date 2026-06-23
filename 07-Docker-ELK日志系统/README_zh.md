# Docker ELK 日志系统

Docker Compose 部署的 Elasticsearch + Logstash + Kibana 日志收集分析平台。

---

## 📁 **目录结构**

| 目录 | 用途 |
|------|------|
| elasticsearch-Elasticsearch | Elasticsearch 配置 |
| kibana-Kibana | Kibana 配置 |
| logstash-Logstash | Logstash 配置 |
| setup-初始化脚本 | 用户初始化脚本 |
| extensions-扩展组件 | 可选插件 |

---

## 🚀 **如何使用**

1. 运行 setup-初始化脚本 初始化用户
2. 启动 docker-compose.yml
3. 访问 Kibana 查看日志
