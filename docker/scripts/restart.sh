docker stop rails
docker rm rails
docker run -d -p 3000:3000 -v /app:/app --link redis:redis --link mysql:db --name rails rails:latest
