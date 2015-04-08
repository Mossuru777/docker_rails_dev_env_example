#!/bin/bash
docker run -i -t -v /app:/app -v /persistent --link redis:redis --link mysql:db --rm rails:latest /bin/bash -c "cd /app && eval '$1'"
