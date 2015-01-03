FROM sameersbn/ubuntu:14.04.20141218
MAINTAINER Yuki Matsukura "matsubokkuri@gmail.com"

RUN locale-gen en_US.UTF-8
RUN apt-get -qq update && LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get install -y -q  mysql-server

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

VOLUME ["/var/lib/mysql"]
VOLUME ["/run/mysqld"]

EXPOSE 3306
CMD ["/usr/local/bin/run"]

