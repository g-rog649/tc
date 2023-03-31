#!/bin/bash
docker build -t lab5-zad3 .
export $(cat myapp/.env)
docker run -p "$FLASK_RUN_PORT:$FLASK_RUN_PORT" -it lab5-zad3
