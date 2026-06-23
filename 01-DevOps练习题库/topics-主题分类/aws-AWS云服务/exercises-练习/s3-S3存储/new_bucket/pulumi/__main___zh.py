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

# Private Bucket
private_bucket = aws.s3.Bucket("my-first-private-bucket",
                               acl="private",
                               tags={
                                   "Environment": "Exercise",
                                   "Name": "My First Private Bucket"},
                               region="eu-west-2"
                               )

# Bucket Object
aws.s3.BucketObject("bucketObject",
                    key="some_object_key",
                    bucket=private_bucket.id,
                    content="object content")

# Public Bucket
aws.s3.Bucket("my-first-public-bucket",
              acl="public-read",
              tags={
                  "Environment": "Exercise",
                  "Name": "My First Public Bucket"},
              region="eu-west-1",
              versioning=aws.s3.BucketVersioningArgs(enabled=True))
