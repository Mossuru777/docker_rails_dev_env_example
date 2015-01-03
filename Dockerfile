FROM sameersbn/ubuntu:14.04.20141218
MAINTAINER Yuki Matsukura "matsubokkuri@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q  software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

# INSTALL
RUN apt-get install -y -q build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison pkg-config libmysqlclient-dev libpq-dev make wget unzip git vim nano nodejs mysql-client gawk libgdbm-dev libffi-dev

RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build

# Install ruby
RUN ruby-build -v 2.2.0 /usr/local
 
# Install base gems
RUN gem install bundler rubygems-bundler --no-rdoc --no-ri
 
# Regenerate binstubs
RUN gem regenerate_binstubs

# Rails app
ADD docker/rails/start-server.sh /start-server.sh
RUN chmod +x /start-server.sh
# RUN mkdir /app

# Preinstall majority of gems
WORKDIR /tmp 
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install 


ENV RAILS_ENV development

WORKDIR /app
RUN bundle install

ADD ./docker/rails/setup_database.sh /setup_database.sh
RUN chmod +x /setup_database.sh

EXPOSE 3000

CMD ["/start-server.sh"]
