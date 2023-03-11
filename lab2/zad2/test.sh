#!/bin/bash
output=$(curl -s localhost:8080)

if [ $? -ne 0 ]; then
    echo "Błąd!"
elif ! echo $output | grep -qP '^(?=.*date)(?=.*time)'; then
    echo "Zły format!"
else
    echo "Wszystko działa!"
    echo "Tekst: $output"
    exit 0
fi

exit 1
