#!/bin/bash
curl -sS -H "Content-Type: application/json" \
    -d '{
        "firstName": "Mark",
        "lastName": "Zuckerberg",
        "yearOfBirth": 1984
    }' \
    localhost:8080/users | python3 -m json.tool

curl -sS -H "Content-Type: application/json" \
    -d '{
        "firstName": "Elon",
        "lastName": "Musk",
        "yearOfBirth": 1971
    }' \
    localhost:8080/users | python3 -m json.tool

curl -sS localhost:8080/users | python3 -m json.tool
