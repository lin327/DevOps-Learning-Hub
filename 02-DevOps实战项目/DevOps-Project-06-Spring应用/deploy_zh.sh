#!/usr/bin/env bash
# 中文注释版本: deploy.sh
# 所在目录: DevOps-Project-06-Spring应用

#!/bin/bash
kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
