#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  中文注释版本
#  原始文件: deploy.sh
#  所在目录: aws-autoscaling
#  说明: 本文件为 deploy.sh 的中文注释版本
#

# ? 设置严格模式
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

# ? 原始文件内容
#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get -y install nginx
cd /var/www/html
wget https://www.tooplate.com/zip-templates/2135_mini_finance.zip
apt install unzip
unzip 2135_mini_finance.zip
rm -rf 2135_mini_finance.zip index.nginx-debian.html
cd 2135_mini_finance/
mv * ../
rm -rf 2135_mini_finance/
systemctl enable nginx
systemctl restart nginx
apt install mysql-server -y
