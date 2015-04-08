docker stop rails
docker rm rails
docker build -t rails /app
docker run -d -p 3000:3000 -v /app:/app -v /persistent --link redis:redis --link mysql:db --name rails rails:latest
