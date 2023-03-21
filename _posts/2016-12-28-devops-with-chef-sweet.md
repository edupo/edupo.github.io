---
layout: post
title: DevOps with Chef. Sweet.
image: assets/images/logo_chef.png
date: '2016-12-28 12:17:35 +0100'
categories:
  - uncategorized
  - DevOps
tags:
  - technology
  - software
  - automation
  - DevOps
  - Ruby
  - Chef
  - infrastructure
  - setup
  - stuffing
  - deployment
  - source
  - continous integration
---

**I needed to set up a few servers for QA** and provision development environments for my team so I started a small [make-based repo](https://github.com/edupo/home-assistant) where to put all the nasty configuration and provisioning stuff. After a few days of work, I decided to look for solutions on the world wide web. Then discovered the [DevOps](https://es.wikipedia.org/wiki/DevOps) discipline.

> DevOps enlightened me. Is exactly what I was looking for!

I work in an industrial environment with **real-time** and **embedded software** using tools such as **Yocto** and scripting. Not related to web development at all and even less to cloud computing... So DevOps was quite far away from my environment, but as a curious guy I started diving into it: [Ansible](https://www.ansible.com/), [Docker](https://www.docker.com/), [Puppet](https://puppet.com/), [Salt](https://saltstack.com/)... And finally, I looked into [Chef](https://www.chef.io/chef/). Exactly what I was looking for. Remember my objective: setting up some servers for QA and CI for my team and provisioning our developer environments with the proper tools. Well, Chef is designed exactly for that!

# Why Chef?

[Ruby](https://www.ruby-lang.org/en/). If you don't know about Ruby, it is a small and nifty language. I recommend starting with the [koans](http://rubykoans.com/). As a developer, having a **language** instead of some **custom file** syntax or an **obscure engine** is always a plus. Of course, you will have some drawbacks enforcing yourself to deal with infrastructure and setup, but depending on the size of your team, is something you may need to deal with it anyway. If your team is not enlightened yet by DevOps something you will get from Chef among other similar tools are the DevOps mantras:

- Environment replication.
- Scalability.
- Infrastructure as code. (Version controlled)
- Quality and reliability.

And with Chef, as an open source project, you will also have [lots](https://github.com/chef) and [lots](https://discourse.chef.io/) of community support and a complete **community repository of recipes**: [The supermarket](https://supermarket.chef.io/).

# Where to start?

Is not in the scope of this blog entry to show Chef, but there is a lot of information in their [learning portal](https://learn.chef.io/) and some nice [books](https://www.amazon.co.uk/s/ref=nb_sb_noss_1?url=search-alias%3Daps&field-keywords=chef+automation) to start with. Is a matter of a couple of days to start doing Chef recipes and organizing your infrastructure just learning Ruby and having a nice introductory reading, I personally read [_Learning Chef_](https://www.amazon.co.uk/Learning-Chef-Configuration-Management-Automation/dp/1491944935/ref=sr_1_1?ie=UTF8&qid=1482921515&sr=8-1&keywords=chef+automation)_._ Please, let me know if this information was helpful for you!
