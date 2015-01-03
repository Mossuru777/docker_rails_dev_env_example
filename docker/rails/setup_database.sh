#!/bin/bash

cd /app
bundle exec rake db:drop db:create db:migrate db:seed

