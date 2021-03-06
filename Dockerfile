# Dockerfile for statsd
#
# VERSION               0.1
# DOCKER-VERSION        0.4.0

from    ubuntu:14.04
run     apt-get -y update
run     apt-get -y install wget git python supervisor
run     wget -O /tmp/node-v0.11.0.tar.gz http://nodejs.org/dist/v0.11.0/node-v0.11.0-linux-x64.tar.gz 
run     tar -C /usr/local/ --strip-components=1 -zxvf /tmp/node-v0.11.0.tar.gz
run     rm /tmp/node-v0.11.0.tar.gz
run     git clone git://github.com/etsy/statsd.git statsd
run     mkdir -p /var/log/supervisor

add     ./config.js ./statsd/config.js
add     ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

expose  :8125/udp
expose  8126/tcp

cmd     supervisord -n
