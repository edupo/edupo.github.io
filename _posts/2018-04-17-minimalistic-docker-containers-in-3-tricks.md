---
layout: post
title: '`dockerfile` tricks'
description: 3 tricks to improve your dockerfiles
image: assets/images/logo_docker.png
date: '2018-04-17 14:57:51 +0200'
categories:
  - DevOps
  - Programming
tags:
  - software
  - Docker
  - software automation
  - container
---

One of the common mistakes we commit when starting with Docker is not taking into account the size of a produced container. This usually happens due to our goal to develop fast and easily for our own personal use.

But when we want to push a container to the public registries or when we want to distribute it in our company the size of the container can have a big impact on the discussions on _why is so awesome to work in virtualized environments_. I want to propose you 3 tricks to minimize your containers.

# 1 - Clean up after every command

Is not easy to see but docker thinks about each command of your `Dockerfile` as a layer. Each layer is a folder by itself that gets overlayed on top of the rest and will keep all the information produced by the command you executed. Is typical to start your `Dockerfile` by writing something like:

```
FROM ubuntu
RUN apt-get update
RUN apt-get install -y wget
```

This simple command will produce 2 separated layers. The first will contain all the indexes coming from the `apt-get update` and the second layer will install your package. As you may imagine you _don't_ want the indexes laying on your container so you are maybe tempted to do a cleanup afterward.

```
FROM ubuntu
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get clean
```

But the **damage is already done**. The first layer will never change since it has been built. Even if you check now, the container **won't contain the indexes**, but the layer **will contain them**, occupying precious space. The trick is to atomize the commands including all the required cleanups after it. Remember that **every command in a `Dockerfile` is a layer**! A much better `Dockerfile` will do:

```
FROM ubuntu
RUN apt-get update \
    && apt-get install -y wget \
    && apt-get clean
```

- You can split lines in a `Dockerfile` just appending `\` at the end.
- `&&` won't extend the duration of the build after a previous command fails.

# 2 - Choose your base image wisely

Some images are better designed to be small. Proof of it may be the `alpine` image available as the open source image. The distribution package manager `apk` is well-designed for avoiding any unwanted cache generated. Looking at the same process of getting `wget` in `alpine` will look much cleaner and the resulting layer is more likely to be smaller.

```
FROM alpine
RUN apk add --no-cache wget
```

- Choosing a different base image may **change the package names** you need or even the locations you expect the files to be installed.

# 3 - Build in another container

This is my favorite trick. If you need to compile some program instead of doing all the processes in the same container just create a temporary one and then just copy the results to the final one.

```
# Build container
FROM alpine:latest as temp
RUN apk add --no-cache git RUN git clone --recursive <https://github.com/vysheng/tg>
RUN apk add --no-cache libconfig-dev readline-dev libexecinfo-dev \ python-dev openssl-dev libevent-dev \ jansson-dev lua-dev RUN apk add --no-cache g++ make
RUN ./tg/configure; make

# Final image
FROM alpine:latest
RUN apk add --no-cache libevent jansson libconfig libexecinfo \ readline lua openssl
COPY --from=temp /bin/telegram-cli /bin/telegram-cli
ENTRYPOINT ["/bin/telegram-cli"]`
```

This [container](https://github.com/edupo/docker-telegram-cli/blob/master/Dockerfile) I wrote for having a containerized `telegram-cli` is my example of minimalistic containers.

1. `FROM alpine:latest as temp` This first line will create a temporary container named `temp` that can be used to copy things from as described in the [reference](https://docs.docker.com/engine/reference/builder/#from). This is quite handy for creating temporary build environments that are later discarded.
2. `RUN apt add --no-cache libconfig-dev ...` Installs the required `dev` dependencies containing in this case the header files and all the required build information. And that is something we don't want in our final container!
3. `FROM alpine:latest` the next `FROM` the command that will create the final image.
4. `RUN apt add --no-cache libconfig ...` now is the time to install the runtime dependencies only.
5. `COPY --from=temp /bin/telegram-cli ...` This is where the magic happens: We can use `COPY --from=temp` to specify the docker daemon to perform the copy from a previously named container. So we can copy the built program from a _build container_ to a _runtime container_.
