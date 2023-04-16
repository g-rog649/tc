#!/bin/bash
docker network create --driver bridge --subnet 192.168.1.1/24 my_bridge
docker run -d --rm --name my_nginx nginx
docker network connect my_bridge my_nginx

