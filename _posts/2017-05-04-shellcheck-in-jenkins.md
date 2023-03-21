---
layout: post
title: Shellcheck in Jenkins
image: assets/images/logo_jenkins.png
date: '2017-05-04 13:16:07 +0200'
categories:
  - DevOps
tags:
  - automation
  - test
  - bash
  - DevOps
  - continous integration
  - lint
  - CI
  - Jenkins
  - grep
  - shellcheck
  - shell
---

All we've written `shell` scripts. And at the speed we need to deploy is easy to make mistakes (beginner mistakes). So I decided to integrate Shellcheck in Jenkins so that when a commit is done the CI drops a complete shell check analysis of the code. A test in your CI could be something like:

```
grep -rIl '^#![[:blank:]]_/bin/(bash|sh|zsh)' \ --exclude-dir=.git --exclude=_.sw? \
     | xargs shellcheck
```

The exclude switches are useful for _git_ and _vim_ users respectively. Is **strongly advised** to check for the availability of _shellcheck_ in your build agent before the test. I use to wrap my test code with some kind of check like so:

```
if which shellcheck ; then

# Do your tests here

`fi`
```

There are other nice ways of performing automatic tests using make as your procedure executor. I will talk about that in later posts. Happy testing! Edit: A nice snippet for your Makefiles could be like so.

<script src="https://gist.github.com/edupo/3f44d4e3f5250f178c06593dcac55044.js">
</script>
