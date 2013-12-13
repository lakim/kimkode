#!/bin/sh

# Create deploy user
adduser deploy --uid 1111 --disabled-password --gecos ""
mkdir -p /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
chown -R deploy:deploy /home/deploy/.ssh
