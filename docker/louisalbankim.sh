#!/bin/bash

echo "export RACK_ENV=$RACK_ENV" > /etc/default/nginx
exec /sbin/my_init
