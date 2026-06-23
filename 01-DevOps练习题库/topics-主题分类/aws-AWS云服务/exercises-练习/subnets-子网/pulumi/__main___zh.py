#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
中文注释版本
原始文件: __main__.py
所在目录: pulumi
说明: 本文件为 __main__.py 的中文注释版本
"""

# ? 原始文件内容
import pulumi_aws as aws

availableZones = aws.get_availability_zones(state="available")

aws.ec2.Subnet("NewSubnet1",
               vpc_id=aws.vpc["main"]["id"],
               cidr_block="10.0.0.0/24",
               availability_zone=availableZones.names[0],
               tags={"Name": "NewSubnet1"}
               )

aws.ec2.Subnet("NewSubnet2",
               vpc_id=aws.vpc["main"]["id"],
               cidr_block="10.0.1.0/24",
               availability_zone=availableZones.names[1],
               tags={"Name": "NewSubnet2"}
               )

aws.ec2.Subnet("NewSubnet3",
               vpc_id=aws.vpc["main"]["id"],
               cidr_block="10.0.2.0/24",
               availability_zone=availableZones.names[2],
               tags={"Name": "NewSubnet3"}
               )

# Run "pulumi up"
