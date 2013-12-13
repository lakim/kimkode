#!/bin/sh

if [ -d /vagrant ]; then
  ln -sfT /vagrant /home/deploy/current
fi
echo "export RACK_ENV=$RACK_ENV" > /etc/default/nginx
exec /sbin/my_init
