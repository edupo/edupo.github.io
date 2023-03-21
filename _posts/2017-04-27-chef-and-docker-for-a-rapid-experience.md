---
layout: post
title: Chef and Docker for a rapid infrastructure development
image: assets/images/logo_chef.png
date: '2017-04-27 10:32:14 +0200'
categories:
  - uncategorized
  - DevOps
tags:
  - Development
  - DevOps
  - Chef
  - Docker
  - Kitchen
---

We started using [Chef](http://chef.io) a while ago and one of the first steps we took was to use Docker instead of Vagrant for performing tests due to its faster setup.

After all this time I can say it was a nice experience and now our CI is happily testing out in minutes. So...

# What do you need?

Basically, you need to install the [latest ChefDK](https://downloads.chef.io/chefdk) where the gem [kitchen-dokken](https://github.com/someara/kitchen-dokken) is installed by default. This gem enables lightweight tooling to use Docker containers for executing Kitchen.

# Setup

After that, you just need to set up your `kitchen.yml` to use dokken as a driver like so:

```
driver:
  name: dokken
  chef_version: latest

transport:
  name: dokken

provisioner:
name: dokken

...
```

The `transport` and the `provisioner` are set to `dokken` so the kitchen will use the lighter tooling from the driver. Then you can set up your platform to test your cookbooks:

```
- name: ubuntu-16.04
    driver:
      image: ubuntu:16.04
      pid_one_command: /bin/systemd
      intermediate_instructions:
        - RUN /usr/bin/apt-get update
```
