# Docker Examples

## 1. Django Dockerfile
This Dockerfile is within `django_docker` folder. It's content is as below:

```
FROM django:python2-onbuild
RUN python manage.py migrate
```

While this is very barebone and trivial, this is exactly how I would package my
Django app today. A less trivial Dockerfile is described below.

## 2. Redis Dockerfile
This Dockerfile is within `redis` folder. This time I tried to install Redis
using [phusion/baseimage](https://github.com/phusion/baseimage-docker) as base
because I've seen various projects using this as base image such as
[hectcastro/docker-riak](https://github.com/hectcastro/docker-riak).
It's content is as below:

```
FROM phusion/baseimage:0.9.17

CMD ["/sbin/my_init"]

# Install Redis
WORKDIR /usr/src
RUN apt-get update
RUN apt-get install wget build-essential -y
RUN wget http://download.redis.io/releases/redis-3.0.5.tar.gz
RUN tar xzf redis-3.0.5.tar.gz
WORKDIR /usr/src/redis-3.0.5
RUN make
RUN cp /usr/src/redis-3.0.5/src/redis-server /usr/bin/

# prepare redis user
RUN useradd -ms /bin/bash redis

# Make redis one of the services
RUN mkdir /etc/service/redis
ADD redis.sh /etc/service/redis/run
RUN chmod +x /etc/service/redis/run

EXPOSE 6379

# clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```

## 3. Docker Compose
I've also included a `docker-compose.yml` file which list both services. I've
not written any Django code to communicate with Redis but this setup provide the
basis for such communication:

```
web:
  build: django_docker
  ports:
   - "8000:8000"
  links:
   - redis
redis:
  build: redis
```
