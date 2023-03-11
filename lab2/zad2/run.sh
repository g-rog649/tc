#!/bin/bash
docker build -t zad-2 .
docker run --name zad-2 -p 8080:8080 -d zad-2
