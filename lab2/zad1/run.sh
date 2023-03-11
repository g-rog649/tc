#!/bin/bash
docker build -t zad-1 .
docker run -p 8080:8080 -d zad-1
