#!/bin/bash

ln -sf /home/deploy/shared/assets /home/deploy/current/public/assets
ln -sf /home/deploy/shared/cache /home/deploy/current/public/cache
ln -sf /home/deploy/shared/tmp /home/deploy/current/tmp
echo "export RACK_ENV=$RACK_ENV" > /etc/default/nginx

exec /sbin/my_init