#!/bin/bash
docker volume create nginx_data
docker run \
    -d \
    --name nginx_srv \
    --volume nginx_data:/usr/share/nginx/html \
    nginx

volume_dir=$(docker volume inspect --format '{{ .Mountpoint }}' nginx_data)
docker cp index.html nginx_srv:/usr/share/nginx/html
sudo cat "$volume_dir/index.html"
