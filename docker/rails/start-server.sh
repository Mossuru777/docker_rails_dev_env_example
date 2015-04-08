#!/bin/bash

if [ ! -e /persistent/db_initialized ]; then
    /setup_database.sh
fi

cd /app
bundle exec unicorn -p 3000
