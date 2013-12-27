---
title: What is Docker
summary: How is Docker different from a traditional VM?
tags: Devops
---

I've heard a lot about Docker lately. But it is only last week that I've really understood what it's all about.

> Docker is an open-source abstraction that automates the deployment of any application as a lightweight, portable, self-sufficient container that will run everywhere.

<div class="overflow">
  <figure class="right">
    <img src="http://louisalbankim.s3-eu-west-1.amazonaws.com/posts/what-is-docker/docker_arch.svg"/>
    <figcaption>Source: <a href="http://zaiste.net/talks/docker-rio-13-11">http://zaiste.net/talks/docker-rio-13-11</a></figcaption>
  </figure>
  <p>
    As you can see, you skip the VM and its second OS layer.
    It means you keep the isolation (processes, filesystem, network) and the portability, but without the overhead of a VM.
  </p>
  <p>
    After using it for a week, I can say that the main advantage compared to VM + Chef/Puppet is the friction it removes to iterate while building your server stack.
  </p>
</div>

<div class="overflow">
  <figure class="left">
    <img src="http://louisalbankim.s3-eu-west-1.amazonaws.com/posts/what-is-docker/docker_iterate.svg"/>
  </figure>
  <p>
    An iteration typically looks like this: configure/run/commit. At each iteration you decide to keep your changes (commit) or revert to the previous state. And with Docker, <strong>this.is.fast</strong>.
  </p>
</div>

Instead of using the commit feature of Docker, you can build your Dockerfile in the same iterative way:

* Use a base image with `FROM`
* Add some `RUN` commands
* Run and check if it works as expected
* Decide if you keep the changes or revert

A basic Docker example
----------------------

I will show you a very simple way to get started with Docker.
All you need is [Vagrant](http://www.vagrantup.com/).

First, create a new folder. We will need only 2 files at the root of this folder:

~~~ ruby
# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-12.04-server-amd64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network :private_network, ip: "33.33.33.33"
  config.vm.network :forwarded_port, guest: 4567, host: 4567
  # Update the Linux kernel to 3.8 for Docker to function properly
  config.vm.provision :shell, inline: %Q{
    sudo apt-get update
    sudo apt-get install -y linux-image-generic-lts-raring linux-headers-generic-lts-raring
  }
  config.vm.provision :docker
  # Uncomment this line if your VM is slow
  # config.vm.synced_folder "./", "/vagrant", type: "nfs"
end
~~~

~~~ shell
# Dockerfile
FROM ubuntu:12.04

# Install Ruby 2.0
RUN apt-get install -y python-software-properties
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y ruby2.0
~~~

This means: _start from the Ubuntu 12.04 base image, then install Ruby 2.0 from the Brightbox ppa_.

Now let's start our Vagrant VM and build our first Docker image:

~~~ shell
$ vagrant up
# We need to reboot the VM, because of the kernel update (see Vagrantfile)
$ vagrant reload
$ vagrant ssh
$ cd /vagrant
$ docker build -t ruby2.0 .
~~~

This will fetch the base `ubuntu` image, execute all the `RUN` commands on it, then save your new image with the `ruby2.0` tag.

~~~ shell
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ruby2.0             latest              505674a43862        9 seconds ago       251 MB
ubuntu              12.04               8dbd9e392a96        8 months ago        128 MB
~~~

As you can, we now have the base `ubuntu` image and our brand new `ruby2.0` image.
Lets run our Docker container with this new image and run the `ruby -v` command on it to check if the installation is successful:

~~~ shell
$ docker run ruby2.0 ruby -v
ruby 2.0.0p353 (2013-11-22 revision 43784) [x86_64-linux-gnu]
~~~

You can also run an interactive shell to do that:

~~~ shell
$ docker run -i -t ruby2.0 bash -l
$ ruby -v
ruby 2.0.0p353 (2013-11-22 revision 43784) [x86_64-linux-gnu]
~~~

A Docker container runs as a single self-sufficient process.
Notice how fast the container starts. Pretty impressive, right? That's when things get interesting.

We now have completed our first iteration (install Ruby 2.0), let's move on to the next one: install Sinatra.

Add this line at the end of your Dockerfile

~~~ shell
RUN gem install sinatra --no-ri --no-rdoc
~~~

Add a file named `hello.rb` at the root of your project folder:

~~~ ruby
require 'sinatra'
set :bind, '0.0.0.0'

get '/' do
  "Hello World!"
end
~~~

Now let's build our new container and run our Sinatra app!

~~~ shell
$ docker build -t sinatra .
$ docker run -v /vagrant:/vagrant -p 4567:4567 sinatra ruby /vagrant/hello.rb
~~~

The last command means: _use the `sinatra` image, create a bind mount of `/vagrant` on the host with `/vagrant` on the container, forward port 4567 on the host to port 4567 on the container, then run our Sinatra app_.

Now open your browser and visit [http://localhost:4567](http://localhost:4567) and voilà! You should see `Hello world!`.

Note that we can access the Sinatra app on localhost, because we told Vagrant to forward port 4567 to the same on the VM (see the `Vagrantfile`), which in turn forwards it to the Docker container.

From that point, each iteration will be a breeze and you'll enjoy the "power of Docker" &trade;.

In my next post, I'll show you how to embrace [Dev/prod parity](http://12factor.net/dev-prod-parity) and create an Nginx/Passenger stack that you'll use locally for development and on a [Digital Ocean](https://www.digitalocean.com/?refcode=2f38e88e8249) server for production.
