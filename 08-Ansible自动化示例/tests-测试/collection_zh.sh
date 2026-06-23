#!/usr/bin/env bash
# 中文注释版本: collection.sh
# 所在目录: tests-测试

#!/bin/bash
#
# Collection playbook tests.
set -e

# Install dependencies.
pip3 install ansible

cd collection

# Run Ansible playbook.
ansible-playbook -c local -i 'localhost,' main.yml
