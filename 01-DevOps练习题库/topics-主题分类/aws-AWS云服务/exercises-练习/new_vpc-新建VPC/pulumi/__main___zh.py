#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: __main__.py
所在目录: pulumi
说明: 本文件为 __main__.py 的中文注释版本
"""

# ? 原始文件内容
import pulumi
import pulumi_awsx as awsx

vpc = awsx.ec2.Vpc("exercise-vpc", cidr_block="10.0.0.0/16")

pulumi.export("vpc_id", vpc.vpc_id)
pulumi.export("publicSubnetIds", vpc.public_subnet_ids)
pulumi.export("privateSubnetIds", vpc.private_subnet_ids)

# Run 'pulumi up' to create it
