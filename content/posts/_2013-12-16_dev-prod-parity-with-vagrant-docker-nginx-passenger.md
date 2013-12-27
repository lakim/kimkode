---
title: Dev/prod parity with Vagrant, Docker, Nginx and Passenger
summary: Create a Rails box that will run anywhere, consistantly.
tags: Ruby, Rails
---

I've heard a lot about Docker. But it is only last week that I've really understood what it's all about.

What is Docker?
---------------

> Docker is an open-source abstraction that automates the deployment of any application as a lightweight, portable, self-sufficient container that will run everywhere.

![Docker architecture](https://s3-eu-west-1.amazonaws.com/louisalbankim/posts/dev-prod-parity-with-vagrant-docker-nginx-passenger/docker_arch.svg)

Source: http://zaiste.net/talks/docker-rio-13-11

As you can see, you skip the VM and its second OS layer.
It means you keep the isolation (processes, filesystem, network) and the portability, but without the overhead of a VM.

After having using it for a week, I can say that the main advantage is the friction it removes to iterate while building your server stack.
An iteration typically looks like this: configure/run/commit. At each iteration you decide to keep your changes (commit) or to throw them to start at the previous step. And with Docker, this.is.fast.

```shell
docker run -p 80:80 -p 2222:22 \
  -v /home/deploy:/home/deploy \
  -v /vagrant:/vagrant \
  -e RACK_ENV=development \
  louisalbankim
```

https://github.com/phusion/passenger-docker
