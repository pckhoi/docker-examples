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
