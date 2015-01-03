#!/bin/bash
docker run -i -t -v /app:/app --link redis:redis --link mysql:db  --rm rails:latest bash -c "cd /app && bundle exec rails c"
