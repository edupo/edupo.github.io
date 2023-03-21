---
layout: post
title: Validating Jenkinsfile
image: assets/images/logo_jenkins.png
date: '2017-05-02 12:00:41 +0200'
categories:
  - DevOps
tags:
  - automation
  - test
  - make
  - continous integration
  - Jenkins
  - REST
  - API
  - validation
---

I had many problems with `Jenkinsfile` lately.

The syntax is so picky that after a push my plan fails just because I forgot a comma or something as ridiculous as that. In my opinion, there are better human input methods for such a file, like YAML. But hey! I'm not developing Jenkins.

Anyway, I just integrated a target into my project makefile to test the validity of the Jenkins file. The only way, in this case, is to send it to your Jenkins server to test it like so:

```
jenkins.validate:
    @curl -X POST -F "jenkinsfile=<Jenkinsfile" \
      http://localhost:8080/pipeline-model-converter/validate
    @echo "Jenkinsfile tested."
```

Is super nice to use the REST API to validate your files but still, this has some problems to consider: security (posting to HTTP) or weight of the solution (you need to have a complete Jenkins server in your local host). But that's not in the scope of this entry.

> _Edit 2023: I've worked with GitHub actions and Gitlab jobs and I rather prefer them over Jenkins. True that Jenkins uses a full script language, but the declarative nature of both mentioned alternatives and the simplicity of the configuration are truly remarkable. I'm still looking for a CI description language that you can execute locally though. Having to push and wait for the server to run is not that efficient for me._
