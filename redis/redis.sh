#!/bin/bash

exec /sbin/setuser redis /usr/bin/redis-server >>/var/log/redis.log 2>&1
