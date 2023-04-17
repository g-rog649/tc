#!/bin/bash
docker network create frontend_network
docker network create backend_network

docker run \
	--rm \
	-d \
	--name db \
	-e MONGO_INITDB_ROOT_USERNAME=root \
	-e MONGO_INITDB_ROOT_PASSWORD=pass123 \
	--network backend_network \
	mongo:4.4.19

docker build -t lab6-zad3-frontend -f frontend.docker ./frontend
docker build -t lab6-zad3-backend -f backend.docker ./backend

docker run \
	--rm -d \
	--name backend \
	--network backend_network \
	lab6-zad3-backend

docker run \
	--rm -d \
	--name frontend \
	--network frontend_network \
	-p 8080:8080 \
	lab6-zad3-frontend

docker network connect frontend_network backend

docker attach frontend
