#!/bin/bash
docker stop rails

docker run -i -t -v /app:/app -v /persistent --link redis:redis --link mysql:db --rm rails:latest /bin/bash -c "/setup_database.sh"

docker start rails
