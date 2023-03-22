#!/bin/bash
docker create --name nginx_srv -p 8080:8080 nginx
docker cp ./conf.d nginx_srv:/etc/nginx
docker start nginx_srv
