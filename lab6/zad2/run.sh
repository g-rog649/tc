#!/bin/bash
docker network create my_network
docker run \
	--rm \
	-d \
	--name db \
	-e MONGO_INITDB_ROOT_USERNAME=root \
	-e MONGO_INITDB_ROOT_PASSWORD=pass123 \
	--network my_network \
	mongo:4.4.19

docker build -t lab6-zad2 .
docker run --rm -it --name web -p 8080:8080 --network my_network lab6-zad2
docker rm -f db
docker network rm my_network
