#!/bin/bash
docker build -t lab5-zad4 .
docker run --rm -p 3000:3000 -it lab5-zad4
