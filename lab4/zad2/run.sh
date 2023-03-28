#!/bin/bash
docker volume create all_volumes
docker volume create nginx_data
docker volume create nodejs_data

docker run \
    -d \
    --name nginx_srv \
    --volume all_volumes:/all_volumes \
    --volume nginx_data:/app \
    nginx

docker run \
    -dit \
    --name nodejs_srv \
    --volume all_volumes:/all_volumes \
    --volume nodejs_data:/app \
    node:current-alpine

docker exec nginx_srv bash -c "\
    cd /app; \
    touch nginx_{a..c}.txt \
"
docker exec nodejs_srv sh -c "
    cd /app;
    seq 3 | xargs -n1  -I{} touch nodejs_{}.txt
"

docker exec nginx_srv sh -c 'cp /usr/share/nginx/html/* /all_volumes'
docker exec nodejs_srv sh -c 'cp /app/* /all_volumes'

volume1_dir=$(docker volume inspect --format '{{ .Mountpoint }}' nginx_data)
volume2_dir=$(docker volume inspect --format '{{ .Mountpoint }}' nodejs_data)
volume3_dir=$(docker volume inspect --format '{{ .Mountpoint }}' all_volumes)

echo "Wolumin nginx_data:"
sudo ls "$volume1_dir"
echo
echo "Wolumin nodejs_data:"
sudo ls "$volume2_dir"
echo
echo "Wolumin all_volumes:"
sudo ls "$volume3_dir"
