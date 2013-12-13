#!/bin/bash

cd /home/deploy
mkdir -p shared/assets
mkdir -p shared/tmp
mkdir -p shared/cache
chown deploy:deploy shared shared/assets shared/tmp shared/cache
ln -sf /home/deploy/shared/assets /home/deploy/current/public/
ln -sf /home/deploy/shared/cache /home/deploy/current/public/
ln -sf /home/deploy/shared/tmp /home/deploy/current/
echo "export RACK_ENV=$RACK_ENV" > /etc/default/nginx

exec /sbin/my_init