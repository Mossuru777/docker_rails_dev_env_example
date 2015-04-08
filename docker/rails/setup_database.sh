#!/bin/bash

cd /app
bundle install
bundle exec rake db:drop db:create db:migrate db:seed

touch /persistent/db_initialized
