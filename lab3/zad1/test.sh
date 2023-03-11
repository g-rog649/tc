#!/bin/bash
docker ps -a --format "{{.Names}}" | grep -Eq '^my-nginx$'
if [ $? -ne 0 ]; then
    echo "Kontener nie istnieje"
    exit 1
fi

container_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' my-nginx)
curl -s $container_ip
if [ $? -ne 0 ]; then
    echo "Nie udało się połączyć z serwerem"
    exit 1
fi

echo "Wszystko działa"
exit 0
