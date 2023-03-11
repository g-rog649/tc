#!/bin/bash
docker run --name my-nginx -d nginx
container_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' my-nginx)
docker cp index.html my-nginx:/usr/share/nginx/html
echo "Server started on $container_ip:80"
xdg-open $container_ip
