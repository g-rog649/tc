#!/bin/bash
containers=$(docker ps -a --format "{{.Names}}")
if ! echo $containers | grep -Eq "$(basename $PWD)-proxy-1"; then
    echo "Kontener proxy nie istnieje"
    exit 1
elif ! echo $containers | grep -Eq "$(basename $PWD)-web-1"; then
    echo "Kontener web nie istnieje"
    exit 1
fi

tmp_file=$(mktemp)
curl -iks https://localhost > $tmp_file
website_content=$(cat $tmp_file)
if [ $? -ne 0 ]; then
    echo "Nie udało się połączyć z serwerem"
    exit 1
elif ! echo $website_content | grep -q 'Witam'; then
    echo "Proxy nie działa"
    exit 1
elif ! echo $website_content | grep -q 'Cache'; then
    echo "Cache nie działa"
    exit 1
fi

echo "Wszystko działa"
exit 0
