---
layout: post
title: 'Iterating a list of objects with `for_each` in `terraform`'
description: 'Iterating a list of objects with `for_each` to improve performance.'
image: assets/images/logo_terraform.png
date: '2023-08-06 17:53:00 +0200'
categories:
  - DevOps
  - Programming
tags:
  - software
  - terraform
  - cloud
  - infrastructure
---

`for_each` in terraform works with maps and uses the key to uniquely identify
resources. So how can we iterate a list of objects coming from outside a module?

Imagine you have a module creating some resources in AWS and you pass to it a
list of roles which has been created by other external modules as these roles
are global. From your root module then you manually pass a list of roles that
an EC2 instance must assume to access an S3 bucket for example.

```
resource 