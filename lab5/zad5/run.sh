#!/bin/bash
docker build -t lab5-zad5 .
docker run --rm -p 80:80 -it lab5-zad5
