#!/bin/sh

# Install Docker
lsmod | grep aufs || modprobe aufs || apt-get install -y linux-image-extra-`uname -r`
wget -qO- https://get.docker.io/gpg | apt-key add -
echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y lxc-docker
apt-get -y autoremove

# Git
apt-get install -y git

# Create deploy user
adduser deploy --uid 1111 --disabled-password --gecos ""
mkdir -p /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
chown -R deploy:deploy /home/deploy/.ssh
