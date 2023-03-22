#!/bin/bash
docker ps -a --format "{{.Names}}" | grep -Eq '^nginx_srv$'
if [ $? -ne 0 ]; then
    echo "Kontener nie istnieje"
    exit 1
fi

curl -s localhost:8080 > /dev/null
if [ $? -ne 0 ]; then
    curl -s localhost:80 > /dev/null
    if [ $? -eq 0 ]; then
        echo "Konfiguracja nie jest zastosowana"
    else
        echo "Nie udało się połączyć z serwerem"
    fi

    exit 1
fi

echo "Wszystko działa"
exit 0
