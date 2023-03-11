#!/bin/bash
output=$(curl localhost:8080)

if [ $? -ne 0 ]; then
    echo "Błąd!"
elif [ "$output" != "Hello World" ]; then
    echo "Zła wiadomość z serwera"
    echo "$output"
else
    echo "Wszystko działa!"
    exit 0
fi

exit 1
